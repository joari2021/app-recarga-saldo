window.addEventListener('load', () => {
    hidden_loader()
    
    $(document).on('turbolinks:load', function() {
        hidden_loader()
    });
})
hidden_loader = function (){
    $(".contenedor_loader_sup").css({"opacity":"0","visibility":"hidden"})
}


