class AcoountsController < ApplicationController
  before_action :set_acoount, only: %i[ show edit update destroy ]

  # GET /acoounts or /acoounts.json
  def index
    @acoounts = Acoount.all
  end

  # GET /acoounts/1 or /acoounts/1.json
  def show
  end

  # GET /acoounts/new
  def new
    @acoount = Acoount.new
  end

  # GET /acoounts/1/edit
  def edit
  end

  # POST /acoounts or /acoounts.json
  def create
    @acoount = Acoount.new(acoount_params)

    respond_to do |format|
      if @acoount.save
        format.html { redirect_to @acoount, notice: "Acoount was successfully created." }
        format.json { render :show, status: :created, location: @acoount }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @acoount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acoounts/1 or /acoounts/1.json
  def update
    respond_to do |format|
      if @acoount.update(acoount_params)
        format.html { redirect_to @acoount, notice: "Acoount was successfully updated." }
        format.json { render :show, status: :ok, location: @acoount }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @acoount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acoounts/1 or /acoounts/1.json
  def destroy
    @acoount.destroy
    respond_to do |format|
      format.html { redirect_to acoounts_url, notice: "Acoount was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acoount
      @acoount = Acoount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def acoount_params
      params.require(:acoount).permit(:bank, :document, :type_document, :number_account, :phone, :user_id)
    end
end
