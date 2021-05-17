document.addEventListener("turbolinks:load", function () {
    setTimeout(showPopup, 3000);

    $("#btn_modal").click(function(){
        $('#modal_standar').removeClass('show');
        $('#modal_standar_wrap').removeClass('show');
    });

    $("#btn-abrir").click(showPopup);
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



