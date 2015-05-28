class AddCompanyIdToStores < ActiveRecord::Migration
  def change
    add_column :stores, :company_id, :integer
  end
end
