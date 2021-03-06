document.addEventListener("turbolinks:load", function () {
  $("#input_buscador_contacts").keyup(function (event) {
    termino = $(this).val();

    buscador_clientes(termino);
  });

  $("#close_modal_parametros").click(function () {
    $("#modal_parametros").removeClass("show");
    $("#modal_parametros_wrap").removeClass("show");
  });

  $("#close_modal_recharge").click(function () {
    $("#modal_recharge").removeClass("show");
    $("#modal_recharge_wrap").removeClass("show");
    $(caja_form).fadeOut(400);
    $(caja_type_pago).fadeOut(400);
  });

  $("#close_modal_contact").click(function () {
    $("#modal_contacts").removeClass("show");
    $("#modal_contacts_wrap").removeClass("show");
    $("#modal_recharge").addClass("show");
    $("#modal_recharge_wrap").addClass("show");
    input_names_contact.value = "";
    $("#tabla_buscador_contacts tbody").empty();
  });

  if (typeof var_refresh_available_system === "undefined") {
    var_refresh_available_system = setInterval(refresh_available_system, 300000);
  }

  if (typeof var_refresh_consult === "undefined") {
    var_refresh_consult = setInterval(refresh_consultas, 15000);
  }
});

mostrar_parametros = function () {
  $("#modal_parametros").addClass("show");
  $("#modal_parametros_wrap").addClass("show");
};

buscador_clientes = function (termino) {
  if (termino.trim() === "") {
    termino = "all";
  }
 
  $("#tabla_buscador_contacts tbody").empty();
  $(".contenedor_loader").fadeIn(400);

  let request_url =
    getRootUrl() +
    "/buscador_contacts/" +
    $("#recharge_operator").val() +
    "/" +
    $("#recharge_type_payment").val() +
    "/" +
    termino;

  $.get(request_url, function (data, status) {
    $("#tabla_buscador_contacts tbody").empty();

    if (data.length > 0) {
      for (let x in data) {
        let names = data[x].names_contact;
        let id = data[x].id;
        let cod_area = data[x].cod_area;
        let number = data[x].number_contact;

        if (cod_area.length == 4) {
          number_comp = "(" + cod_area + ") " + number;
        } else {
          number_comp = number;
        }

        let rowContent = `
                            <tr class="bg-${$("#recharge_operator").val()}">
                                <td class="align-middle" style="border-top-left-radius:30px;border-bottom-left-radius:30px;">${names}</td>
                                <td class="align-middle">${number_comp}</td>
                                <td class="align-middle" style="border-top-right-radius:30px;border-bottom-right-radius:30px;">
                                    <a
                                        href = "#"
                                        data-cod_area = "${cod_area}"
                                        data-number = "${number}"
                                        class = "special-link p-2"
                                        style = "color:#fff;"
                                        id = "${id}"
                                        onclick = "seleccionarContacto(event,this)"
                                        >
                                        Agregar
                                    </a>
                                </td>
                            </tr>
                          `;

        $("#tabla_buscador_contacts tbody").append(rowContent);

        longitud_data = data.length - 1;
        if (longitud_data.toString() === x) {
          setTimeout(hidden_loader, 1000);
        }
      }
    } else if (termino === "all" && data.length === 0){
      rowContent = `
                      <tr class="bg-${$("#recharge_operator").val()}">
                          <td colspan="3" class="text-center align-middle" style="border-radius:30px">No tienes clientes registrados para este tipo de recarga.</td>
                      </tr>
                    `;

      $("#tabla_buscador_contacts tbody").append(rowContent);
      hidden_loader()
    } else {
      rowContent = `
                      <tr class="bg-${$("#recharge_operator").val()}">
                          <td colspan="3" class="text-center align-middle" style="border-radius:30px">No se encontro una coincidencia</td>
                      </tr>
                    `;

      $("#tabla_buscador_contacts tbody").empty();
      $("#tabla_buscador_contacts tbody").append(rowContent);
      setTimeout(hidden_loader, 1000);
    }
    hidden_loader()
  });
};

show_cod_area = function () {
  $("#cont-option-list").fadeIn(600);
};

ocultar_cod_area = function () {
  $("#cont-option-list").fadeOut(200);
};

show_montos = function () {
  $("#div_montos").fadeIn(600);
};

ocultar_montos = function () {
  $("#div_montos").fadeOut(200);
};

push_cod = function (e, badge) {
  e.preventDefault();
  $("#recharge_cod_area").val(badge.innerText);
  $("#cont-option-list").fadeOut(200);
};

push_monto = function (e, badge) {
  e.preventDefault();
  input_monto.value = badge.innerText;
  $("#div_montos").fadeOut(200);
};

seleccionarContacto = function (event, contact) {
  event.preventDefault();
  $("#recharge_cod_area").val(contact.getAttribute("data-cod_area"));
  $("#recharge_number").val(contact.getAttribute("data-number"));
  $("#contenedor-switch").css({ display: "none" });

  $("#close_modal_contact").trigger("click");
};

validation_submit = function () {
  //LINEA DE UPDATE EN FORM PARA ADMIN
  $("#operation_admin").val("confirmada");
  /////**************************** *///////

  if ($("#btn_recarga").data("validate") === true) {
    validate_form = true;
    $("p.msj_error").css({ display: "none" });

    //VALIDACION DE CODIGO DE AREA
    if (show_div_cod_area) {
      if (cod_area.indexOf(input_cod_area.value) === -1) {
        validate_form = false;
        $("#msj_error_cod_area").fadeIn(600);
      }
    } else {
      $("#recharge_cod_area").removeAttr("required");
    }

    //VALIDACION DE NUMERO
    digit_limit = $("#recharge_number").attr("maxlength");

    if ($("#recharge_number").val().length != digit_limit) {
      validate_form = false;
      document.getElementById("digit_lenght").innerText = digit_limit;
      $("#msj_error_number_phone").fadeIn(600);
    }

    //VALIDACION DE MONTO
    if (operation === "recarga") {
      valor = format_integer($("#recharge_amount").val());
      monto_valid = false;

      for (let i = monto_min; i <= monto_max; i += multiplos) {
        if (i === valor) {
          monto_valid = true;
          break;
        }
      }

      if (monto_valid === false) {
        validate_form = false;
        $("#msj_error_monto").fadeIn(600);
      }
    } else {
      $("#recharge_amount").removeAttr("required");
    }

    //VALIDACION DEL NOMBRE DEL CONTACTO (OPCIONAL)
    if (switch_names != null && switch_names.checked) {
      if ($("#recharge_names_contact").val().trim().length == 0) {
        validate_form = false;
        $("#msj_error_names").fadeIn(600);
      }
    }

    //VALIDACION DEL FORMULARIO
    if (validate_form) {
      $("#btn_submit").trigger("click");
    } else {
      return;
    }
  } else {
    $("#btn_submit").trigger("click");
  }
};

edit_modal = function () {
  operator = $("#recharge_operator").val();
  //REESCRITURA DE CLASES DE ELEMENTOS YA RENDERIZADOS AL INICIO
  $(".card-options").attr(
    "class",
    "card card-options m-auto shadow h-100 py-2 border-left-" + operator
  );
  $("#loader_busq_contact").attr(
    "class",
    "loader loader-tam color-" + operator
  );
  $("#close_modal_contact, #close_modal_recharge").attr(
    "class",
    "far fa-times-circle close_modal btn-effect rounded-circle color-" + operator
  );
  $("#title_modal_contact").attr("class", "modal_title color-" + operator);
};

show_form = function (monto_min, monto_max, multiplos) {
  if (show_div_cod_area) {
    caja_cod_area.innerHTML = "";

    for (let i = 0; i < cod_area.length; i++) {
      const element = cod_area[i];
      /*
      enlace = document.createElement("a");
      enlace.setAttribute("href", "#");
      enlace.classList.add("badge", "btn-effect", "btn_standar", "btn-common", "ml-2", "mt-1", "bg-" + input_operadora.value);
      enlace.setAttribute("onclick", "push_cod(event,this)");
      enlace.innerHTML = element;*/
      enlace = document.createElement("option");
      enlace.setAttribute("value", element);

      caja_cod_area.appendChild(enlace);
    }
    $("#input_cod_area").fadeIn(200);
  } else {
    $("#input_cod_area").css({ display: "none" });
  }

  if (operation === "recarga") {
    div_montos.innerHTML = "";
    for (let m = monto_min; m <= monto_max; m += multiplos) {
      monto = m;
      /*
      enlace = document.createElement("a");
      enlace.setAttribute("href", "#");
      enlace.classList.add("badge", "btn-effect", "btn_standar", "btn-common", "bg-" + input_operadora.value);
      enlace.style.margin = "5px";
      enlace.setAttribute("onclick", "push_monto(event,this)");*/

      monto_format = format_number_integer_with_separator(monto);

      enlace = document.createElement("option");
      enlace.setAttribute("value", monto_format);

      div_montos.appendChild(enlace);
    }
    $("#input_monto").removeClass("d-none");
  } else {
    $("#input_monto").addClass("d-none");
  }
  set_length("recharge");
  $(caja_type_pago).css({ display: "none" });
  $(caja_form).fadeIn(600);
};

show_modal_contacts = function (event) {
  event.preventDefault();
  buscador_clientes("all")
  $("#modal_recharge").removeClass("show");
  $("#modal_recharge_wrap").removeClass("show");
  $("#modal_contacts").addClass("show");
  $("#modal_contacts_wrap").addClass("show");
};

show_input_names = function (input) {
  if (input.checked) {
    $("#recharge_names_contact").attr("required", "required");
    $("#name_contact").fadeIn(600);
  } else {
    $("#name_contact").css({ display: "none" });
    $("#recharge_names_contact").removeAttr("required", "required");
  }
};

hidden_loader = function () {
  $(".contenedor_loader").css({ display: "none" });
};

refresh_consultas = function () {
  $("#contenedor_consultations").load( window.location.href + " #sub_contenedor_consultation");
};

refresh_available_system = function () {
  $("#section-recharge").load( window.location.href + " #sub-section-recharge");
};
