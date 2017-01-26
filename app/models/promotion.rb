class Promotion < ActiveRecord::Base

  include HasAttachedBanner

  attr_accessor :call_to_action_selection
  attr_accessor :call_to_action_link

  belongs_to :product

  def notify!(options)
		if options[:sw_lat].present? && options[:sw_lng].present? && options[:ne_lat].present? && options[:ne_lng].present?
			devices = Device.within_bounding_box([options[:sw_lat],options[:sw_lng],options[:ne_lat],options[:ne_lng]])
		else
			devices = Device.all
		end
		devices = devices.where(device_type: 'android').pluck(:token)
		Device.send_fcm_notification(self, devices) unless devices.empty?
  end

  def call_to_action_selection=(val)
    self.call_to_action = "richgro://".concat(val) if val.present?
  end

  def call_to_action_selection
    self.call_to_action.to_s.gsub("richgro://","")
  end

  def call_to_action_link
    call_to_action if call_to_action_selection.blank?
  end

  def call_to_action_link=(val)
    self.call_to_action = val
  end

  def self.call_to_action_options
    options_for_select = []
    options_for_select << ["Home","home"]
    options_for_select << ["How To Grow", "how_to_grow"]
    GrowingGuide.all.each do |htg|
      title = "How To Grow".concat(" > #{htg.title}")
      url   = "how_to_grow/#{htg.id}"
      options_for_select << [title, url]
    end
    options_for_select << ["Problem Solver", "problem_solver"]
    ProblemSolver.all.each do |ps|
      title = "Problem Solver".concat(" > #{ps.title}")
      url   = "problem_solver/#{ps.id}"
      options_for_select << [title, url]
    end
    options_for_select << ["Categories", "categories"]
    Category.top.each do |cat|
      title = "Category".concat(" > #{cat.title}")
      url   = "category/#{cat.id}"
      options_for_select << [title, url]
    end
    Category.sub.each do |cat|
      title = "Category > Sub Category".concat(" > #{cat.title}")
      url   = "category/#{cat.parent_id}/sub_category/#{cat.id}"
      options_for_select << [title, url]
    end
    Product.all.each do |product|
      title = "Product ".concat(" > #{product.title}")
      url   = "category/#{product.category_id}/#{product.id}"
      options_for_select << [title, url]
    end
    options_for_select << ["Shopping List", "shopping_list"]
    options_for_select << ["Settings", "settings"]
    options_for_select << ["Search - How to grow", "search/how_to_grow"]
    options_for_select << ["Search - Products", "search/products"]
    options_for_select << ["Search - Retailers", "search/retailers"]
    options_for_select << ["Search - Problem Solvers", "search/problem_solvers"]
    options_for_select << ["Retailers", "retailers"]
    options_for_select << ["Calculator", "calculator"]
  end

end
