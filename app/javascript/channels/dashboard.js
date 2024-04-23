document.addEventListener("turbolinks:load", function () {
    setTimeout(showPopup, 3000);

    $("#btn_modal").click(function(){
        $('#modal_standar').removeClass('show');
        $('#modal_standar_wrap').removeClass('show');
    });

    $("#btn-abrir").click(showPopup);

    $("#btn_show_modal_prom").click(function () {
        $('#modal_prom_ref').addClass('show');
        $('#modal_prom_ref_wrap').addClass('show');
    })

    $("#btn_close_modal_prom").click(function () {
        $('#modal_prom_ref').removeClass('show');
        $('#modal_prom_ref_wrap').removeClass('show');
    })
})

function show_modal_info(){
    $('#modal_standar').addClass('show');
    $('#modal_standar_wrap').addClass('show');
}

function showPopup(){
    if (typeof modal_show === "undefined"){
        show_modal_info()
        
        if ($('#modal_standar').attr("class") != undefined){
            modal_show = true
        }
    }
}



