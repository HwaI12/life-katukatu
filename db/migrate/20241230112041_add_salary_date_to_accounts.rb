class AddSalaryDateToAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :accounts, :salary_date, :date
  end
end
