class HomeController < ApplicationController
  def index
    @news = News.all.order("date_news DESC")
    @usuarios = User.where.not(permission_level:3).count + SystemConfiguration.first.usuarios_extras
    @premiados = 0
    @recargas_confirmadas = Recharge.where(type_operation: "direct_recharge", status:"confirmada").count + SystemConfiguration.first.recargas_extras
    @solicitudes_pendientes = Recharge.where(status: "enviada").count
  end
end
