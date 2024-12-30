module ApplicationHelper
    def can_survive?(accounts, expenses, salary_date)
      total_balance = accounts.sum(&:balance)
      total_expenses = expenses.where('expense_date <= ?', salary_date).sum(&:amount)
      total_balance >= total_expenses
    end
  end
  