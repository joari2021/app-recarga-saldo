class HomeController < ApplicationController
  def index
    @usuarios = User.where.not(permission_level:3).count
    @premiados = 0
    @recargas_confirmadas = Recharge.where(type_operation: "direct_recharge", status:"confirmada").count
    @solicitudes_pendientes = Recharge.where(status: "enviada").count
  end
end
