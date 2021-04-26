document.addEventListener("turbolinks:load", function () {
  activar_submit_profile();
});
activar_submit_profile = function () {
  $("#btn_profile").click(function () {
    swal({
      title: "Confirmacion de envio!",
      text:
        "Una vez actualizado no podras modificar tu perfil manualmente sino contactando a soporte. Te recomendamos verificar bien los datos antes de enviarlos. Si los datos son correctos puedes continuar.",
      icon: "warning",
      buttons: true,
      dangerMode: true,
    }).then((willDelete) => {
      if (willDelete) {
        swal("Los datos fueron enviados!", {
          icon: "success",
          closeOnClickOutside: false,
        });
        $("button.swal-button").css({"display":"none"})
        $("#btn_submit").trigger("click");
      } else {
        swal("El envio fue cancelado!");
      }
    });
  });
};
