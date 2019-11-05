class CreateDnsHostnames < ActiveRecord::Migration[5.2]
  def change
    create_table :dns_hostnames do |t|
      t.references :dns, foreign_key: true
      t.references :hostname, foreign_key: true

      t.timestamps
    end
  end
end
