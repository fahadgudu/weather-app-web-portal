class RenameTypoInRecommendedProducts < ActiveRecord::Migration
  def change
    rename_column :recommended_products, :recommenable_id, :recommendable_id
  end
end
