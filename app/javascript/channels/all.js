document.addEventListener("turbolinks:load", function () {
  $(".show_loader_sup").click(function () {
    $(".contenedor_loader_sup").css({ opacity: "1", visibility: "visible" });
  });
});

//FUNCIONES DE FORMATEO DE NUMEROS Y LETRAS PARA VALORES 
format_options = function (option) {
  re = / /g;
  valor = option.replace(re, '_')
  return valor
}

format_integer = function (number) {
  valor = number.toString();
  valor = valor.replace(/\D/g, "");
  valor = parseInt(valor, 10);
  return valor;
};

format_decimal = function (number) {
  valor = number.toString();
  valor = valor.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1.$2");
  valor = parseFloat(valor);
  return valor;
};

format_number_integer = function (number) {
  valor = number.toString();
  valor = valor.replace(/\D/g, "");
  return valor;
};

format_number_integer_with_separator = function (number) {
  valor = number.toString();
  valor = valor.replace(/\D/g, "");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, ".");
  return valor;
};

format_number_decimal_with_separator = function (number) {
  valor = number.toString();
  valor = valor.replace(/\D/g, "");
  valor = valor.replace(/([0-9])([0-9]{2})$/, "$1,$2");
  valor = valor.replace(/\B(?=(\d{3})+(?!\d)\.?)/g, ".");
  return valor;
};

//FUNCIONES DE FORMATEO DE NUMEROS PARA INPUTS
input_value_integer = function (input) {
  input.value = format_number_integer(input.value);
};

input_value_integer_with_separator = function (input) {
  input.value = format_number_integer_with_separator(input.value);
};

input_value_decimal_with_separator = function (input) {
  input.value = format_number_decimal_with_separator(input.value);
};

readonly = function (input) {
  input.value = "";
};

estilizar_errores_validacion = function () {
  inputs = $(".input-special").parent();

  for (i = 0; i < inputs.length; i++) {
    if (inputs[i].className === "field_with_errors") {
      cnt = $(inputs[i]).contents();
      $(inputs[i]).replaceWith(cnt);
    }
  }

  labels = $(".label-special").parent();

  for (i = 0; i < labels.length; i++) {
    if (labels[i].className === "field_with_errors") {
      cnt = $(labels[i]).contents();
      $(labels[i]).replaceWith(cnt);
    }
  }
};

toggle_list_options = function () {
  $(".input-option").blur(function () {
    id_div = $(this).data("options");
    $(id_div).fadeOut(200);
  });

  $(".input-option").focus(function () {
    id_div = $(this).data("options");
    $(id_div).fadeIn(200);
  });
};

push_value_standar = function (event, option) {
  event.preventDefault();

  id_input = option.getAttribute("data-input");
  $(id_input).val(option.innerText);
};

set_max_length = function (limit) {
  input_number.setAttribute("maxlength", limit);
};

getRootUrl = function () {
  return window.location.origin;
};

show_datepicker = function () {
  $("#date").datepicker({
    language: "es",
    todayBtn: "linked",
    clearBtn: false,
    format: "dd/mm/yyyy",
    multidate: false,
    autoclose: true,
    todayHighlight: true,
  });
};
