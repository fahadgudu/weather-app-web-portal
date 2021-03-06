namespace :populate do

  desc "Run all the tasks"
  task all: :environment do
    Rake::Task['populate:categories'].invoke
    Rake::Task['populate:products'].invoke
    Rake::Task['populate:guides'].invoke
    Rake::Task['populate:problem_solvers'].invoke
    Rake::Task['populate:companies'].invoke
    Rake::Task['populate:stores'].invoke
  end

  desc "Create how to guides"
  task guides: :environment do
    puts "Creating how to grow guides"
    5.times do
      gg = GrowingGuide.create(title: fake_word, description: para)
      create_instructions(gg, rand(3..5))
      create_seasons(gg, rand(3..5))
      create_banner(gg)
      create_recommended_products(gg)
      gg.save
    end
  end

  desc "Create categories"
  task categories: :environment do
    puts "Creating categories"
    3.times do
      c = Category.create(name: fake_word)
      create_banner(c)
      rand(3..5).times do
        c.sub_categories.create(name: fake_word)
      end
      c.sub_categories.each do |sub|
        create_banner(sub)
      end
    end
  end

  desc "Create problem (grin)"
  task problem_solvers: :environment do
    puts "Creating problem solvers"
    rand(3..5).times do
      ps = ProblemSolver.create(title: fake_word, problem: para, resolution: para)
      create_banner(ps)
      create_recommended_products(ps)
    end
  end

  desc "Create products"
  task products: :environment do
    puts "Creating products"
    25.times do
      p = Product.create(title: fake_word, description: para, category_id: Category.sub.random.id, image: Faker::Avatar.image)
      create_usages(p)
      create_instructions(p)
    end
  end

  desc "Create stores"
  task stores: :environment do
    puts "Creating stores"
    10.times do
      store = Store.create(name: Faker::Name.name, address: Faker::Address.street_address, phone: Faker::PhoneNumber.cell_phone, latitude: Faker::Address.latitude, longitude: Faker::Address.longitude, postcode: Faker::Address.postcode)
        create_banner(store)
      5.times do
        store.products << Product.random
        store.company = Company.random
      end
      store.save
    end
  end

  desc "Create companies"
  task companies: :environment do
    puts "Creating companies"
    10.times do
      Company.create(name: fake_word)
    end
  end

  def create_banner(entity)
    entity.create_banner(image: Faker::Avatar.image)
  end

  def create_usages(product)
    5.times do
      product.usages.create(title: fake_word, description: para)
    end
  end

  def create_instructions(entity, number = 3)
    number.times do
      entity.instructions.create(detail: Faker::Lorem.sentence)
    end
  end

  def create_recommended_products(entity)
    rand(5..10).times do
      entity.recommended_products.create(product: Product.random)
    end
  end

  def create_seasons(entity, number)
    months = (1..12).collect{|n| n.month.ago.strftime("%b") }
    3.times do
      entity.growing_seasons.create(season: months.sample, instructions: Faker::Lorem.sentences(2).join)
    end
  end

  def fake_word
    Faker::Lorem.words(rand 1..2).join(" ").capitalize
  end

  def para
    Faker::Lorem.paragraph
  end

end

module ActiveRecord
  class Base
    def self.random
      order("RAND()").first
    end
  end
end
