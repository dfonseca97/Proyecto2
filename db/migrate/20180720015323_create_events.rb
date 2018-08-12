class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :user
      t.float :x
      t.float :y
      t.time :time
      t.date :date

      t.timestamps
    end
  end
end
