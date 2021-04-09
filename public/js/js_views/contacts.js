$("#close_modal_contact_standar").click(function () {
  $(".modal_contacts").removeClass("show");
  $(".modal_contacts-wrap").removeClass("show");
});

function show_modal_delete(event,link){
  event.preventDefault()

  swal({
    title: "Esta seguro?",
    text: "Esta acción es irreversible!",
    icon: "warning",
    buttons: true,
    dangerMode: true,
  })
  .then((willDelete) => {
    if (willDelete) {
      swal("El contacto fue eliminado con exito!", {
        icon: "success",
      });
      id = "delete_" + link.id;
      document.getElementById(id).click();

    } else {
      swal("La eliminación ha sido cancelada!");
    }
  });
}

function verify_operator() {
  operator = input_operator.value
  $("#badge-prepago").removeClass("d-none")
  $("#badge-postpago").removeClass("d-none")

  //TRABAJANDO CON EL INPUT DE TIPO DE PAGO
  if (operator === "Movilnet" || operator === "Movistar TV" || operator === "Simple TV") {
    $("#badge-postpago").addClass("d-none")
    $("#contact_type_payment").val("Pre-pago")

  } else if (operator === "Cantv"){
    $("#badge-prepago").addClass("d-none")
    $("#contact_type_payment").val("Post-pago")
  }else{
    $("#contact_type_payment").val("")
  }

  //TRABAJANDO CON EL INPUT CODIGO DE AREA
  if(operator === "Inter" || operator === "Movistar TV" || operator === "Simple TV"){
    $("#div_cod_area").css({"display":"none"})
  }else{
    $("#div_cod_area").fadeIn(400)
  }
  input_cod_area.value = ""

  input_number.value = ""

}

function verify_type_payment() {
  if(input_operator.value === "Movistar" && input_type_payment.value === "Post-pago"){
    $("#div_cod_area").css({"display":"none"})
  }else if(input_operator.value === "Movistar" && input_type_payment.value === "Pre-pago"){
    $("#div_cod_area").fadeIn(400)
  }
  input_number.value = ""
}

function push_value(event, option) {
  event.preventDefault()

  id_input = option.getAttribute("data-input")
  $(id_input).val(option.innerText)

  if(id_input === "#contact_operator"){
    verify_operator()
  }else if(id_input === "#contact_type_payment"){
    verify_type_payment()
  }
}

function insert_cod_area(cod_area) {
  options_cod_area = document.getElementById("options-cod-area")
  options_cod_area.innerHTML = ""

  for (let i = 0; i < cod_area.length; i++) {
    const element = cod_area[i];
    enlace = document.createElement("a")
    enlace.setAttribute("href","#")
    enlace.classList.add("badge","badge-movistar")
    enlace.style.margin = "5px"
    enlace.setAttribute("onclick","push_value(event,this)")
    enlace.setAttribute("data-input","#contact_cod_area")
    enlace.innerHTML = element

    options_cod_area.appendChild(enlace)

    if((i+1) % 5 === 0){
      br = document.createElement("br")
      options_cod_area.appendChild(br)
    }
  }
}

function create_cod_area() {
  //CODIGOS DE AREA
  cod_area = []
  cod_area_movistar = ["0414","0424"]
  cod_area_movilnet = ["0416","0426"]
  cod_area_digitel = ["0412"]
  cod_area_tlf_fija = ["0212","0234","0235","0238","0239","0240","0241","0242","0243","0244","0245","0246","0247","0248","0249","0251","0252","0253","0254","0255","0256","0257","0258","0259","0261","0262","0263","0264","0265","0266","0267","0268","0269","0270","0271","0272","0273","0274","0275","0276","0277","0278","0279","0281","0282","0283","0284","0285","0286","0287","0288","0289","0291","0292","0293","0294","0295"]

  switch (input_operator.value) {
    case "Movistar":
      cod_area = [...cod_area_movistar,...cod_area_tlf_fija]
      insert_cod_area(cod_area)
      break;
    
    case "Digitel":
      cod_area = [...cod_area_digitel,...cod_area_tlf_fija]
      insert_cod_area(cod_area)
      break;

    case "Movilnet":
      cod_area = [...cod_area_movilnet,...cod_area_tlf_fija]
      insert_cod_area(cod_area)
      break;
  
    default:
      break;
  }
}
function set_max_length(limit) {
  input_number.setAttribute("maxlength",limit)
}

function set_length(input) {
  operator = input_operator.value
  type_payment = input_type_payment.value
  if (operator === "Movistar" && type_payment === "Pre-pago" || operator === "Digitel" || operator === "Movilnet" || operator === "Cantv"){
    set_max_length(7)
  }else if (operator === "Movistar" && type_payment === "Post-pago" || operator === "Inter"){
    set_max_length(10)
  }else if (operator === "Movistar TV"){
    set_max_length(8)
  }else if (operator === "Simple TV"){
    set_max_length(12)
  }
}


