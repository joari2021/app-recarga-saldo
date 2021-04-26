class Recharge < ApplicationRecord
  belongs_to :user
  include ValidationsMethodsConcern

  #METODOS PARA VALIDAR EL MONTO
  def recharge_limit_is_1400000?
    operator === "Digitel" && type_payment === "Prepago"
  end

  def recharge_limit_is_1500000?
    operator === "Movistar" && type_payment === "Prepago"
  end

  def recharge_limit_is_800000?
    operator === "Movilnet" && type_payment === "Prepago"
  end

  validates :operator, inclusion: { in: %w(Movistar Movilnet Digitel Cantv Movistar_TV Inter Simple_TV),
    message: "El sistema seleccionado es invalido" }

  validates :type_payment, 
    exclusion: { in: %w(Prepago), message: "Tipo de pago inválido", if: :operador_is_only_postpago? }, 
    exclusion: { in: %w(Post-pago), message: "Tipo de pago inválido", if: :operator_is_only_prepago? },
    inclusion: { in: %w(Prepago Post-pago), message: "Tipo de pago inválido"}
    
  validates :cod_area, inclusion: { in: %w(0414 0424 0212 0234 0235 0238 0239 0240 0241 0242 0243 0244 0245 0246 0247 0248 0249 0251 0252 0253 0254 0255 0256 0257 0258 0259 0261 0262 0263 0264 0265 0266 0267 0268 0269 0270 0271 0272 0273 0274 0275 0276 0277 0278 0279 0281 0282 0283 0284 0285 0286 0287 0288 0289 0291 0292 0293 0294 0295), message: "Codigo de área inválido", if: :number_is_movistar? }
  validates :cod_area, inclusion: { in: %w(0416 0426), message: "Codigo de área inválido", if: :number_is_movilnet? }
  validates :cod_area, inclusion: { in: %w(0412 0212 0234 0235 0238 0239 0240 0241 0242 0243 0244 0245 0246 0247 0248 0249 0251 0252 0253 0254 0255 0256 0257 0258 0259 0261 0262 0263 0264 0265 0266 0267 0268 0269 0270 0271 0272 0273 0274 0275 0276 0277 0278 0279 0281 0282 0283 0284 0285 0286 0287 0288 0289 0291 0292 0293 0294 0295), message: "Codigo de área inválido", if: :number_is_digitel? }
  validates :cod_area, inclusion: { in: %w(0212 0234 0235 0238 0239 0240 0241 0242 0243 0244 0245 0246 0247 0248 0249 0251 0252 0253 0254 0255 0256 0257 0258 0259 0261 0262 0263 0264 0265 0266 0267 0268 0269 0270 0271 0272 0273 0274 0275 0276 0277 0278 0279 0281 0282 0283 0284 0285 0286 0287 0288 0289 0291 0292 0293 0294 0295), message: "Codigo de área inválido", if: :number_is_cantv? }

  validates :number, length: { is: 7, message: "Debe contener 7 dígitos.", if: :number_length_7? },
  numericality: { only_integer: true, message: "Este campo solo debe contener números." }
  validates :number, length: { is: 8, message: "Debe contener 8 dígitos.", if: :number_length_8? }
  validates :number, length: { is: 10, message: "Debe contener 10 dígitos.", if: :number_length_10? }
  validates :number, length: { is: 12, message: "Debe contener 12 dígitos.", if: :number_length_12? }
    
  #CONTINUAR SEGUN LOS PARAMETROS FINALES DEL MONTO PERMITIDOS PARA LAS RECARGAS
  validates :amount, numericality: { greater_than_or_equal_to: 1400000, message: "El monto es inválido", if: :recharge_limit_is_1400000? }
  validates :amount, numericality: { greater_than_or_equal_to: 1500000, message: "El monto es inválido", if: :recharge_limit_is_1500000? }
  validates :amount, numericality: { greater_than_or_equal_to: 800000, message: "El monto es inválido", if: :recharge_limit_is_800000? }
end
