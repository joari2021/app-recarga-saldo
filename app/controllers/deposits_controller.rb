class DepositsController < ApplicationController
  before_action :set_deposit, only: %i[show edit update destroy]
  before_action :format_params, only: [:create]

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
    respond_to do |format|
      if @deposit.update(deposit_params)
        format.html { redirect_to @deposit, notice: 'Deposit was successfully updated.' }
        format.json { render :show, status: :ok, location: @deposit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_deposit
    @deposit = Deposit.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def deposit_params
    params.require(:deposit).permit(:amount, :bank_destinity, :status, :method_payment, :date_send, :ref_payment)
  end
end
