class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.belongs_to :site, null: false, foreign_key: true
      t.string :title
      t.timestamps
    end
  end
end
