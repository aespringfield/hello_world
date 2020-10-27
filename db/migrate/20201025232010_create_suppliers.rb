class CreateSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.string :name, null: false
      t.string :ein
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :phone_number

      t.timestamps
    end
  end
end
