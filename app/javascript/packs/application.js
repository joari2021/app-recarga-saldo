// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
require("jquery")

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// ESTILOS CSS
import "css/styles.scss"
import "css/form_recharge.scss"
import "css/login_and_register"

import "css/sb-admin-2"
import "@fortawesome/fontawesome-free/css/all"

//CODIGOS JS
import "bootstrap"
import swal from 'sweetalert'
import "channels/script_login_and_register"

