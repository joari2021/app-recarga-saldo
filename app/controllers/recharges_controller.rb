class RechargesController < ApplicationController
  before_action :set_recharge, only: %i[ show edit update destroy ]
  before_action :set_variables_recharge, only: %I[index new]

  # GET /recharges or /recharges.json
  def index
    #@recharges = Recharge.all
    
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
    @recharge = current_user.recharges.create(recharge_params)

    respond_to do |format|
      if @recharge.save
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
    respond_to do |format|
      if @recharge.update(recharge_params)
        format.html { redirect_to @recharge, notice: "Recharge was successfully updated." }
        format.json { render :show, status: :ok, location: @recharge }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recharge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recharges/1 or /recharges/1.json
  def destroy
    @recharge.destroy
    respond_to do |format|
      format.html { redirect_to recharges_url, notice: "Recharge was successfully destroyed." }
      format.json { head :no_content }
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
      params.require(:recharge).permit(:amount, :operator, :type_payment, :phone, :cod_area)
    end
end
