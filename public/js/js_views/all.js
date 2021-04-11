function format_monto_entero(monto) {
  monto = monto.toString();
  valor = monto.replace(/\D/g, "");
  //valor = valor.replace(/([0-9])([0-9]{2})$/, "$1,$2");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, ".");
  return valor;
}

function format_integer(number) {
  valor = number.toString();
  valor = valor.replace(/\D/g, "");
  valor = parseInt(valor, 10);
  return valor;
}

function format_decimal(number){
  valor = number.toString();
  valor = valor.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1.$2");
  valor = parseFloat(valor);
  return valor;
}

function format_input_monto_entero(monto) {
  valor = monto.value.toString();

  valor = valor.replace(/\D/g, "");
  //valor = valor.replace(/([0-9])([0-9]{2})$/, "$1,$2");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, ".");
  monto.value = valor;
}

function format_input_monto_decimal(monto) {
  valor = monto.value.toString();

  valor = valor.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1.$2");
  monto.value = valor;
}

function format_input_number_decimal_with_separator(monto) {
  valor = monto.value.toString();

  valor = valor.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1,$2");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, ".");
  monto.value = valor;
}

function format_number(number) {
  valor = number.value.toString();
  valor = valor.replace(/\D/g, "");
  number.value = valor;
}

function getRootUrl() {
  return window.location.origin;
}
