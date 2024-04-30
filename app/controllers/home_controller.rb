class HomeController < ApplicationController
  def index
    @news = News.all.order("date_news DESC")
    if SystemConfiguration.first.present?
      @usuarios = User.where.not(permission_level: 3).count + SystemConfiguration.first.usuarios_extras
      @recargas_confirmadas = Recharge.where(type_operation: "direct_recharge", status:"confirmada").count + SystemConfiguration.first.recargas_extras
    end

         @premiados = 0
    @solicitudes_pendientes = Recharge.where(status: "enviada").count
  end     
end

def sigle
                    params(:store)
end