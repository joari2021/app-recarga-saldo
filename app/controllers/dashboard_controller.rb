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

    @venta_months_2021 = []
    @amount_recharge = 0.0
    days_of_months = ["31","28","31","30","31","30","31","31","30","31","30","31"]
    12.times do |i|
      date_inicial = "2021-#{i+1}-01"
      parsed_date_i = Date.parse(date_inicial)

      date_final = "2021-#{i+1}-#{days_of_months[i]}"
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
end
