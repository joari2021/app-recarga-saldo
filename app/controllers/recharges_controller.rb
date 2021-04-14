class RechargesController < ApplicationController
  before_action :set_recharge, only: %i[ show edit update destroy ]
  before_action :set_variables_recharge, only: %I[index new]

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
  def show
  end

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
      
      if @recharge.amount <= current_user.balance.balance
        balance_final = current_user.balance.balance -= @recharge.amount
        ActiveRecord::Rollback unless current_user.balance.update(balance: balance_final)

        @recharge.verify_type_payment
        @recharge.verify_operator
        @recharge.set_type_operation

        respond_to do |format|
          if @recharge.save
            if recharge_params_special[:save_number]
              cod_area = @recharge.operator === "movistar" && @recharge.type_payment === "pre-pago" || @recharge.operator === "digitel" ||@recharge.operator === "movilnet" || @recharge.operator === "cantv" ? @recharge.cod_area : nil
              
              @contact = current_user.contacts.create(operator: @recharge.operator, type_payment: @recharge.type_payment, cod_area: cod_area, phone: @recharge.phone, names: recharge_params_special[:names])
              if @contact.save
                @contact_save = true
              else
                @contact_save = false
              end
            end

            format.json {head :no_content}
            format.js
          else
            ActiveRecord::Rollback

            format.json { render json: @recharge.errors.full_messages, status: :unprocessable_entity }
            format.js { render :new }
          end
        end
      else
        respond_to do |format|
          format.json {head :no_content}
          format.js 
        end
      end
    end 
  end

  # PATCH/PUT /recharges/1 or /recharges/1.json
  def update
    if @recharge.type_operation === "consultation" && @recharge.status === "procesada"
      respond_to do |format|
        if @recharge.update(status:"enviada",type_operation:"recharge")
          format.json { head :no_content }
          format.js
        else
          format.json { render json: @recharge.errors.full_messages, status: :unprocessable_entity }
          format.js { render :edit }
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
    def verify_amount(recharge)
      
    end
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
      params.require(:recharge).permit(:amount, :operator, :type_payment, :phone, :cod_area)
    end

    def recharge_params_special
      params.require(:recharge).permit(:save_number,:names)
    end

    
end
