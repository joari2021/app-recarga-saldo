document.addEventListener("turbolinks:load", function () {
  $("#close_modal_contact_register").click(function () {
    $("#modal_contact").removeClass("show");
    $("#modal_contact_wrap").removeClass("show");
  });
});

verify_operator = function () {
  operator = $("#contact_operator").val();
  $("#badge-prepago").removeClass("d-none");
  $("#badge-postpago").removeClass("d-none");

  //TRABAJANDO CON EL INPUT DE TIPO DE PAGO
  if (
    operator === "Movilnet" ||
    operator === "Movistar TV" ||
    operator === "Simple TV"
  ) {
    $("#badge-postpago").addClass("d-none");
    $("#contact_type_payment").val("Prepago");
  } else if (operator === "Cantv") {
    $("#badge-prepago").addClass("d-none");
    $("#contact_type_payment").val("Post-pago");
  } else {
    $("#contact_type_payment").val("");
  }

  //TRABAJANDO CON EL INPUT CODIGO DE AREA
  if (
    operator === "Inter" ||
    operator === "Movistar TV" ||
    operator === "Simple TV"
  ) {
    $("#div_cod_area").css({ display: "none" });
  } else {
    $("#div_cod_area").fadeIn(400);
  }
  $("#contact_cod_area").val("");
  $("#contact_number").val("");
};

verify_type_payment = function () {
  operator = $("#contact_operator").val();
  type_payment = $("#contact_type_payment").val();
  if (operator === "Movistar" && type_payment === "Post-pago") {
    $("#div_cod_area").css({ display: "none" });
  } else if (operator === "Movistar" && type_payment === "Prepago") {
    $("#div_cod_area").fadeIn(400);
  }
  $("#contact_number").val("");
};

verify_options_contact = function (event, option) {
  event.preventDefault();

  id_input = $(option).attr("data-input");
  if (id_input === "#contact_operator") {
    verify_operator();
  } else if (id_input === "#contact_type_payment") {
    verify_type_payment();
  }
};

insert_cod_area = function (cod_area) {
  options_cod_area = document.getElementById("options-cod-area");
  options_cod_area.innerHTML = "";

  for (let i = 0; i < cod_area.length; i++) {
    const element = cod_area[i];
    enlace = document.createElement("a");
    enlace.setAttribute("href", "#");
    enlace.classList.add(
      "badge",
      "btn_standar",
      "btn-common",
      "btn-effect",
      "bg-special"
    );
    enlace.style.margin = "5px";
    enlace.setAttribute("onclick", "push_value_standar(event,this)");
    enlace.setAttribute("data-input", "#contact_cod_area");
    enlace.innerHTML = element;

    options_cod_area.appendChild(enlace);

    if ((i + 1) % 5 === 0) {
      br = document.createElement("br");
      options_cod_area.appendChild(br);
    }
  }
};

create_cod_area = function () {
  switch ($("#contact_operator").val()) {
    case "Movistar":
      cod_area = [...cod_area_movistar, ...cod_area_tlf_fija];
      insert_cod_area(cod_area);
      break;

    case "Digitel":
      cod_area = [...cod_area_digitel, ...cod_area_tlf_fija];
      insert_cod_area(cod_area);
      break;

    case "Movilnet":
      cod_area = cod_area_movilnet;
      insert_cod_area(cod_area);
      break;

      case "Cantv":
        cod_area = cod_area_tlf_fija;
        insert_cod_area(cod_area);
        break;

    default:
      break;
  }
};

activar_submit_contact = function () {
  $("#btn_contact").click(function () {
    operator = $("#contact_operator").val();
    if (
      (operator === "Movistar" && $("contact_type_payment") === "Post-pago") ||
      operator === "Inter" ||
      operator === "Movistar TV" ||
      operator === "Simple TV"
    ) {
      $("#contact_cod_area").removeAttr("required");
    }
    $("#btn_submit").trigger("click");
  });
};
