module ValidationsMethodsConcern
    
  #METODOS PARA VALIDAR TIPO DE PAGO
  def operator_is_only_prepago?
    operator === "Movilnet" || operator === "Movistar_TV" || operator === "Simple_TV"
  end

  def operador_is_only_postpago?
    operator === "Cantv"
  end

  #METODOS PARA VALIDAR CODIGO DE AREA
  def number_is_movistar?
    operator === "Movistar" && type_payment === "Prepago"
  end

  def number_is_movilnet?
    operator === "Movilnet"
  end

  def number_is_digitel?
    operator === "Digitel"
  end

  def number_is_cantv?
    operator === "Cantv" && type_payment === "Post-pago"
  end

  #METODOS PARA VALIDAR NUMERO
  def number_length_7?
    operator === "Movistar" && type_payment === "Prepago" || operator === "Digitel" || operator === "Movilnet" && type_payment === "Prepago" || operator === "Cantv" && type_payment === "Post-pago"
  end

  def number_length_8?
    operator === "Movistar_TV" && type_payment === "Prepago"
  end

  def number_length_10?
    operator === "Movistar" && type_payment === "Post-pago" || operator === "Inter"
  end

  def number_length_12?
    operator === "Simple_TV" && type_payment === "Prepago"
  end
end