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
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.user == user || wiki.collaborators.include?(user)
          # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          wikis << wiki #if wiki.user == user || wiki.public? #|| wiki.users.include?(user)
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis #return wikis array we created
      end
    end

  def update?
    record.public? || user.admin? || user.premium?
  end
end
