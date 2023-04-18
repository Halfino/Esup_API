class CreateFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.string :callsign
      t.string :departure
      t.string :arrival
      t.boolean :onGround
      t.string :state
      t.timestamps
    end
  end
end
