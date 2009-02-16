module GroupsHelper
  
  def allowed_for_create_or_moderator?(group)
    group.new_record? || permit?('moderator for Group')
  end
  
end
