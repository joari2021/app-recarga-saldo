class Contact < ApplicationRecord
  belongs_to :user

  def self.buscador(names,operator,type_payment)
    Contact.where("names LIKE ? AND operator LIKE ? AND type_payment LIKE ?", "%#{names}%", "#{operator}", "#{type_payment}")
  end

  validates :phone, presence: {message: "Este campo no puede estar vacio"}

  validates :operator, inclusion: { in: %w(movistar movilnet digitel cantv movistar_tv inter simple_tv),
    message: "%{value}: Este valor no es valido" }
end
