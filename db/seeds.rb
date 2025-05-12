# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

events = [
  {
    name: 'Ruby Conference 2025',
    description: 'Annual conference for Ruby developers featuring talks on Rails, Ruby 3.x, and modern web development.'
  },
  {
    name: 'JavaScript Summit',
    description: 'Deep dive into JavaScript ecosystem, including Node.js, React, and TypeScript.'
  },
  {
    name: 'DevOps Workshop',
    description: 'Hands-on workshop covering Docker, Kubernetes, and CI/CD pipelines.'
  }
]

events.each do |event_data|
  event = Event.create!(event_data)

  rand(3..6).times do
    event.feedbacks.create!(
      user_name: ["Alice", "Bob", "Charlie", "Diana", "Eve"].sample,
      rating: rand(3..5),
      comment: [
        "Great event! Learned a lot.",
        "Very informative sessions.",
        "Excellent networking opportunity.",
        "Well organized and engaging.",
        "The speakers were very knowledgeable."
      ].sample
    )
  end
end
