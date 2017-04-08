class CreateSnacks < ActiveRecord::Migration
  def change
    create_table :snacks do |t|

      t.timestamps null: false
    end
  end
end
