class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.decimal :amount
      t.references :account, null: false, type: :uuid, foreign_key: true
      t.integer :type

      t.timestamps
    end
  end
end
