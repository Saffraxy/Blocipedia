class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  scope :visible_to, -> (user) { user ? all : where(public: true) }

  def collaborator_for(user)
    collaborators.find_by(user: user)
  end
end
