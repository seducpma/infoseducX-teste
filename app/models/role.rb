class Role < ActiveRecord::Base
  has_many :roles_user
end