document.addEventListener("turbolinks:load", function () {
  input_buscador_contacts.addEventListener("input", function (event) {
    termino = $(this).val();

    if (termino.length == 0) {
      $("#tabla_buscador_contacts tbody").empty();
    } else {
      $("#tabla_buscador_contacts tbody").empty();
      $(".contenedor_loader").fadeIn(400);

      let request_url =
        getRootUrl() +
        "/buscador_contacts/" +
        termino +
        "/" +
        input_operadora.value +
        "/" +
        input_type_pago.value;

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
                                <tr>
                                    <td>${names}</td>
                                    <td>${number_comp}</td>
                                    <td>
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
        } else {
          rowContent = `
                        <tr>
                            <td colspan="3" class="text-center">No se encontro una coincidencia</td>
                        </tr>
                        `;

          $("#tabla_buscador_contacts tbody").empty();
          $("#tabla_buscador_contacts tbody").append(rowContent);
          setTimeout(hidden_loader, 1000);
        }
      });
    }
  });

  validation_submit = function () {
    if ($("#btn_recarga").data("validate") === true) {
      validate_form = true
      $("p.msj_error").css({"display":"none"})
      
      //VALIDACION DE CODIGO DE AREA
      if (show_div_cod_area){
        if (cod_area.indexOf(input_cod_area.value) === -1){
          validate_form = false
          $("#msj_error_cod_area").fadeIn(600)
        }
      }else{
        input_cod_area.removeAttribute("required")
      }
          
      //VALIDACION DE NUMERO
      digit_limit = input_number.maxLength
      
      if (input_number.value.length != digit_limit){
        validate_form = false
        document.getElementById("digit_lenght").innerText = digit_limit
        $("#msj_error_number_phone").fadeIn(600)
      }

      //VALIDACION DE MONTO
      if (operation === "recarga") {
        valor = format_integer(input_monto.value)
        monto_valid = false

        for (let i = monto_min; i <= monto_max; i+=multiplos) {
          if(i === valor){
            monto_valid = true
            break
          }
        }

        if (monto_valid === false) {
          validate_form = false
          $("#msj_error_monto").fadeIn(600)
        }
      }else{
        input_monto.removeAttribute("required")
      }

      //VALIDACION DEL NOMBRE DEL CONTACTO (OPCIONAL)
      if (switch_names.checked){
        if ($("#recharge_names_contact").val().trim( ).length == 0) {
          validate_form = false
          $("#msj_error_names").fadeIn(600)
        }
      }

      //VALIDACION DEL FORMULARIO
      if (validate_form) {
        input_monto.value = format_integer(input_monto.value)
        $("#btn_submit").trigger("click")
      } else {
        return
      }
    } else {
      $("#btn_submit").trigger("click")
    }
  } 

  edit_modal = function () {
  
    for (let i = 0; i < card_options.length; i++) {
        const element = card_options[i];
        element.className = "card card-options shadow h-100 py-2 border-left-" + input_operadora.value
    }
  
    for (let i = 0; i < labels.length; i++) {
        const element = labels[i];
        if (element.className.indexOf("label-special") != -1){
          element.className = "label-special label-" + input_operadora.value
        }
    }
  
    for (let i = 0; i < span_barra.length; i++) {
        const element = span_barra[i];
        element.className = "barra bg-before-" + input_operadora.value
    }

    title_modal_contact.className = "modal-title color-" + input_operadora.value 
    close_modal_contact.className = "far fa-times-circle close_modal color-" + input_operadora.value
    table_contacts.className = "table mt-3 bg-" + input_operadora.value 
    loader_buscador_contact.className = "loader color-" + input_operadora.value

    close_modal.className = "far fa-times-circle close_modal color-" + input_operadora.value
    btn_recarga.className = "btn-standar btn--left bg-before-" + input_operadora.value
  }

  show_form = function (cod_area,monto_min,monto_max,multiplos) {
  
    if(show_div_cod_area){
  
      caja_cod_area.innerHTML = ""
  
      for (let i = 0; i < cod_area.length; i++) {
        const element = cod_area[i];
        enlace = document.createElement("a")
        enlace.setAttribute("href","#")
        enlace.classList.add("badge","bg-"+input_operadora.value)
        enlace.style.margin = "5px"
        enlace.setAttribute("onclick","push_cod(event,this)")
        enlace.innerHTML = element
  
        caja_cod_area.appendChild(enlace)
  
        if((i+1) % 5 === 0){
          br = document.createElement("br")
          caja_cod_area.appendChild(br)
        }
      }
      $("#input_cod_area").fadeIn(200);
    }else{
      $("#input_cod_area").css({"display":"none"})
    }
  
    if (operation === "recarga") {
  
      div_montos.innerHTML = ""
      let i = 1;
      for (let m = monto_min; m <= monto_max; m+=multiplos) {
  
        monto = m;
        enlace = document.createElement("a")
        enlace.setAttribute("href","#")
        enlace.classList.add("badge","bg-"+input_operadora.value)
        enlace.style.margin = "5px"
        enlace.setAttribute("onclick","push_monto(event,this)")
        
        enlace.innerHTML = format_number_integer_with_separator(monto) 
  
        div_montos.appendChild(enlace)
  
        if(i % 3 === 0){
          br = document.createElement("br")
          div_montos.appendChild(br)
        }
        i++
      }
      $("#input_monto").removeClass("d-none")
    } else {
      $("#input_monto").addClass("d-none")
    }
  
    $(caja_type_pago).css({"display":"none"})
    $(caja_form).fadeIn(600);
  }

  show_modal_contacts = function (event) {
    event.preventDefault()
    $('#modal_recharge').removeClass('show');
    $('#modal_recharge_wrap').removeClass('show');
    $('#modal_contacts').addClass('show');
    $('#modal_contacts_wrap').addClass('show');
  }

  show_input_names = function (input) {
    if (input.checked) {
      $("#recharge_names_contact").attr("required","required")
      $("#name_contact").fadeIn(600)
    } else {
      $("#name_contact").css({"display":"none"})
      $("#recharge_names_contact").removeAttr("required","required")
    }
  }

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
    input_names_contact.value = ""
    $("#tabla_buscador_contacts tbody").empty();
    
  });
  
  $(".link_new_recharge").click(function () {
    operadora_val = $(this).data("operator");
  });
  
  show_cod_area = function () {
    $("#cont-option-list").fadeIn(600);
  }
  
  ocultar_cod_area = function () {
    $("#cont-option-list").fadeOut(200);
  }
  
  show_montos = function () {
    $("#div_montos").fadeIn(600);
  }
  
  ocultar_montos = function () {
    $("#div_montos").fadeOut(200);
  }
  
  push_cod = function (e, badge) {
    e.preventDefault();
    input_cod_area.value = badge.innerText;
    $("#cont-option-list").fadeOut(200);
  }
  
  push_monto = function (e, badge) {
    e.preventDefault();
    input_monto.value = badge.innerText;
    $("#div_montos").fadeOut(200);
  }
  
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
        swal("La consulta ha sido eliminada con exito!", {
          icon: "success",
        });
        id = "delete_" + link.id;
        document.getElementById(id).click();
      } else {
        swal("La consulta no fue eliminada!");
      }
    });
  }

  var_refresh_consult = setInterval(refresh_consultas, 100000);
  $.ajaxSetup({ cache: false });
  
});

function hidden_loader() {
  $(".contenedor_loader").css({ display: "none" });
}

function refresh_consultas () {
  $("#row_consultation").load( getRootUrl() + "/recharges" + " #row_consultation", function(){
    //*USAR SI ES NECESARIO DESPUES DE CARGAR */
  });
}
