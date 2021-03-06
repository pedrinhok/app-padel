module ApplicationHelper

	def T text, params = {}
		t(text, params).capitalize
	end

	def f type, messages
		flash[type] = messages
	end

	def glyphicon css
		"<span class=\"glyphicon glyphicon-#{css}\" aria-hidden=\"true\"></span>".html_safe
	end

	def active_page(*paths)
		active = false  
		paths.each { |path| active ||= current_page?(path) }  
		active ? "active" : ""
	end

	def has_error attribute
		return "has-error" if flash[:danger] && flash[:danger].keys.include?(attribute)
	end

end
