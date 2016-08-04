module TasksHelper

 def store_tasks_path(params)
    p = URI.escape(params.delete_if{|k,v| ['_','utf8','controller','action'].include?(k) }.collect{|k,v| "#{k}=#{v}"}.join('&'))
    p 'request.url', request

    # fe
    session[:last_tasks_page] = request.path+'?'+p || tasks_url if request.get?
 end

 def tasks_stored_page
  # wefew
    sess_url = session[:last_tasks_page]
    sess_url || tasks_url
 end



end
