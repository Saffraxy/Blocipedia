class WikiPolicy < ApplicationPolicy
#  attr_reader :user, :wiki

#  def initialize(user, wiki)
#    @user = user
#    @wiki = wiki
#  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.premium?
        wikis = []
        all_wikis = scope.all
        all_wikis.each do |wiki|
          # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          wikis << wiki #if wiki.user == user || wiki.public? #|| wiki.users.include?(user)
        end
        wikis
      else
        scope.where(public: true )
      end
    end
  end

  def update?
    user.admin? or not record.published?
  end
end
