class Recharge < ApplicationRecord
  belongs_to :user

  def verify_operator
    array_operator = ["movistar", "movilnet", "digitel", "cantv", "inter", "movistar_tv", "simple_tv"]

    unless array_operator.include?(self.operator) 
      self.operator = ""
    end
  end

  def verify_type_payment 
    array_type_payment = ["pre-pago","post-pago"]

    unless array_type_payment.include?(self.type_payment) 
      self.type_payment = ""
    end
  end

  def set_type_operation
    if self.operator === "movistar" || self.operator === "digitel" || self.operator === "inter"
      if self.type_payment === "post-pago"
        self.type_operation = "consultation"
      end
    end
  end

  validates :operator, :type_payment, presence: { message:" Este dato es incorrecto" }
end
