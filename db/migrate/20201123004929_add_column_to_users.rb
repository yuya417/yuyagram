class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :account_name, :string, null: false, default: ""
  end
end
