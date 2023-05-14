class CreateNestings < ActiveRecord::Migration[7.0]
  def change
    create_table :nestings do |t|
      t.references :parentable, polymorphic: true, index: true
      t.references :childable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
