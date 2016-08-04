@sortable_query = (params)->
  actual = if $('.only_actual').length==0 then null else $('.only_actual').hasClass('on')

  url = {
    only_actual: actual
    sort: $('span.active').attr('sort')
    direction: $('span.active').attr('direction')
    sort2: $('span.subsort.current').attr('sort2')
    dir2: $('span.subsort.current').attr('dir2')
    search: $('#search').val()
  }

  l = window.location.toString().split('?');
  p = q2ajx(l[1])
  p_params = q2ajx($('.index_filter').serialize())
  each p, (i, a) ->
    if ['search','page','_'].include? i
      url[i] = a
    return
  each p_params, (i, a) ->
    url[i] = a
    return
  each params, (i, a) ->
    url[i] = a
    return
  method = if $('#cur_method').val() == 'edit_multiple' then '/edit_multiple' else ''
  controller =  $('#search').attr('controller')
  if controller!='undefined'
    $.get '/'+controller+method, url, null, 'script'
    setLoc(""+controller+method+"?"+ajx2q(url));
  return


@show_ajax_message = (msg, type) ->
  if !type
    type = 'success'
  $('.js-notes').html '<div class="alert fade-in in flash_' + type + '" >' + msg + '</div>'
  showNotifications()
  return

@disable_input = (cancel=true) ->
 item_id = $('.icon_apply').attr('item_id')
 $cells = $('.editable')
 $cells.each ->
  _cell = $(this)
  _cell.removeClass('editable')
  if cancel
    _cell.html _cell.attr('last_val')
  else
    _cell.html _cell.find('input').val()
  return

 $cell = $('td.app_cancel')
 $cell.removeClass('app_cancel')
 $cell.html '<span class="icon icon_edit" item_id="'+item_id+'"></span><span class="icon icon_remove" item_id="'+item_id+'"></span>'

@cell_to_edit = (cl)->
  cl.addClass('editable')
  table = cl.closest('table')
  val = cl.html()
  cl.data('text', val).html ''
  cl.attr('last_val',val)
  fld = table.find('th:eq('+cl.index()+')').attr('fld')
  cl.attr('ind', fld)
  type = cl.attr('type')
  type = if type == undefined then 'text' else type
  # $input = $('<input type="'+type+'" name=upd['+fld+'] />').val(cl.data('text')).width(cl.width() - 16)
  $input = $('<input type="'+type+'" name=upd['+table.find('th:eq('+cl.index()+')').attr('fld')+'] />').val(cl.data('text')).width(cl.width() - 16)
  cl.append $input
  cl.context.firstChild.focus()

@upd_param = (param)->
  $.ajax
      url: '/ajax/upd_param'
      data: param
      type: 'POST'
      beforeSend: (xhr) ->
        xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
        return
      success: ->
        disable_input(false)
        show_ajax_message('Успешно обновлено')
     return


@apply_opt_change = (item)->
  model = item.closest('table').attr('model')
  item_id = item.attr('item_id')
  inputs = $('input[name^=upd]')
  upd_param(inputs.serialize()+'&model='+model+'&id='+item_id)


$(document).ready ->

 $('.container').on 'click', 'span.sw_check',  ->
  model = $(this).parents('table').attr('model')
  if $(this).hasClass('checked')
    $(this).removeClass 'checked'
    checked = false
  else
    $(this).addClass 'checked'
    checked = true

  item_id = $(this).attr('item_id')
  chk = $(this).attr('chk')
  if !chk
    table = $(this).closest('table')
    chk = table.find('th:eq('+$(this).closest('td')[0].cellIndex+')').attr('fld')

  $.ajax
    url: '/ajax/switch_check'
    data:
      'model': model
      'item_id': item_id
      'field': chk
      'checked': checked
    type: 'POST'
    beforeSend: (xhr) ->
      xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
      return
  return

# поиск
 $('#search').on 'keyup', (e)->
    c= String.fromCharCode(event.keyCode);
    isWordCharacter = c.match(/\w/);
    isBackspaceOrDelete = (event.keyCode == 8 || event.keyCode == 46);
    if (isWordCharacter || isBackspaceOrDelete)
       delay('sortable_query({})',700)
    return

# обновление данных в таблицах страниц index
 $('.index_filter select').on 'change', ->
    sortable_query({})
    return


# перемещение по меню
 $('.menu_sb li a, .sub-menu li a').click ->
   $('.sub-menu li.active').removeClass 'active', 1000
   $(this).parent().addClass 'active' , {duration:500}
   url = $(this).attr('controller')
   if url.indexOf('options')<1
    url = 'options/' + url
   url= url.replace('#','')
   if url != '/undefined'
     $.ajax
       url: '/'+url
       dataType: 'script'
       success: ->
        setLoc url

 $(document).on 'click', '#btn-sub-send', (e) ->
  attr_url = $(this).attr('action')
  prm = $(this).attr('prm')
  values = $('[name^='+prm+']').serialize()
  url = document.URL
  if url.indexOf('edit')<1 then url = url + '/edit'
  #alert url
  $.ajax
    type: 'POST'
    url: attr_url
    data: values
    dataType: 'JSON'
    beforeSend: (xhr) ->
      xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
      return
    success: ->
      $.get url, null, null, 'script'
      show_ajax_message 'Успешно добавлено'
      return
    error: (evt, xhr, status, error) ->
      errors = evt.responseText
      #alert(typeof(errors))
      show_ajax_message(errors,'error')
      showNotifications();
  return

# запись нового элемента простого справочника
 $(document).on 'click', '#btn-send', (e) ->
  valuesToSubmit = $('form').serialize()
  values = $('form').serialize()
  url = '/options'+$('form').attr('action')+'?_=1'
  empty_name = false
  #alert values
  each q2ajx(values), (i, a) ->
    if i.indexOf('[name]') > 0 and a == ''
      empty_name = true
      return false
    return
  if !empty_name
    $.ajax
      type: 'POST'
      url: url
      data: valuesToSubmit
      dataType: 'JSON'
      beforeSend: (xhr) ->
        xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
        return
      success: (xhr, data, response) ->
        $.get url, null, null, 'script'
        show_ajax_message 'Успешно записано'
        return
      error: (evt, xhr, status, error) ->
        show_ajax_message(evt.responseText,'error')
    return
  return

# удаляем элемент справочника
 $(document).on 'click', ' span.icon_remove', ->
    item_id = $(this).attr('item_id')
    url = document.URL.replace('#', '') #$('form').attr('action')
    attr_url = $(this).parents('table').attr('action')
    if attr_url!=undefined
      del_url = '/'+attr_url + '/' + item_id
    else
      del_url = url + '/' + item_id
    if url.indexOf('edit')<1 && url.indexOf('options')<1 then url = url + '/edit'
   # url = url.replace('options/','')
    del = confirm('Действительно удалить?')
    if !del
      return
    $.ajax
      url: del_url
      data: '_method': 'delete'
      dataType: 'json'
      type: 'POST'
      complete: ->
        $.get url, null, null, 'script'
        show_ajax_message('Успешно удалено')
        return
    return

# редактирование данных в таблице
 $(document).on 'click', 'span.icon_edit', ->
    item_id = $(this).attr('item_id')
    item_rm_id= $(this).next().attr('item_id')
    $row = $(this).parents('')
    disable_input()
    $cells = $row.children('td').not('.edit_delete,.state,.id')
    $cells.each ->
      cell_to_edit($(this))
      return

    $cell = $row.children('td.edit_delete')
    $cell.addClass('app_cancel')
    $cell.html '<span class="icon icon_apply" item_id="'+item_id+'"></span><span class="icon icon_cancel" item_id="'+item_rm_id+'"></span>'

   # отмена редактирования
   $(document).on 'click', 'span.icon_cancel', ->
     disable_input()
     return

   # отправка новых данных
   $(document).on 'click', 'span.icon_apply', ->
    apply_opt_change($(this))

   $('body').on 'keyup', '.editable input', (e) ->
      if e.keyCode == 13
        if $(this).closest('td').hasClass('l_edit') then i = $('.l_edit.editable') else i = $('span.icon_apply')
        apply_opt_change(i)
      else if e.keyCode == 27
        disable_input()
      return
   $('body').on 'keyup keypress','.edit_project input', (e)->
      if e.keyCode == 13 || e.keyCode == 8
        e.preventDefault()
      return
   $('body').on 'keyup keypress', '.simple_options_form',(e) ->
    code = e.keyCode or e.which
    if code == 13
      e.preventDefault()
      if e.type == 'keyup'
        $('#btn-send').trigger('click');
        return
      return false
    return
