class NonexistentNumbersController < ApplicationController
  before_action :authenticate_admin
  before_action :set_nonexistent_number, only: %i[ show edit update destroy ]

  # GET /nonexistent_numbers or /nonexistent_numbers.json
  def index
    @nonexistent_numbers = NonexistentNumber.all
  end

  # GET /nonexistent_numbers/1 or /nonexistent_numbers/1.json
  def show
  end

  # GET /nonexistent_numbers/new
  def new
    @nonexistent_number = NonexistentNumber.new
  end

  # GET /nonexistent_numbers/1/edit
  def edit
  end

  # POST /nonexistent_numbers or /nonexistent_numbers.json
  def create
    @nonexistent_number = NonexistentNumber.new(nonexistent_number_params)

    respond_to do |format|
      if @nonexistent_number.save
        format.html { redirect_to @nonexistent_number, notice: "Nonexistent number was successfully created." }
        format.json { render :show, status: :created, location: @nonexistent_number }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nonexistent_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nonexistent_numbers/1 or /nonexistent_numbers/1.json
  def update
    respond_to do |format|
      if @nonexistent_number.update(nonexistent_number_params)
        format.html { redirect_to @nonexistent_number, notice: "Nonexistent number was successfully updated." }
        format.json { render :show, status: :ok, location: @nonexistent_number }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nonexistent_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nonexistent_numbers/1 or /nonexistent_numbers/1.json
  def destroy
    @nonexistent_number.destroy
    respond_to do |format|
      format.html { redirect_to nonexistent_numbers_url, notice: "Nonexistent number was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nonexistent_number
      @nonexistent_number = NonexistentNumber.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nonexistent_number_params
      params.require(:nonexistent_number).permit(:operator, :type_payment, :number)
    end
end
