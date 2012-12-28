module TextbooksHelper

	def show_nested_sections(sections)
	  sections.map do |sec|
	    "<fieldset>"+
      if sec.has_children?
  	    sec.name +
        content_tag(:div, show_nested_sections(sec.subsections), :class => "nested_sections")
      else
        content_tag(:div, sec.name, :class => "nested_sections")
      end +
      "</fieldset>"
    end.join.html_safe
  end
  
end