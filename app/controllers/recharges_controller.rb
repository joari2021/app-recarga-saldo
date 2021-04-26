class RechargesController < ApplicationController
  before_action :set_recharge, only: %i[ show edit update destroy ]
  before_action :set_variables_recharge, only: %i[ index new create]
  before_action :verify_consulta!, only: [:create] 
  before_action :format_params_recharge, only: [:create] 
  before_action :rectify_amount, only: [:create, :update]

  # GET /recharges or /recharges.json
  def index
    #@recharges = Recharge.all
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
      if @recharge.type_operation === "direct_recharge"
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
    ActiveRecord::Base.transaction do
      if @recharge.type_operation === "consultation" && @recharge.status === "procesada"
        respond_to do |format|
          if @recharge.update(status:"enviada",type_operation:"direct_recharge")
            balance_final = current_user.balance.balance -= @recharge.amount
            ActiveRecord::Rollback unless current_user.balance.update(balance: balance_final)
            
            format.json { head :no_content }
            format.js
          else
            format.json { render json: @recharge.errors.full_messages, status: :unprocessable_entity }
            format.js { render :edit }
          end
        end
      end
    end
  end

  # DELETE /recharges/1 or /recharges/1.json
  def destroy
    @recharge.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_recharge
      @recharge = Recharge.find(params[:id])
    end

    def set_variables_recharge
      @params_movistar = RechargeParam.find_by(operadora:"movistar")
      @params_digitel = RechargeParam.find_by(operadora:"digitel")
      @params_movilnet = RechargeParam.find_by(operadora:"movilnet")
      @params_cantv = RechargeParam.find_by(operadora:"cantv")
      @params_movistar_tv = RechargeParam.find_by(operadora:"movistar_tv")
      @params_inter = RechargeParam.find_by(operadora:"inter")
      @params_simple_tv = RechargeParam.find_by(operadora:"simple_tv")
    end

    # Only allow a list of trusted parameters through.
    def recharge_params
      params.require(:recharge).permit(:amount, :operator, :type_payment, :number, :cod_area)
    end

    def recharge_params_special
      params.require(:recharge).permit(:save_number,:names)
    end

    def format_params_recharge
      recharge_params[:amount].gsub!('.','')
      recharge_params[:amount].gsub!(',','.')
    end

    def rectify_amount
      unless recharge_params[:amount].to_f <= current_user.balance.balance
        respond_to do |format|
          format.json {head :no_content}
          format.js { render :balance_insuficiente}
        end
      end
    end
end
