require 'random_data'

# Create an admin user
 admin = User.create!(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )

 # Create a standard member
 standard = User.create!(
   name:     'Standard User',
   email:    'standard@example.com',
   password: 'helloworld'
 )

 # Create a premium member
 premium = User.create!(
   name:     'Premium User',
   email:    'premium@example.com',
   password: 'helloworld'
 )


# Create Wikis
25.times do
  Wiki.create!(
    title:        RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{Wiki.count} wikis created"
