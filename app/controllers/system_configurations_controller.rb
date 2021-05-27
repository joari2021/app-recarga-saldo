class SystemConfigurationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_system_configuration, only: %i[ show edit update destroy ]

  # GET /system_configurations or /system_configurations.json
  def index
    @system_configurations = SystemConfiguration.all
  end

  # GET /system_configurations/1 or /system_configurations/1.json
  def show
  end

  # GET /system_configurations/new
  def new
    @system_configuration = SystemConfiguration.new
  end

  # GET /system_configurations/1/edit
  def edit
  end

  # POST /system_configurations or /system_configurations.json
  def create
    @system_configuration = SystemConfiguration.new(system_configuration_params)

    respond_to do |format|
      if @system_configuration.save
        format.html { redirect_to @system_configuration, notice: "System configuration was successfully created." }
        format.json { render :show, status: :created, location: @system_configuration }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @system_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_configurations/1 or /system_configurations/1.json
  def update
    respond_to do |format|
      if @system_configuration.update(system_configuration_params)
        format.html { redirect_to @system_configuration, notice: "System configuration was successfully updated." }
        format.json { render :show, status: :ok, location: @system_configuration }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @system_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_configurations/1 or /system_configurations/1.json
  def destroy
    @system_configuration.destroy
    respond_to do |format|
      format.html { redirect_to system_configurations_url, notice: "System configuration was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_configuration
      @system_configuration = SystemConfiguration.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def system_configuration_params
      params.require(:system_configuration).permit(:movistar, :digitel, :movilnet, :cantv, :movistar_tv, :inter, :simple_tv, :dolar_bcv)
    end
end
