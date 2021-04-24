class Deposit < ApplicationRecord
  belongs_to :user

  validates :date_send, :amount, presence: {message: "Fecha incorrecta"}

  validates :bank_destinity, inclusion: { in: %w(Banco_de_Venezuela Banco_Bicentenario Banco_Bancaribe Banco_B.O.D Banco_Mercantil), message: "Banco inválido." }

  validates :method_payment, inclusion: { in: %w(Transferencia Pago_móvil), message: "Metodo de pago inválido." }

  validates :ref_payment, format: {with: /\A[+-]?\d+\z/, message: "Este campo solo acepta números."},  length: { in: 4..10, message: "Este campo requiere minimo 4 digitos y máximo 10 digitos." }

  validates :amount, numericality: { greater_than_or_equal_to: 2000000, message: "El monto debe ser superior a la compra minima (Bs 2.000.000,00)."}
end
