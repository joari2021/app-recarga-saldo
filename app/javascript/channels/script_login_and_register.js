//Variables
document.addEventListener("turbolinks:load", function () {
	
	$("#btn__registrarse").click(register)
	$("#btn__iniciar-sesion").click(login)
	
	anchoPagina()
	window.addEventListener("resize", anchoPagina)
})

function anchoPagina(){
	if (window.innerWidth > 850) {
		$('.caja__trasera-login').css({"display":"block"})
		$('.caja__trasera-register').css({"display":"block"})

		if($('.formulario__register').css("display") === "none"){
			login()
		}else{
			register()
		}
	}else{
		if($('.formulario__register').css("display") === "none"){
			$('.caja__trasera-register').css({"display":"block"})
			$('.caja__trasera-register').css({"opacity":"1"})
			$('.formulario__register').css({"display":"none"})

			$('.caja__trasera-login').css({"display":"none"})
			$('.formulario__login').css({"display":"block"})
		}else{
			$('.caja__trasera-login').css({"display":"block"})
			$('.caja__trasera-login').css({"opacity":"1"})
			$('.formulario__login').css({"display":"none"})

			$('.caja__trasera-register').css({"display":"none"})
			$('.formulario__register').css({"display":"block"})
		}
		$('.contenedor__login-register').css({"left":"0px"})
	}
}

function register() {
	if (window.innerWidth > 850){
		$('.formulario__register').css({"display":"block"})
		$('.contenedor__login-register').css({"left":"410px"})
		$('.formulario__login').css({"display":"none"})
		$('.caja__trasera-register').css({"opacity":"0"})
		$('.caja__trasera-login').css({"opacity":"1"})
	}else{
		$('.formulario__register').css({"display":"block"})
		$('.contenedor__login-register').css({"left":"0px"})
		$('.formulario__login').css({"display":"none"})
		$('.caja__trasera-register').css({"display":"none"})
		$('.caja__trasera-login').css({"display":"block"}) 
		$('.caja__trasera-login').css({"opacity":"1"})
	} 
}

function login() {
	if (window.innerWidth > 850){
		$('.formulario__register').css({"display":"none"})
		$('.contenedor__login-register').css({"left":"10px"})
		$('.formulario__login').css({"display":"block"})
		$('.caja__trasera-register').css({"opacity":"1"})
		$('.caja__trasera-login').css({"opacity":"0"})
	}else{
		$('.formulario__register').css({"display":"none"})
		$('.contenedor__login-register').css({"left":"0px"})
		$('.formulario__login').css({"display":"block"})
		$('.caja__trasera-register').css({"display":"block"})
		$('.caja__trasera-login').css({"display":"none"})
	}	
}
	