class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :set
      t.string :color
      t.integer :position

      t.timestamps
    end
  end
end
