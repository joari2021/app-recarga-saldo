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

  $(".btn_select_account").click(function(){
    banks = ["Banco de Venezuela", "Banco Mercantil", "Banco B.O.D", "Banco Bancaribe", "Banco Bicentenario"]
    methods = ["Transferencia", "Pago móvil"]

    bank = $(this).data("bank")
    method = $(this).data("method")
    $("#close_modal_accounts").trigger("click")
    $("#deposit_bank_destinity").val(banks[format_integer(bank)])
    $("#deposit_method_payment").val(methods[format_integer(method)])
  })

  if (typeof var_refresh_deposits_for_process === "undefined"){
    var_refresh_deposits_for_process = setInterval(refresh_deposits_for_process, 15000);
  }
  $.ajaxSetup({ cache: false });
});

show_modal_accounts = function (event) {
  event.preventDefault();
  $("#close_modal_deposit").trigger("click");
  $("#modal_accounts").addClass("show");
  $("#modal_accounts_wrap").addClass("show");
};

activar_submit_deposit = function () {

  $("#btn_deposit").click(function () {
    $("#operation_admin").val("confirm")
    $("#btn_submit").trigger("click");
  });
};

refresh_deposits_for_process = function  () {
  $("#cont_deposits_for_process").load( getRootUrl() + "/process_deposits" + " #sub_cont_deposits_for_process", function(){
    /* USAR SI ES NECESARIO DESPUES DE CARGAR */
  });
}

