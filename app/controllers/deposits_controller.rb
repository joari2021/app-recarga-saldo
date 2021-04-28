class DepositsController < ApplicationController
  before_action :authenticate_admin, only: [:edit, :update, :destroy]
  before_action :set_deposit, only: %i[show edit update destroy]
  before_action :format_params_deposit, only: [:create]

  # GET /deposits or /deposits.json
  def index
    @deposits = Deposit.all
  end

  # GET /deposits/1 or /deposits/1.json
  def show; end

  # GET /deposits/new
  def new
    @deposit = Deposit.new
  end

  # GET /deposits/1/edit
  def edit; end

  # POST /deposits or /deposits.json
  def create
    @deposit = current_user.deposits.create(deposit_params)

    respond_to do |format|
      if @deposit.save
        format.json { head :no_content }
        format.js
      else
        bank_destinity = @deposit.bank_destinity.gsub("_"," ")
        @deposit.bank_destinity = bank_destinity

        method_payment = @deposit.method_payment.gsub("_"," ")
        @deposit.method_payment = method_payment

        format.json { render json: @deposit.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /deposits/1 or /deposits/1.json
  def update
    if update_deposit_params[:operation] === "confirm"
      ActiveRecord::Base.transaction do
        respond_to do |format|
          if @deposit.update(status:"confirmado")

            balance_final = @deposit.user.balance.balance += @deposit.amount
            ActiveRecord::Rollback unless @deposit.user.balance.update(balance: balance_final)

            format.json { head :no_content }
            format.js
          else
            format.json { render json: @deposit.errors.full_messages, status: :unprocessable_entity }
            format.js {render :edit}   
          end
        end
      end
    elsif update_deposit_params[:operation] === "deneged"
      respond_to do |format|
        if @deposit.update(status:"anulado")
          format.json { head :no_content }
          format.js
        else
          format.json { render json: @deposit.errors.full_messages, status: :unprocessable_entity }
          format.js {render :edit}   
        end
      end
    end
  end

  # DELETE /deposits/1 or /deposits/1.json
  def destroy
    @deposit.destroy
    respond_to do |format|
      format.html { redirect_to deposits_url, notice: 'Deposit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def process_deposits
    @deposits = Deposit.where(status:"Diferido")
    @recharges = Recharge.where(status: "enviada")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_deposit
    @deposit = Deposit.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def deposit_params
    params.require(:deposit).permit(:amount, :bank_destinity, :status, :method_payment, :date_send, :ref_payment)
  end

  def update_deposit_params
    params.require(:deposit).permit(:operation)
  end

  def format_params_deposit
    deposit_params[:bank_destinity].gsub!(' ','_')
    deposit_params[:method_payment].gsub!(' ','_')
    deposit_params[:amount].gsub!('.','')
    deposit_params[:amount].gsub!(',','.')
  end
end
