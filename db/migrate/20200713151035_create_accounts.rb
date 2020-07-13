class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.references :customer, null: false, type: :uuid, foreign_key: true
      t.string :type, null: false
      t.decimal :balance, null: false, default: 0.0

      t.timestamps
    end
  end
end
