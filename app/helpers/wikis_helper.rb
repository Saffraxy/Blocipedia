module WikisHelper
  def user_is_authorized_for_private_wikis?
     current_user.premium? || current_user.admin?
  end
end
