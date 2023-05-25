class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.belongs_to :page, foreign_key: true
      t.timestamps
    end
  end
end
