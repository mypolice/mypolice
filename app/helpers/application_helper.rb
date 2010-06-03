module ApplicationHelper
  def current_role
    if current_user 
      return current_user
    elsif current_admin 
      return current_admin
    elsif current_police 
      return current_police
    end
  end

  def current_role_name
    return current_role.class.to_s.downcase if current_role
  end

  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end  

  def title(page_title)  
    content_for(:title) { page_title }  
  end  


end
