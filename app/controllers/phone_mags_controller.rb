class PhoneMagsController < ApplicationController
  # GET /phone_mags
  # GET /phone_mags.json
  def index
    @phone_mags = PhoneMag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @phone_mags }
    end
  end

  # GET /phone_mags/1
  # GET /phone_mags/1.json
  def show
    @phone_mag = PhoneMag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @phone_mag }
    end
  end

  # GET /phone_mags/new
  # GET /phone_mags/new.json
  def new
    @phone_mag = PhoneMag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @phone_mag }
    end
  end

  # GET /phone_mags/1/edit
  def edit
    @phone_mag = PhoneMag.find(params[:id])
  end

  # POST /phone_mags
  # POST /phone_mags.json
  def create
#    @phone_mag = PhoneMag.new(params[:phone_mag])
   @phone_mag = PhoneMag.new(phone_params)


    respond_to do |format|
      if @phone_mag.save
        format.html { redirect_to @phone_mag, notice: 'Phone mag was successfully created.' }
        format.json { render json: @phone_mag, status: :created, location: @phone_mag }
      else
        format.html { render action: "new" }
        format.json { render json: @phone_mag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /phone_mags/1
  # PUT /phone_mags/1.json
  def update
    @phone_mag = PhoneMag.find(params[:id])

    respond_to do |format|
      if @phone_mag.update_attributes(params[:phone_mag])
        format.html { redirect_to @phone_mag, notice: 'Phone mag was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @phone_mag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_mags/1
  # DELETE /phone_mags/1.json
  def destroy
    @phone_mag = PhoneMag.find(params[:id])
    @phone_mag.destroy

    respond_to do |format|
      format.html { redirect_to phone_mags_url }
      format.json { head :ok }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_params
      params.require(:phone).permit(:name, :otdel_id, :position_id, :number, :IP, :CompName)
    end

end
