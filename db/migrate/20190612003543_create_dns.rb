class CreateDns < ActiveRecord::Migration[5.2]
  def change
    create_table :dns do |t|
      t.string :IP

      t.timestamps
    end
  end
end
