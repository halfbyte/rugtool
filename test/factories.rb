require 'factory_girl'

Factory.sequence :email do |n|
  "person#{n}@example.com" 
end

# Factory.sequence :url do |n|
#   "http://example.com/thing/#{n}/"
# end

Factory.sequence :login do |n|
  "login#{n}"
end

Factory.sequence :url do |n|
  "http://www.example#{n}.de/"
end

Factory.sequence :url_slug do |n|
  "url_slug#{n}"
end

Factory.define :user do |u|
  u.login Factory.next(:login)
  u.password 'test'
  u.password_confirmation 'test'
end

Factory.define :planet_feed do |f|
  f.feed_url Factory.next(:url)
end

Factory.define :event do |f|
  f.title 'Event title'
  f.description 'A long evnet description'
  f.url Factory.next(:url)
  f.starts_at { 30.days.from_now }
end

Factory.define :group do |f|
  f.title 'Group'
  f.description 'Description'
  f.url_slug Factory.next(:url_slug)
end