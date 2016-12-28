module ApplicationHelper

	def active_page(*paths)
		active = false  
		paths.each { |path| active ||= current_page?(path) }  
		active ? 'active' : ''  
	end

end
