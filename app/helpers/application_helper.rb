module ApplicationHelper
	def flash_class(type)
		case type
		when :alert
			"alert-error"
		when :notice
			"alert-success"
		else
			""
		end
	end

  def current_user?(user)
	user == current_user
  end

  def nl2br(s)
    s.gsub(/\n/, '<br>')
  end
end