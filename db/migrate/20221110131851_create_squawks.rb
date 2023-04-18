class CreateSquawks < ActiveRecord::Migration[6.1]
  def change
    create_table :squawks do |t|
      t.string :code
      t.boolean :paired
      t.belongs_to :flight, index: {unique: true}, foreign_key: true
      t.timestamps
    end
  end
end
