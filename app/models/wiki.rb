class Wiki < ActiveRecord::Base
  scope :visible_to, -> (user) { user ? all : where(public: true) }
end
