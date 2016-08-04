module OptionsHelper

  def attr_boolean?(item,attr)
    item.class.column_types[attr.to_s].class == ActiveRecord::Type::Boolean
  end


  def option_li( page,title, url = nil )
    css_class = @page == page ? "active" : nil
    lnk = url.nil? ? '#' : page
    content_tag :li, {:class =>css_class } do

      link_to title, lnk,{:class =>"list-group-item #{css_class}", :controller => page}
    end
  end


  def get_active_option_page

    case @page
    when 'otdels','position','bases'
      0
    else
      1
    end
        
  end

end
