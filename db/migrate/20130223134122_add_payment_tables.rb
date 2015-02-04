class AddPaymentTables < ActiveRecord::Migration
  def up
   create_table "payment_notifications", :force => true do |t|
     t.text     "params"
     t.integer  "order_id" #"veiling_id"
     t.integer  "login_id" #"user_id"
     t.string   "status"
     t.string   "transaction_id"
     t.datetime "created_at"
     t.datetime "updated_at"
   end
 
   create_table "payments", :force => true do |t|
     t.integer  "login_id" #"user_id"
     t.integer  "order_id" #"veiling_id"
     t.integer  "winnaar_id"
     t.integer  "koper_id"
     t.datetime "created_at"
     t.datetime "updated_at"
     t.decimal  "bedrag",     :precision => 8, :scale => 2
   end
  end

  def down
    drop_table "payments"
    drop_table "payment_notifications"
  end
end
