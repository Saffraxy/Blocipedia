class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    record.public? || user.admin? || user.premium?
  end

  def show?
    record.public? || user.admin? || user.premium?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    show?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  class Scope
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
          wikis << wiki if wiki.user == user || wiki.public? #|| wiki.users.include?(user)
        end
        wikis
      else
        scope.where(public: true )
      end
    end
  end
end
