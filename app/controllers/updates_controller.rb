class UpdatesController < ApplicationController
  before_action :set_update, only: [:show, :edit, :update, :destroy]

require 'open-uri'
require 'nokogiri'

  def get_releases(updates,test = false)
    
    rel = {}
    if test
      page_1s = "H:/temp/categ_js.jsp";
    else
      page_1s = "http://downloads.1c.ru/release_info/categ_js.jsp?GroupID=88"
    end  

    page = Nokogiri::HTML(open(page_1s), nil,'cp1251')
    page.encoding = 'utf-8'

    #news_links = page.css(".em") 
    puts updates.count
    updates.each do |upd|
      

      if upd.path.index('/')==nil 
        info  = page.xpath('//tr[contains(., "'+upd.path+'")]//td//span')
      else
        search = upd.path.split('/')

        link = page.to_s.split(search.first)
        page_2 = Nokogiri::HTML(link[1])
        info = page_2.css('tr').first.css('td')
      end

      
	rel.store(Time.parse(info[0].text, "%d-%m-%Y").to_s+upd.name,{name: upd.name,current: upd.current, path: upd, available: info[2].text, date: info[0].text})
    end
    puts "rel"+ rel.to_s
    
    rel.sort.reverse

  end

  # GET /updates
  def index
    @updates = Update.all
    @releases = get_releases(@updates)
  end

  # GET /updates/1
  def show
  end

  # GET /updates/new
  def new
    @update = Update.new
  end

  # GET /updates/1/edit
  def edit
  end

  # POST /updates
  def create
    @update = Update.new(update_params)

    if @update.save
      redirect_to updates_url, notice: 'Update was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /updates/1
  def update
    if @update.update(update_params)
      redirect_to updates_url, notice: 'Update was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /updates/1
  def destroy
    @update.destroy
    redirect_to updates_url, notice: 'Update was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_update
      @update = Update.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def update_params
      params.require(:update).permit(:name, :path, :current)
    end
end
