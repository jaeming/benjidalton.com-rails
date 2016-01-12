require 'faker'

user = User.new(
  email:     "admin@admin.com",
  password:  "secret01"
  )
  user.save!

31.times do
  article = Article.create(
    title: Faker::Book.title,
    text: Faker::Lorem.paragraph
  )
  article.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
end

9.times do
  portfolio = Portfolio.create(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph,
    image: Faker::Placeholdit.image,
    link_to_src: Faker::Internet.url,
    link_to_site: Faker::Internet.url
  )
  portfolio.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
end
