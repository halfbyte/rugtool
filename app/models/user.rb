class User < ActiveRecord::Base
  acts_as_authentic
  
  # Authorization plugin
  acts_as_authorized_user
  acts_as_authorizable
  
  
end
