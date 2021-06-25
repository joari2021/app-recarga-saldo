class BalanceController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin

    def index
        @balances = Balance.all

        @balance_total = 0.0
        @balances.each do |balance|
            if balance.user.id != 9 && balance.user.id != 2
                @balance_total += balance.balance
            end
        end
    end
end
