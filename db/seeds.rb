# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tenant = Tenant.create! name: 'demo'
user = User.create! email: 'richistron@gmail.com',
                    password: 'spree123',
                    tenant: tenant

['A', 'B', 'Z', 'BAR'].each do |row|
  2.times { |i| Table.create! name: "#{row}-#{i+1}" }
end
