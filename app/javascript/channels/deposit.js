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
    banks = ["Banco de Venezuela", "Banco Mercantil", "Banco B.O.D", "Banco Bancaribe", "Banco Bicentenario", "veMonedero"]
    methods = ["Transferencia", "Pago móvil"]

    bank = $(this).data("bank")
    method = $(this).data("method")
    $("#close_modal_accounts").trigger("click")
    $("#deposit_bank_destinity").val(banks[format_integer(bank)])
    $("#deposit_method_payment").val(methods[format_integer(method)])
  })

});

show_modal_accounts = function (event) {
  event.preventDefault();
  $("#close_modal_deposit").trigger("click");
  $("#modal_accounts").addClass("show");
  $("#modal_accounts_wrap").addClass("show");
};

rectify_method_p = function (option) {
  if (option.innerText != "Banco de Venezuela"){
    $("#option-pago-movil").addClass("d-none")
  }else{
    $("#option-pago-movil").removeClass("d-none")
  }
  $("#deposit_method_payment").val("")
}

activar_submit_deposit = function () {

  $("#btn_deposit").click(function () {
    $("#operation_admin").val("confirm")
    $("#btn_submit").trigger("click");
  });
};