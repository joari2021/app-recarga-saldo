document.addEventListener("turbolinks:load", function () {
  $(".show_loader_sup").click(function () {
    $(".contenedor_loader_sup").css({ opacity: "1", visibility: "visible" });
  });

  show_datepicker()

  //VARIABLES

  //CODIGOS DE AREA
  cod_area = [];
  cod_area_movistar = ["0414", "0424"];
  cod_area_movilnet = ["0416", "0426"];
  cod_area_digitel = ["0412"];
  cod_area_tlf_fija = [
    "0212",
    "0234",
    "0235",
    "0238",
    "0239",
    "0240",
    "0241",
    "0242",
    "0243",
    "0244",
    "0245",
    "0246",
    "0247",
    "0248",
    "0249",
    "0251",
    "0252",
    "0253",
    "0254",
    "0255",
    "0256",
    "0257",
    "0258",
    "0259",
    "0261",
    "0262",
    "0263",
    "0264",
    "0265",
    "0266",
    "0267",
    "0268",
    "0269",
    "0270",
    "0271",
    "0272",
    "0273",
    "0274",
    "0275",
    "0276",
    "0277",
    "0278",
    "0279",
    "0281",
    "0282",
    "0283",
    "0284",
    "0285",
    "0286",
    "0287",
    "0288",
    "0289",
    "0291",
    "0292",
    "0293",
    "0294",
    "0295",
  ];
  
  recharges_count = format_integer($("#recharges_cant").text())
  deposits_count = format_integer($("#deposits_cant").text())
 
  
  if (typeof var_refresh_solicitudes_pend != "undefined"){
    var_refresh_solicitudes_pend = undefined
  }
  
  if (typeof var_refresh_solicitudes_pend === "undefined"){
    var_refresh_solicitudes_pend = setInterval(refresh_solicitudes_pend, 15000);
  }
  $.ajaxSetup({ cache: false });

  href = window.location.href

  if (href.indexOf("dashboard") != -1){
    $("#access_dashboard").addClass("active")
  }else if (href.indexOf("vender_recargas") != -1){
    $("#access_recharges").addClass("active")
  }else if (href.indexOf("deposits") != -1){
    $("#access_deposits").addClass("active")
  }else if (href.indexOf("historial") != -1){
    $("#access_historial").addClass("active")
  }else if (href.indexOf("clientes") != -1){
    $("#access_contacts").addClass("active")
  }
});

//FUNCIONES DE FORMATEO DE NUMEROS Y LETRAS PARA VALORES
format_options = function (option) {
  re = /_/g;
  valor = option.replace(re, " ");
  return valor;
};

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
  $(input_number).attr("maxlength", limit);
};

set_length = function (modelo) {
  if (modelo === "recharge") {
    operator = $("#recharge_operator").val();
    type_payment = $("#recharge_type_payment").val();
  } else {
    operator = $("#contact_operator").val();
    type_payment = $("#contact_type_payment").val();
  }

  if (
    (operator === "Movistar" && type_payment === "Prepago") ||
    operator === "Digitel" ||
    operator === "Movilnet" ||
    operator === "Cantv"
  ) {
    set_max_length(7);
  } else if (
    (operator === "Movistar" && type_payment === "Post-pago") ||
    operator === "Inter"
  ) {
    set_max_length(10);
  } else if (operator === "Movistar_TV" || operator === "Movistar TV") {
    set_max_length(8);
  } else if (operator === "Simple_TV" || operator === "Simple TV") {
    set_max_length(12);
  } else {
    set_max_length(12);
  }
};

getRootUrl = function () {
  return window.location.origin;
};

show_modal_delete = function (event, link) {
  event.preventDefault();
  swal({
    title: "Estas segur@?",
    text: "Esta acción es irreversible!",
    icon: "warning",
    buttons: true,
    dangerMode: true,
  }).then((willDelete) => {
    if (willDelete) {
      id = "delete_" + link.id;
      document.getElementById(id).click();
      swal("Eliminación realizada con exito!", {
        icon: "success",
        closeOnClickOutside: false,
      });
      $("button.swal-button").css({"display":"none"})
    } else {
      swal("La eliminación fue cancelada!");
    }
  });
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

//SCRIPT PARA PROCESAR ACCIONES DEL ADMIN
show_modal_anulate = function (event) {
  event.preventDefault();
  swal({
    title: "Estas segur@ de anular esta operación?",
    text: "Esta acción es irreversible!",
    icon: "warning",
    buttons: true,
    dangerMode: true,
  }).then((willDelete) => {
    if (willDelete) {
      // FUNCIONARA SOLO EN EL FORM DE RECHARGE EDIT DEL A.
     if ($("#recharge_status").val("anulada")){
        $("#recharge_amount").removeAttr("required")
        $("#recharge_renta_mensual").removeAttr("required")
        $("#recharge_available_days").removeAttr("required")
        $("#recharge_saldo_resultante").removeAttr("required")
     }
      ///////////////////////////////////

      $("#btn_submit").trigger("click")
      swal({
        title: "Procesando. Por favor espere...",
        closeOnClickOutside: false,
      });
      $("button.swal-button").css({"display":"none"})
    } else {
      swal("La anulación fue cancelada!");
    }
  });
};

disabled_button = function (button){
  last_form = document.forms.length - 1
  elementosEnForm = document.forms[last_form].elements;

  submit = true
  for (i = 0; i < elementosEnForm.length; i++){
    
    if (elementosEnForm[i].getAttribute("required") != null){
      
      if (elementosEnForm[i].value.length === 0){
        submit = false
        break
      }
    }
  }

  if (submit){
    clases_button = $(button).attr("class").split(" ")
    $.each(clases_button, function (ind, clase) { 
      if (clase.indexOf("bg") != -1){
        $(button).removeClass(clase)
      } 
    }); 
    $(button).attr("disabled","disabled")
    $(button).css({"background":"#d9dadf"})
    $(button).removeClass("btn-effect")
    $(button).removeClass("btn-common")
  }
}

refresh_solicitudes_pend = function  () {
  $("#cont_solicitudes_pend").load( window.location.href + " #sub_cont_solicitudes_pend", function(){
    /* USAR SI ES NECESARIO DESPUES DE CARGAR */
    new_recharge = false
    new_deposit = false
    
    cant_new_recharges = format_integer($("#recharges_cant").text())
    if (cant_new_recharges > recharges_count){
      recharges_count = cant_new_recharges
      new_recharge = true
    }

    cant_new_deposits = format_integer($("#deposits_cant").text())
    if (cant_new_deposits > deposits_count){
      deposits_count = cant_new_deposits
      new_deposit = true
    }

    if (new_deposit || new_recharge){
      refrescarNotificaciones()
    }
  });
}

refrescarNotificaciones = function () {
  //$('#sound').trigger('click');
  $.playSound(getRootUrl() + "/sounds/iphone-notificacion.mp3")
}

copiarAlPortapapeles = function (content_copy,mensaje) {
  $("#icon-copy").css({"display":"none"})
  var aux = document.createElement("input");
  aux.setAttribute("value", content_copy);
  document.body.appendChild(aux);
  aux.select();
  document.execCommand("copy");
  document.body.removeChild(aux);
  $("#icon-copy").fadeTo(1000,1)

  md.showNotification(mensaje,'success')
}