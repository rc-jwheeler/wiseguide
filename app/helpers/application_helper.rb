module ApplicationHelper
  def last_updated(object)
    "Last updated %s by %s" % [object.updated_at.to_s(:long), object.updated_by.try(:display_name)] if object.updated_by.present?
  end
  
  def flash_type(type)
   if flash[type]
      "<div id=\"flash\">
         <a class=\"closer\" href=\"#\">Close</a>
         <div class=\"info\">#{flash[type]}</div>   
      </div>"
    else
      ''
    end
  end
  
  def bodytag_class
    return @bodytag_class unless @bodytag_class.blank?
    a = controller.class.to_s.underscore.gsub(/_controller$/, '')
    b = controller.action_name.underscore
    "#{a} #{b}".gsub(/_/, '-')
  end

  def kase_type_icon(kase)
    raw "[" + content_tag(:span, kase.class.humanized_name[0], :title => kase.class.humanized_name) + "]"
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
