class MobilesController < ApplicationController
  # GET /mobiles
  # GET /mobiles.json
  def index
    @mobiles = Mobile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mobiles }
    end
  end

  # GET /mobiles/1
  # GET /mobiles/1.json
  def show
    @mobile = Mobile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mobile }
    end
  end

  # GET /mobiles/new
  # GET /mobiles/new.json
  def new
    @mobile = Mobile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mobile }
    end
  end

  # GET /mobiles/1/edit
  def edit
    @mobile = Mobile.find(params[:id])
  end

  # POST /mobiles
  # POST /mobiles.json
  def create
    @mobile = Mobile.new(params[:mobile])

    respond_to do |format|
      if @mobile.save
        format.html { redirect_to @mobile, notice: 'Mobile was successfully created.' }
        format.json { render json: @mobile, status: :created, location: @mobile }
      else
        format.html { render action: "new" }
        format.json { render json: @mobile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mobiles/1
  # PUT /mobiles/1.json
  def update
    @mobile = Mobile.find(params[:id])

    respond_to do |format|
      if @mobile.update_attributes(params[:mobile])
        format.html { redirect_to @mobile, notice: 'Mobile was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @mobile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobiles/1
  # DELETE /mobiles/1.json
  def destroy
    @mobile = Mobile.find(params[:id])
    @mobile.destroy

    respond_to do |format|
      format.html { redirect_to mobiles_url }
      format.json { head :ok }
    end
  end
end
