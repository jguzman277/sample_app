# This file populates the database with a sample user and 100 sample blog posts
# using the Faker gem.
#
# To run this file, use the command: rails db:seed

# Clear existing data to avoid duplicates when re-seeding
puts "Clearing old data..."
User.destroy_all # This will also destroy associated posts due to `dependent: :destroy`

# Create a sample user
puts "Creating a sample user..."
user = User.create!(
  email: 'test@example.com',
  password: 'password',
  password_confirmation: 'password'
)
puts "Sample user created: #{user.email}"

# Create 100 posts for the sample user
puts "Creating 100 sample posts..."
100.times do
  user.posts.create!(
    title: Faker::Lorem.sentence(word_count: 3, random_words_to_add: 4),
    body: Faker::Lorem.paragraphs(number: 4).join("\n\n")
  )
end

puts "Finished!"
puts "Created #{User.count} user."
puts "Created #{Post.count} posts."