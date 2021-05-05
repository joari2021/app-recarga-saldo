class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_register!
  before_action :set_contact, only: %i[ show edit update destroy ]
  before_action :format_params_contact, only: [:create,:update]
  before_action :verify_number_not_register, only: [:create]

  # GET /contacts or /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1 or /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts or /contacts.json
  def create
    @contact = current_user.contacts.create(contact_params)

    respond_to do |format|
      if @contact.save
        format.json { head :no_content }
        format.js
      else
        format_params_contact_reverse()
        
        format.json { render json: @contact.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_update_params)
          format.json {head :no_content}
          format.js
      else
          format.json { render json: @contact.error.full_messages, status: :unprocessable_entity }
          format.js { render :edit }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.js
      format.json { head :no_content }
    end
  end

  def buscador
    @resultados = Contact.buscador(params[:names],params[:operator],params[:type_payment]).map do |contact|
      {
          id: contact.id,
          names_contact: contact.names,
          cod_area: contact.cod_area.nil? ? "" : contact.cod_area,
          number_contact: contact.number
      }
    end

    respond_to do |format|
      format.json { render :json => @resultados }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:names, :operator, :type_payment, :number, :cod_area)
    end

    def contact_update_params
      params.require(:contact).permit(:names)
    end

    def format_params_contact
      contact_params[:operator].gsub!(' ','_')
      contact_params[:type_payment].gsub!(' ','_')
    end

    def format_params_contact_reverse
      operator = @contact.operator.gsub("_"," ")
      @contact.operator = operator

      type_payment = @contact.type_payment.gsub("_"," ")
      @contact.type_payment = type_payment
    end

    def verify_number_not_register
      if current_user.contacts.where(number: contact_params[:number]).any?
        respond_to do |format|
            format.json { head :no_content }
            format.js { render :number_registrado }
        end
      end
    end
end
