desc 'Seed Admin Users to the system'

task admin_users: :environment do
  admins = [
      ['fahad@gmail.com', 'password'],
      ['junaid.qadir@itu.edu.pk', '12345678'],
  ]
  AdminUser.delete_all if AdminUser.count > 0
  ActiveRecord::Base.connection.reset_pk_sequence!(AdminUser.table_name)
  admins.each do |code|
    unless code[0].blank? || code[1].blank?
      u = AdminUser.new(email: code[0], password: code[1], password_confirmation: code[1])
      u.inspect
      u.save!
      puts "#{code[0]} created at #{Time.now}"
    else
      puts 'Sorry, the admin was not created!'
    end
  end
end
