require 'factory_girl'

Factory.sequence :email do |n|
  "person#{n}@example.com" 
end

Factory.sequence :login do |n|
  "login#{n}"
end

Factory.sequence :url do |n|
  "http://www.example#{n}.de/"
end


Factory.define :user do |u|
  u.login Factory.next(:login)
  u.password 'test'
  u.password_confirmation 'test'
end

Factory.define :planet_feed do |f|
  f.feed_url Factory.next(:url)
end