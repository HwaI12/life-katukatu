class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.string :title
      t.text :description
      t.date :expense_date
      t.decimal :amount
      t.string :category

      t.timestamps
    end
  end
end
