class AddFaxStateAndEmailToStore < ActiveRecord::Migration
  def change
    add_column :stores, :fax, :string
    add_column :stores, :state, :string
    add_column :stores, :email, :string
  end
end
