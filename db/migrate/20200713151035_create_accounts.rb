class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.references :customer, null: false, type: :uuid, foreign_key: true
      t.integer :type
      t.decimal :balance

      t.timestamps
    end
  end
end
