class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.decimal :amount
      t.string :currency
      t.integer :instid

      t.timestamps
    end
  end
end
