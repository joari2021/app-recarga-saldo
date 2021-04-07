$("#close").click(function () {
  $(".modal_original").removeClass("show");
  $(".modal_original-wrap").removeClass("show");
  $(caja_form).fadeOut(400);
  $(caja_type_pago).fadeOut(400);
});

$("#close_modal_contact").click(function () {
  $(".modal_contacts").removeClass("show");
  $(".modal_contacts-wrap").removeClass("show");
  $(".modal_original").addClass("show");
  $(".modal_original-wrap").addClass("show");
  input_names_contact.value = ""
  $("#tabla_buscador_contacts tbody").empty();
});

$(".link_new_recharge").click(function () {
  operadora_val = $(this).data("operator");
});

function show_cod_area() {
  $("#cont-option-list").fadeTo(600, 1);
}

function ocultar_cod_area() {
  $("#cont-option-list").fadeOut(200);
}

function show_montos() {
  $("#div_montos").fadeTo(600, 1);
}

function ocultar_montos() {
  $("#div_montos").fadeOut(200);
}

function push_cod(e, badge) {
  e.preventDefault();
  input_cod_area.value = badge.innerText;
  $("#cont-option-list").fadeOut(200);
}

function push_monto(e, badge) {
  e.preventDefault();
  input_monto.value = badge.innerText;
  $("#div_montos").fadeOut(200);
}

function show_modal_delete(event, link) {
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
