class CreateCalendarEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :calendar_events do |t|
    	t.references :user, index: true
      t.string :name, null: false, default: ""
      t.datetime :date
      t.string :periodicity, null: false, default: ""
      t.timestamps
    end
  end
end
