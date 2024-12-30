class Account < ApplicationRecord
    has_many :expenses, dependent: :destroy

    def days_until_payday
        payday = Date.new(Date.today.year, Date.today.month, 25) # 例：毎月25日
        payday += 1.month if payday <= Date.today
        (payday - Date.today).to_i
    end

    def can_survive?(expenses)
        total_expenses = expenses.sum(:amount)
        balance >= total_expenses
    end
end