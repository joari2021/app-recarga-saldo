window.addEventListener('load', () => {
    hidden_loader_sup()
    
    $(document).on('turbolinks:load', function() {
        hidden_loader_sup()
    });
})
hidden_loader_sup = function (){
    $(".contenedor_loader_sup").css({"opacity":"0","visibility":"hidden"})
}


