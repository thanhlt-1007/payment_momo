class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :product, foreign_key: true
      t.integer :price

      # data sent to MoMo
      # recheck data when receive MoMo respone
      t.string :momo_order_id
      t.string :momo_request_id

      # update data when receive MoMo respone
      t.string :momo_trans_id
      t.string :momo_order_type
      t.string :momo_pay_type
      t.datetime :momo_response_time

      t.timestamps
    end
  end
end
