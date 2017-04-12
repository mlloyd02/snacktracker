class CreateOptionalSnacks < ActiveRecord::Migration
  def change
    create_table :optional_snacks do |t|

      t.timestamps null: false
    end
  end
end
