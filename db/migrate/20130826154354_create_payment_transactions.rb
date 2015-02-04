class CreatePaymentTransactions < ActiveRecord::Migration
  def change
    create_table :payment_transactions do |t|
      t.text :description
      t.integer :amount
      t.string :client
      t.string :client_email
      t.string :payment
      t.text :paymill_hash

      t.timestamps
    end
  end
end
