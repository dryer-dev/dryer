class AddDataToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :data, :json, default: {}
  end
end
