class BalaceInquiriesController < ApplicationController
  before_action :set_balace_inquiry, only: %i[ show edit update destroy ]

  # GET /balace_inquiries or /balace_inquiries.json
  def index
    @balace_inquiries = BalaceInquiry.all
  end

  # GET /balace_inquiries/1 or /balace_inquiries/1.json
  def show
  end

  # GET /balace_inquiries/new
  def new
    @balace_inquiry = BalaceInquiry.new
  end

  # GET /balace_inquiries/1/edit
  def edit
  end

  # POST /balace_inquiries or /balace_inquiries.json
  def create
=begin
    @balace_inquiry = BalaceInquiry.new(balace_inquiry_params)

    respond_to do |format|
      if @balace_inquiry.save
        format.html { redirect_to @balace_inquiry, notice: "Balace inquiry was successfully created." }
        format.json { render :show, status: :created, location: @balace_inquiry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @balace_inquiry.errors, status: :unprocessable_entity }
      end
    end
=end

    @balace_inquiry = current_user.balace_inquiries.create(balace_inquiry_params)

    respond_to do |format|
      if @balace_inquiry.save
        format.json {head :no_content}
        format.js
      else
        format.json { render json: @balace_inquiry.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /balace_inquiries/1 or /balace_inquiries/1.json
  def update
    respond_to do |format|
      if @balace_inquiry.update(balace_inquiry_params)
        format.html { redirect_to @balace_inquiry, notice: "Balace inquiry was successfully updated." }
        format.json { render :show, status: :ok, location: @balace_inquiry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @balace_inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /balace_inquiries/1 or /balace_inquiries/1.json
  def destroy
    @balace_inquiry.destroy
    respond_to do |format|
      format.html { redirect_to balace_inquiries_url, notice: "Balace inquiry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_balace_inquiry
      @balace_inquiry = BalaceInquiry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def balace_inquiry_params
      params.require(:balace_inquiry).permit(:debt, :avalaible_days, :operator, :cod_area, :phone, :status)
    end
end
