class AjaxController < ApplicationController

  def clients
    if params[:term]
      like= "%".concat(params[:term].concat("%"))
      clients = Client.where(" lower(name) like lower(?) ", like)
    else
      clients = Client.all
    end
    list = clients.map {|u| Hash[ id: u.id, label: u.name, name: u.name]}
    render json: list
  end


  def otdels
    if params[:term]
      like= params[:term].concat("%")
      otdels = Otdel.where("name like ?", like)
    else
      otdels = Otdel.all
    end

    list = otdels.map {|u| Hash[ id: u.id, label: u.name, name: u.name]}
    render json: list
  end

  def positions
    if params[:term]
      like= "%".concat(params[:term].concat("%"))
      positions = Position.where("name like ?", like)
    else
      positions = Position.all
    end

    list = positions.map {|u| Hash[ id: u.id, label: u.name, name: u.name]}
    render json: list
  end

   def upd_param
   	 if params['model'] && params['model']!='undefined'
   	 	puts params
   	 	obj = Object.const_get(params['model']).find(params['id'])
   	 	#puts obj.class
   	 	if params['model']=='WhouseElement'
   	 		if obj.element_name != params['upd']['element_name']
   	 			el = obj.element
   	 			el.name = params['upd']['element_name']
   	 			el.save
   	 		end
   	 		if obj.count != params['upd']['count']
   	 			obj.count = params['upd']['count']
   	 			obj.save
   	 		end
   	   	else

   	   		#new_name = params['upd']['name'].present? ? params['upd']['name'] : params['upd']['undefined']
          ## if obj.name != new_name
   	 		  #obj.name  = new_name
   	 		  #obj.save
          params['upd'].each do |p|
            #puts p
            obj[p[0]] = p[1]
            #obj
   	 	   end
         obj.save
  	    end
  	 end
  	 render :nothing => true
   end

end
