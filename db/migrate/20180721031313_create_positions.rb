class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.integer :user, null:false
      t.float :latitud, null:false, default: 0
      t.float :longitud, null:false, default: 0

      t.timestamps
    end
  end
end
