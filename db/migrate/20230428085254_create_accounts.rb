class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :domain
      t.string :name
      t.string :subdomain
    end
  end
end
