class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]

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

    @contact.operator.downcase!
    @contact.type_payment.downcase!
    @contact.operator.gsub!(' ','_')
    
    respond_to do |format|
      if @contact.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @contact.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
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
end
