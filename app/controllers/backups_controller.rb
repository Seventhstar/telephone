class BackupsController < ApplicationController
  before_action :set_backup, only: [:show, :edit, :update, :destroy]

  # GET /backups
  def index
    #@backups = Backup.all
    @backups = get_backups()
    @servers = get_server_oldest_backups(@backups)
    #flash.now[:message]='backups.count: ' + @backups.count.to_s+':  '+ @servers.join('; ')
    #puts "@servers"+@servers.join('-')
  end

  def get_server_oldest_backups(list_backups)
      hash = {}
      list_backups.each do |key,value|

        path =  value[:path].split('/').first
        puts value[:date]

        if hash.has_key?(path)
           if hash[path] > value[:date]
              hash[path] = value[:date]
           end
        else
          hash.store(path, value[:date])
          puts hash
        end

        #if hash.has_key?(key)
      end
      #puts hash
      hash.sort
  end

  #def get_last_file(folder)
  #    
  #    b = Dir[folder+'/*.bak']
  #    a = Dir[folder+'/**/*.bak']

  #    b = b+ a 
  #    b.sort
  #    puts b.last
  #    b.last
  #end
  def parse_filename(file_name)
    type = ""
    if file_name.present?

    file_name = file_name.upcase
    if file_name.index('FULL_')
     type = 'FULL'
     file = file_name.split('FULL_').last
   elsif file_name.index('DIFF_')
     type = 'DIFF'
     file = file_name.split('DIFF_').last
   else
     file = file_name.split('DIFF_').last
     type = '?'
   end

   file = file.split(/,/)
   date = Time.parse(file.first) #.to_s[0..19]
   {date: date, type:type}
   end
 end

  def get_last_file(folder)
      
      h = {}
      target_folder = folder
      if Rails.env.production?
         target_folder = target_folder.gsub('//s-backup-sql','/media')
      end
      b = Dir[target_folder+'/*.bak']
      a = Dir[target_folder+'/**/*.bak']
      b = b+ a 

      b.sort
      p_full = parse_filename(b.last)

      b.each do |file_name|
        p = parse_filename(file_name)
        h.store(p[:date],{date: p[:date],file_name: file_name,type:p[:type]})
        
      end

      if h.count>0
      h = h.sort.reverse
      last = h[0][1]
      last[:full] = p_full[:date]
      last
      else
        nil
      end
  end

  def get_backups

    backups = {}
    backups_list = Backup.all
    backups_list.each do |bak|
        
        path = bak.path.gsub('\\', '/')
        h = get_last_file(path)
        if h
           l_path = path.gsub('//s-backup-sql/backup/SQL-Server/DataBases/','')
           backups.store(bak.name,{name: bak.name,path: l_path, link: bak, file: h[:file_name], date: h[:date], type:h[:type], full:h[:full]})
        end
    end

    backups
  end

  # GET /backups/1
  def show
  end

  # GET /backups/new
  def new
    @backup = Backup.new
  end

  # GET /backups/1/edit
  def edit
  end

  # POST /backups
  def create
    @backup = Backup.new(backup_params)

    if @backup.save
      redirect_to backups_url, notice: 'Backup was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /backups/1
  def update
    if @backup.update(backup_params)
      redirect_to backups_url, notice: 'Backup was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /backups/1
  def destroy
    @backup.destroy
    redirect_to backups_url, notice: 'Backup was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_backup
      @backup = Backup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def backup_params
      params.require(:backup).permit(:name, :path)
    end
end
