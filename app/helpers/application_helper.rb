module ApplicationHelper

  def class_of_week(dt)
    d = Date.today
    cls = ''
    if !dt.nil?
      cls = 'week_2' if dt<d.end_of_week + 2.week
      cls = 'next_week' if dt<d.end_of_week + 1.week
      cls = 'this_week' if dt<d.end_of_week

    end
    cls
  end

  def class_of_task(task)
    cls = "priority"+task.priority_id.to_s
    cls = "task_done" if task.state_id == 5
    cls = "task_accept" if task.state_id == 7
    cls
  end

  def menu_li(title, link, def_link = :statements)
     css_li = current_page?(link)||link==def_link|| request.path_parameters[:controller]==link  ? "active": ""
     # p "link",link,request.base_url ,request.url==root_url

     content_tag :li,{:class => css_li} do
        link_to title, link
     end
  end


  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def edit_delete(element,subcount = nil)
    content_tag :td,{:class=>"edit_delete"} do
     ed = link_to "", edit_polymorphic_path(element), :class=>"icon icon_edit"
     #ed = link_to "", polymorphic_path(element), :class=>"icon icon_edit", data: { modal: true }
     subcount ||= 0
     if subcount>0
      de = content_tag("span","",{:class=>'icon icon_remove disabled'})
     else
      de = link_to "", element, :method => 'delete', data: { confirm: 'Delete?' }, :class=>"icon icon_remove"
     end
     ed + de
    end
  end

  def time_with_timeago(time, need_break = true)

    br = need_break ? '</br>':' - '
    raw(time.to_s[0..18] + br + time_ago_in_words(time)) + ' '+  t(:back)
  end
  def span_alt(text, alt)
    content_tag :span,time_with_timeago(text) , {title: alt}
  end


  def td_tool_icons(element,str_icons='edit,delete',params = nil)

    all_icons = {} #['edit','delete','show'] tag='span',subcount=nil
    params ||= {}
    params[:tag] ||= 'href'
    icons = str_icons.split(',')
    params[:subcount] ||= 0
    params[:add_cls] ||= ''
    dilable_cls = params[:subcount]>0 ? '_disabled' : ''
    if params[:tag] == 'span'
      all_icons['edit'] = content_tag :span, "", {class: 'icon icon_edit', item_id: element.id}
      all_icons['delete'] = content_tag( :span,"",{class: ['icon icon_remove',dilable_cls,' ',params[:add_cls]].join, item_id: params[:subcount]>0 ? '' : element.id})
     else
      all_icons['edit'] = link_to "", edit_polymorphic_path(element), class: "icon icon_edit"
      all_icons['show'] = link_to "", polymorphic_path(element), class: "icon icon_show", data: { modal: true }
      all_icons['delete'] = link_to "", element, method: :delete, data: { confirm: 'Действительно удалить?' }, class: "icon icon_remove " if params[:subcount]==0
      all_icons['delete'] = content_tag(:span,"",{class: 'icon icon_remove_disabled'}) if params[:subcount]>0
    end
    content_tag :td,{:class=>"edit_delete"} do
      icons.collect{ |i| all_icons[i] }.join.html_safe
    end

  end

  def chosen_src( id, collection, obj = nil, options = {})
    p_name    = options[:p_name].nil? ? 'name' : options[:p_name]
    order     = options[:order].nil? ? p_name : options[:order]
    nil_value = options[:nil_value].nil? ? 'Выберите...' : options[:nil_value]

    coll = collection.class.ancestors.include?(ActiveRecord::Relation) ? collection : collection
    coll = coll.collect{ |u| [u[p_name], u.id] }
    coll.insert(0,[nil_value,nil,{class: 'def_value'}]) if nil_value != ''
    coll.insert(1,[options[:special_value],-1]) if !options[:special_value].nil?

    is_attr = (obj.class != Fixnum && obj.class != String && !obj.nil?)
    sel = is_attr ? obj[id] : obj
    sel = options[:selected] if !options[:selected].nil?
      n = is_attr ? obj.model_name.singular+'['+ id.to_s+']' : id

    def_cls = coll.count < 8 ? 'chosen' : 'schosen'
    cls       = options[:class].nil? ? def_cls : options[:class]

    cls = cls+" has-error" if is_attr && ( obj.errors[id].any? || obj.errors[id.to_s.gsub('_id','')].any? )
    l = label_tag options[:label]
    s = select_tag n, options_for_select(coll, :selected => sel), class: cls
    options[:label].nil? ? s : l+s
  end

  def submit_cancel(back_url)
      s = submit_tag  'Сохранить', class: 'button'
      c = link_to 'Отмена', back_url, class: "button"
      c+s
  end

  def only_actual_btn(options = {})
    p options
    actual_text = options[:actual_text].nil? ? "Актуальные" : options[:actual_text]
    txt = @only_actual == false ? 'Все' : actual_text
    cls = @only_actual ? ' on only_actual' : ''
    active = @only_actual ?  'active' : ''
    a = content_tag :a, txt,{ class: "link_a left"+cls, off: "Все", on: actual_text}
    b = content_tag :div, { class: 'scale'} do
        content_tag :div, '',{class:"handle "+ active}
      end
    cls = @only_actual ? ' toggled' : ''
    content_tag :div, {class: 'switcher_a'+ cls} do
      a+b
    end
  end

  def tooltip( info,tip )
      ttip = tip
      #ttip.gsub!(/\n/, '<br>')
      content_tag(:span,info,{'data-toggle' =>"tooltip", 'data-placement' => "top", :title => tip})
  end



end
