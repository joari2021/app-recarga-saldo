class RechargesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_register!
  before_action :authenticate_admin, only: [:process_recharges]
  before_action :set_recharge, only: %i[ show edit update destroy ]
  before_action :set_variables_recharge, only: %i[ index new create]
  before_action :verify_exist_number, only: [:create]
  before_action :verify_consulta!, only: [:create] 
  before_action :format_params_recharge, only: [:create] 
  before_action :format_update_params_recharge, only: [:update] 
  before_action :rectify_amount, only: [:create, :update]


  # GET /recharges or /recharges.json
  def index
    #@recharges = Recharge.all
    date_final = Time.now.utc.in_time_zone("Caracas").strftime("%Y-%m-%d") 
    parsed_date_f = Date.parse(date_final)

    consultas = current_user.recharges.where(type_operation: "consultation", status: ["confirmada","anulada"])
    consultas_vencidas = consultas.where.not(created_at: parsed_date_f.midnight..parsed_date_f.end_of_day)
    consultas_vencidas.destroy_all
  end

  def historial
      if current_user.is_admin?
        @recharges = Recharge.all
                             .where.not(type_operation:"consultation")
                             .order("created_at DESC")
                             .paginate(page: params[:page], per_page: 20)
      else
        @recharges = current_user.recharges.where.not(type_operation:"consultation")
                                           .order("created_at DESC")
                                           .paginate(page: params[:page], per_page: 20)
      end
  end

  # GET /recharges/1 or /recharges/1.json
  #def show
  #end

  # GET /recharges/new
  def new
    @recharge = Recharge.new
  end

  # GET /recharges/1/edit
  def edit
  end

  # POST /recharges or /recharges.json
  def create
    ActiveRecord::Base.transaction do
      @recharge = current_user.recharges.create(recharge_params)

      #ESTABLECIENDO EL TIPO DE OPERACION
      if @recharge.operator === "Movistar" || @recharge.operator === "Digitel" || @recharge.operator === "Inter"
        if @recharge.type_payment === "Post-pago"
          @recharge.update(type_operation: "consultation")
        else
          @recharge.update(type_operation: "direct_recharge")
        end
      else
        @recharge.update(type_operation: "direct_recharge")
      end
     
      #ACTUALIZANDO EL BALANCE
      if @recharge.save && @recharge.type_operation === "direct_recharge"
        balance_final = current_user.balance.balance -= @recharge.amount

        ActiveRecord::Rollback unless current_user.balance.update(balance: balance_final)

      elsif @recharge.type_operation != "direct_recharge"
        @recharge.amount = 0.0
      end
    end      

    respond_to do |format|
      
      if @recharge.save
        if recharge_params_special[:save_number]
          unless current_user.contacts.where(number: @recharge.number).any?
            cod_area = @recharge.operator === "Movistar" && @recharge.type_payment === "Prepago" || @recharge.operator === "Digitel" ||@recharge.operator === "Movilnet" || @recharge.operator === "Cantv" ? @recharge.cod_area : nil
            
            @contact = current_user.contacts.create(operator: @recharge.operator, type_payment: @recharge.type_payment, cod_area: cod_area, number: @recharge.number, names: recharge_params_special[:names])
          else
            @contact_registrado = true
          end
        end
        
        format.json {head :no_content}
        format.js      
      else
        format.json { render json: @recharge.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /recharges/1 or /recharges/1.json
  def update
    save_success = false
    respond_to do |format|
      if current_user.id === @recharge.user.id
        if @recharge.type_operation === "consultation" && @recharge.status === "confirmada"
          ActiveRecord::Base.transaction do
            if @recharge.update(status:"enviada",type_operation:"direct_recharge")
              balance_final = current_user.balance.balance -= @recharge.amount
              ActiveRecord::Rollback unless current_user.balance.update(balance: balance_final) && save_success = true
            end
          end
        end
      elsif current_user.is_admin?
        ActiveRecord::Base.transaction do
          if @recharge.update(update_recharge_params) && save_success = true

            #AÑADIR NUMERO INEXISTENTE A LA LISTA NEGRA
            if @recharge.status === "anulada"
              @recharge.marcar_number_as_inexistente
            end

            # REINTEGRAR MONTO DE LA RECARGA AL BALANCE DEL USUARIO SI LA MISMA ES ANULADA
            if @recharge.type_operation === "direct_recharge" && @recharge.status === "anulada"
              balance_final = @recharge.user.balance.balance += @recharge.amount
              ActiveRecord::Rollback unless @recharge.user.balance.update(balance: balance_final)

              if balance_final != @recharge.user.balance.balance
                save_success = false
              end
            end
            
            #SUMAR 5% AL MONTO DE LAS RECARGAS DE SERVICIOS POST-PAGO MOVISTAR Y DIGITEL 
            if @recharge.type_operation === "consultation" && @recharge.status === "confirmada" && @recharge.operator != "Inter"
              monto_final = @recharge.amount * 1.05
              ActiveRecord::Rollback unless @recharge.update(amount: monto_final)

              unless @recharge.amount >= monto_final  
                save_success = false
              end
            end
            
            #CALCULAR SALDO RESULTANTE DESPUES DE UNA RECARGA A NUMEROS CANTV
            if @recharge.status === "confirmada" && @recharge.operator === "Cantv"
              saldo_final = @recharge.saldo_resultante + (@recharge.amount / 1.05)
              ActiveRecord::Rollback unless @recharge.update(saldo_resultante: saldo_final)

              unless @recharge.saldo_resultante != update_recharge_params[:saldo_resultante].to_f  
                save_success = false
              end
            end

            #CALCULAR DEUDA FALTANTE DESPUES DE UNA RECARGA A NUMEROS INTER
            if @recharge.status === "confirmada" && @recharge.operator === "Inter" && @recharge.type_payment === "Prepago"
              renta_final = @recharge.renta_mensual - @recharge.amount 
              ActiveRecord::Rollback unless @recharge.update(renta_mensual: renta_final)

              unless @recharge.renta_mensual != update_recharge_params[:renta_mensual].to_f  
                save_success = false
              end
            end
          end    
        end
      end
      
      #REDIGIR
      if save_success
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @recharge.errors.full_messages, status: :unprocessable_entity }
        format.js {render :edit}
      end
    end
  end

  # DELETE /recharges/1 or /recharges/1.json
  def destroy
    if current_user.id === @recharge.user.id
      if @recharge.type_operation === "consultation" && @recharge.status === "anulada"
        @recharge.destroy
        respond_to do |format|
          format.json { head :no_content }
          format.js
        end
      end
    end
  end

  def process_recharges
    @recharges = Recharge.where(status: "enviada")
    @deposits = Deposit.where(status: "Diferido")
  end

  private
    
    def set_recharge
      @recharge = Recharge.find(params[:id])
    end

    def set_variables_recharge
      @params_movistar = RechargeParam.find_by(operadora:"Movistar")
      @params_digitel = RechargeParam.find_by(operadora:"Digitel")
      @params_movilnet = RechargeParam.find_by(operadora:"Movilnet")
      @params_cantv = RechargeParam.find_by(operadora:"Cantv")
      @params_movistar_tv = RechargeParam.find_by(operadora:"Movistar_TV")
      @params_inter = RechargeParam.find_by(operadora:"Inter")
      @params_simple_tv = RechargeParam.find_by(operadora:"Simple_TV")
    end

    def recharge_params
      params.require(:recharge).permit(:amount, :operator, :type_payment, :number, :cod_area)
    end

    def recharge_params_special
      params.require(:recharge).permit(:save_number,:names)
    end

    def update_recharge_params
      params.require(:recharge).permit(:operation)
    end

    def update_recharge_params
      params.require(:recharge).permit(:status,:amount,:renta_mensual,:saldo_resultante,:available_days,:number_inexistente)
    end

    def format_params_recharge
      recharge_params[:amount].gsub!('.','') unless recharge_params[:amount].nil?
      recharge_params[:amount].gsub!(',','.') unless recharge_params[:amount].nil?
    end

    def format_update_params_recharge
      update_recharge_params[:amount].gsub!('.','') unless update_recharge_params[:amount].nil?
      update_recharge_params[:amount].gsub!(',','.') unless update_recharge_params[:amount].nil?

      update_recharge_params[:renta_mensual].gsub!('.','') unless update_recharge_params[:renta_mensual].nil?
      update_recharge_params[:renta_mensual].gsub!(',','.') unless update_recharge_params[:renta_mensual].nil?
    end

    def verify_exist_number
      number = recharge_params[:cod_area].present? ? recharge_params[:cod_area] + recharge_params[:number] : recharge_params[:number]

      if NonexistentNumber.where(operator: recharge_params[:operator], type_payment: recharge_params[:type_payment], number: number).any?
        respond_to do |format|
          format.json {head :no_content}
          format.js { render :number_non_existent}
        end
      end
    end

    def rectify_amount
      unless recharge_params[:amount].to_f <= current_user.balance.balance
        respond_to do |format|
          format.json {head :no_content}
          format.js { render :balance_insuficiente}
        end
      end
    end

    def verify_consulta!
      if recharge_params[:type_payment] === "Post-pago" && recharge_params[:operator] != "Cantv"
           if current_user.recharges.where(number: recharge_params[:number], type_operation: "consultation").any?
                respond_to do |format|
                     format.json {head :no_content}
                     format.js { render :deneged_consulta}
                end
           end
      end
    end
end
