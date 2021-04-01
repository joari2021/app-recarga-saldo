//Variables
window.onload = function() {
	let contenedor_login_register = document.querySelector('.contenedor__login-register')
	let formulario_login = document.querySelector('.formulario__login')
	let formulario_register = document.querySelector('.formulario__register')
	let caja_trasera_login = document.querySelector('.caja__trasera-login')
	let caja_trasera_register = document.querySelector('.caja__trasera-register')

	function anchoPagina(){
		if (window.innerWidth > 850) {
			caja_trasera_login.style.display = "block"
			caja_trasera_register.style.display = "block"
		}else{
			caja_trasera_login.style.display = "block"
			caja_trasera_register.style.opacity = "1"
			caja_trasera_login.style.display = "none"
			formulario_login.style.display = "block"
			formulario_register.style.display = "none"
			contenedor_login_register.style.left = "0px"
		}
	}

	function register() {
		if (window.innerWidth > 850){
			formulario_register.style.display = "block"
			contenedor_login_register.style.left = "410px"
			formulario_login.style.display = "none"
			caja_trasera_register.style.opacity = "0"
			caja_trasera_login.style.opacity = "1" 
		}else{
			formulario_register.style.display = "block"
			contenedor_login_register.style.left = "0px"
			formulario_login.style.display = "none"
			caja_trasera_register.style.display = "none"
			caja_trasera_login.style.display = "block" 
			caja_trasera_login.style.opacity = "1"
		} 
	}

	function login() {
		if (window.innerWidth > 850){
			formulario_register.style.display = "none"
			contenedor_login_register.style.left = "10px"
			formulario_login.style.display = "block"
			caja_trasera_register.style.opacity = "1"
			caja_trasera_login.style.opacity = "0" 
		}else{
			formulario_register.style.display = "none"
			contenedor_login_register.style.left = "0px"
			formulario_login.style.display = "block"
			caja_trasera_register.style.display = "block"
			caja_trasera_login.style.display = "none" 
		}
		
	}

	btn_register = document.getElementById('btn__registrarse')
	if(btn_register != null){
		btn_register.addEventListener("click", register)
	}
	
	btn_login = document.getElementById('btn__iniciar-sesion')
	if(btn_login != null){
		btn_login.addEventListener("click", login)
	}

	//anchoPagina()
	//window.addEventListener("resize", anchoPagina)
}
	