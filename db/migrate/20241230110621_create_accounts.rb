class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.decimal :balance
      t.string :account_type

      t.timestamps
    end
  end
end
