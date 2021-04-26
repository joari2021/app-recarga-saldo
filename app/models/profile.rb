class Profile < ApplicationRecord
    belongs_to :user
    
    validates :name, :last_name, :state, :city, length: { in: 3..20, message: "Debe contener minimo 3 caracteres y máximo 20." }
    validates :age, length: { is: 2, message: "Debe contener 2 digitos." }
    validates :document, length: { in: 6..9, message: "Debe contener minimo 6 caracteres y máximo 9." }
    validates :phone, length: { is: 11, message: "Debe contener 11 digitos." }
    validates :zip_code, length: { is: 4, message: "Debe contener 4 digitos." }
    validates :address, length: { maximum: 100, message: "No debe contener más de 100 carácteres." }

    validates :gender, inclusion: { in: %w(Hombre Mujer), message: "Opción invalida." }
    validates :type_document, inclusion: { in: %w(V E P J), message: "Opción invalida." }

    validates :age, :document, :phone, :zip_code, numericality: { only_integer: true, message: "Este campo solo debe contener números." }
end
