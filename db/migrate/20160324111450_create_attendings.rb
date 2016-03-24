class CreateAttendings < ActiveRecord::Migration
  def change
    create_table :attendings do |t|
      t.integer :attendee_id
      t.integer :company_id
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
