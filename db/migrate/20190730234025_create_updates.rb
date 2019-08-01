class CreateUpdates < ActiveRecord::Migration[5.2]
  def change
    create_table :updates do |t|
      t.string :field, index: true
      t.string :value, index: true
      t.references :updatable, polymorphic: true, index: true

      t.timestamps
    end

    add_index :updates, [:updatable_id, :updatable_type, :field, :value], unique: true, name: 'uniqueness_index'
  end
end
