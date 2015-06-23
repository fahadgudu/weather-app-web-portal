class Company < ActiveRecord::Base

  include HasAttachedBanner

  has_many :company_products, dependent: :destroy
  has_many :products, through: :company_products
  has_many :stores, dependent: :destroy

  accepts_nested_attributes_for :company_products, allow_destroy: true

  def to_builder
    Jbuilder.new do |company|
      company.name name
      company.image image
    end
  end

end
