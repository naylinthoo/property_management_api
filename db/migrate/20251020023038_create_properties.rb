class CreateProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :address
      t.string :owner_name
      t.decimal :monthly_rent
      t.string :status

      t.timestamps
    end
  end
end
