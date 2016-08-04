class GroupMagsController < ApplicationController
  # GET /group_mags
  # GET /group_mags.json
  def index
    @group_mags = GroupMag.all
    @phones 	= PhoneMag.search( params[:search_mag] )
    #@group_mags = GroupMag.sear(params[:search_mag])

   # respond_to do |format|
   #  format.html # index.html.erb
   #   format.json { render json: @group_mags }
   # end
  end

  # GET /group_mags/1
  # GET /group_mags/1.json
  def show
    @group_mag = GroupMag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_mag }
    end
  end

  # GET /group_mags/new
  # GET /group_mags/new.json
  def new
    @group_mag = GroupMag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_mag }
    end
  end

  # GET /group_mags/1/edit
  def edit
    @group_mag = GroupMag.find(params[:id])
  end

  # POST /group_mags
  # POST /group_mags.json
  def create
    @group_mag = GroupMag.new(params[:group_mag])

    respond_to do |format|
      if @group_mag.save
        format.html { redirect_to @group_mag, notice: 'Group mag was successfully created.' }
        format.json { render json: @group_mag, status: :created, location: @group_mag }
      else
        format.html { render action: "new" }
        format.json { render json: @group_mag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_mags/1
  # PUT /group_mags/1.json
  def update
    @group_mag = GroupMag.find(params[:id])

    respond_to do |format|
      if @group_mag.update_attributes(params[:group_mag])
        format.html { redirect_to @group_mag, notice: 'Group mag was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_mag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_mags/1
  # DELETE /group_mags/1.json
  def destroy
    @group_mag = GroupMag.find(params[:id])
    @group_mag.destroy

    respond_to do |format|
      format.html { redirect_to group_mags_url }
      format.json { head :ok }
    end
  end
end
