class Deposit < ApplicationRecord
  belongs_to :user

  include AASM

  aasm column: "state" do
    state :ontried, initial: true
    state :viewed

    event :watch do
      transitions from: :ontried, to: :viewed
    end
  end

  def account_type_two?
    bank_destinity === "Banco_de_Venezuela"
  end

  def account_type_one?
    bank_destinity != "Banco_de_Venezuela"
  end
  
  validates :date_send, :amount, presence: {message: "Fecha incorrecta"}

  validates :bank_destinity, inclusion: { in: %w(Banco_de_Venezuela Banco_Bicentenario Banco_Bancaribe Banco_B.O.D Banco_Mercantil veMonedero), message: "Banco inválido." }

  validates :method_payment, inclusion: { in: %w(Transferencia Pago_móvil), message: "Metodo de pago inválido.", if: :account_type_two? }
  validates :method_payment, inclusion: { in: %w(Transferencia), message: "Metodo de pago inválido.", if: :account_type_one? }

  validates :ref_payment, format: {with: /\A[+-]?\d+\z/, message: "Este campo solo acepta números."},  length: { in: 4..10, message: "Este campo requiere minimo 4 digitos y máximo 10 digitos." }

  validates :amount, numericality: { greater_than_or_equal_to: 5000000, message: "El monto debe ser igual o superior al deposito mínimo (Bs 5.000.000,00)."}
end
