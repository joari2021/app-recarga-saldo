class Contact < ApplicationRecord
  belongs_to :user

  def self.buscador(names,operator,type_payment)
    Contact.where("names LIKE ? AND operator LIKE ? AND type_payment LIKE ?", "%#{names}%", "#{operator}", "#{type_payment}")
  end

  validates :phone, uniqueness: {message: "este número ya esta registrado"}
end
