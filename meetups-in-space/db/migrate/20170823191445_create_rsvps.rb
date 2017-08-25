class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.integer :meetup_id, null: false
      t.integer :user_id, null: false
    end
  end
end
