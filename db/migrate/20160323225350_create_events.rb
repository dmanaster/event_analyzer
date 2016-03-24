class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :year
      t.string :season

      t.timestamps null: false
    end
  end
end
