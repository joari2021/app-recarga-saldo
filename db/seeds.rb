# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SystemConfiguration.create
RechargeParam.create(operadora:"Movistar")
RechargeParam.create(operadora:"Digitel")
RechargeParam.create(operadora:"Movilnet")
RechargeParam.create(operadora:"Cantv")
RechargeParam.create(operadora:"Movistar_TV")
RechargeParam.create(operadora:"Simple_TV")
RechargeParam.create(operadora:"Inter")

