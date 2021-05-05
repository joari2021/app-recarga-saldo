class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_register!
  def index
    @recharges = current_user.recharges.all
    
    @movistar_p = current_user.recharges.where(status: "confirmada", operator: "Movistar").count
    @digitel_p = current_user.recharges.where(status: "confirmada", operator: "Digitel").count
    @movilnet_p = current_user.recharges.where(status: "confirmada", operator: "Movilnet").count
    @cantv_p = current_user.recharges.where(status: "confirmada", operator: "Cantv").count
    @inter_p = current_user.recharges.where(status: "confirmada", operator: "Inter").count
    @movistar_tv_p = current_user.recharges.where(status: "confirmada", operator: "Movistar_TV").count
    @simple_tv_p = current_user.recharges.where(status: "confirmada", operator: "Simple_TV").count
=begin
    @movistar_p = movistar > 0 ? (movistar * 100) / all_recharges : 0
    @digitel_p = digitel > 0 ? (digitel * 100) / all_recharges : 0
    @movilnet_p = movilnet > 0 ? (movilnet * 100) / all_recharges : 0
    @cantv_p = cantv > 0 ? (cantv * 100) / all_recharges : 0
    @inter_p = inter > 0 ? (inter * 100) / all_recharges : 0
    @movistar_tv_p = movistar_tv > 0 ? (movistar_tv * 100) / all_recharges : 0
    @simple_tv_p = simple_tv > 0 ? (simple_tv * 100) / all_recharges : 0
=end
    @venta_months_2021 = []
    @amount_recharge = 0.0
    12.times do |i|
      date_inicial = "2021-#{i+1}-01"
      parsed_date_i = Date.parse(date_inicial)

      date_final = "2021-#{i+1}-27"
      parsed_date_f = Date.parse(date_final)

      recargas = current_user.recharges.where(status:"confirmada", type_operation:"direct_recharge", created_at: parsed_date_i.midnight..parsed_date_f.end_of_day)
      amount_recharge_this_month = 0.00
      recargas.each do |recarga|
        amount_recharge_this_month += recarga.amount
      end
      @amount_recharge += amount_recharge_this_month
      @venta_months_2021.push(amount_recharge_this_month)
    end
  end
  protected

  def obteniendo_registro_por_mes(month,year)
    

  end
end
