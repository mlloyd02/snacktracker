class AddOptionalSnackDetailsToOptionalSnacks < ActiveRecord::Migration
  def change
    add_column :optional_snacks, :name, :text
    add_column :optional_snacks, :last_purchase_date, :text
    add_column :optional_snacks, :api_id, :integer
  end
end
