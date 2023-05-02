class CreateSites < ActiveRecord::Migration[7.0]
  def change
    create_table :sites do |t|
      t.string :domain
      t.string :subdomain
      t.timestamps
    end
  end
end
