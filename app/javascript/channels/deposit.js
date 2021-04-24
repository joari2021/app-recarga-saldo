document.addEventListener("turbolinks:load", function () {
  $("#close_modal_deposit").click(function () {
    $("#modal_deposit").removeClass("show");
    $("#modal_deposit_wrap").removeClass("show");
  });

  $("#close_modal_accounts").click(function () {
    $("#modal_accounts").removeClass("show");
    $("#modal_accounts_wrap").removeClass("show");

    $("#modal_deposit").addClass("show");
    $("#modal_deposit_wrap").addClass("show");
  });
});

show_modal_accounts = function (event) {
  event.preventDefault();
  $("#close_modal_deposit").trigger("click");
  $("#modal_accounts").addClass("show");
  $("#modal_accounts_wrap").addClass("show");
};

activar_submit_deposit = function () {

  $("#btn_deposit").click(function () {
    $("#btn_submit").trigger("click");
  });
};

