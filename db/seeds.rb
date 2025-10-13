# This file populates the database with 100 sample blog posts
# using the Faker gem.
#
# To run this file, use the command: rails db:seed

# Clear existing posts to avoid duplicates when re-seeding
Post.destroy_all

puts "Creating 100 sample posts..."

100.times do
  Post.create!(
    title: Faker::Lorem.sentence(word_count: 3, random_words_to_add: 4),
    body: Faker::Lorem.paragraphs(number: 4).join("\n\n")
  )
end

puts "Finished!"
puts "Created #{Post.count} posts."
