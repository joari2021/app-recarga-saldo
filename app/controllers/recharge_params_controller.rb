class RechargeParamsController < ApplicationController
  before_action :set_recharge_param, only: %i[ show edit update destroy ]

  # GET /recharge_params or /recharge_params.json
  def index
    @recharge_params = RechargeParam.all
  end

  # GET /recharge_params/1 or /recharge_params/1.json
  def show
  end

  # GET /recharge_params/new
  def new
    @recharge_param = RechargeParam.new
  end

  # GET /recharge_params/1/edit
  def edit
  end

  # POST /recharge_params or /recharge_params.json
  def create
    @recharge_param = RechargeParam.new(recharge_param_params)

    respond_to do |format|
      if @recharge_param.save
        format.html { redirect_to @recharge_param, notice: "Recharge param was successfully created." }
        format.json { render :show, status: :created, location: @recharge_param }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recharge_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recharge_params/1 or /recharge_params/1.json
  def update
    respond_to do |format|
      if @recharge_param.update(recharge_param_params)
        format.html { redirect_to @recharge_param, notice: "Recharge param was successfully updated." }
        format.json { render :show, status: :ok, location: @recharge_param }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recharge_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recharge_params/1 or /recharge_params/1.json
  def destroy
    @recharge_param.destroy
    respond_to do |format|
      format.html { redirect_to recharge_params_url, notice: "Recharge param was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recharge_param
      @recharge_param = RechargeParam.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recharge_param_params
      params.require(:recharge_param).permit(:operadora, :amount_min, :amount_max, :multiplos_amount_permit)
    end
end
