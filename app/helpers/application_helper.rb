module ApplicationHelper

	def active_page(*paths)
		active = false  
		paths.each { |path| active ||= current_page?(path) }  
		active ? "active" : ""
	end

	def has_error attribute
		return "has-error" if flash[:danger] && flash[:danger].keys.include? attribute
	end

end
