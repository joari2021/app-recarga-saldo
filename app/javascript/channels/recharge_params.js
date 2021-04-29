document.addEventListener("turbolinks:load", function () {
    $("#close_modal_recharge_param").click(function () {
        $("#modal_recharge_param").removeClass("show");
        $("#modal_recharge_param_wrap").removeClass("show");
    });
})