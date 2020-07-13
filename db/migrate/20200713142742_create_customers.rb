class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers, id: :uuid do |t|
      t.string :cpf, null: false, index: { unique: true }
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
