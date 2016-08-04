class PhonesController < ApplicationController
  helper_method :sort_column, :sort_direction
  autocomplete :otdel, :name, :full => true
  autocomplete :position, :name, :full => true
  before_filter :authenticate_user!, except: [:index]

  def import
    Phone.import(params[:file])
    redirect_to root_url, notice: 'IP`s updated'
  end


  # GET /phones
  # GET /phones.json
  def index
    # @phones = Phone.all
    @otdels = Otdel.order(:id)
    @phones = Phone.search(params[:srch],params[:dsearch]).order(sort_column + " " + sort_direction).paginate(:per_page => 15, :page => params[:page])
    @maintenance = Basis.where(:maintenance => true)

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @phones }
    #end
  end

  # GET /phones/1
  # GET /phones/1.json
  def show
    @phone = Phone.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @phone }
    end
  end

  # GET /phones/new
  # GET /phones/new.json
  def new
    @phone = Phone.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @phone }
    end
  end

  # GET /phones/1/edit
  def edit
    @phone = Phone.find(params[:id])
  end

  # POST /phones
  # POST /phones.json
  def create
    @phone = Phone.new(phone_params)

    respond_to do |format|
      if @phone.save
        format.html { redirect_to @phone, notice: 'Phone was successfully created.' }
        format.json { render json: @phone, status: :created, location: @phone }
      else
        format.html { render action: "new" }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /phones/1
  # PUT /phones/1.json
  def update
    @phone = Phone.find(params[:id])

    respond_to do |format|
      if @phone.update_attributes(phone_params)
        format.html { redirect_to @phone, notice: 'Phone was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phones/1
  # DELETE /phones/1.json
  def destroy
    @phone = Phone.find(params[:id])
    @phone.destroy

    respond_to do |format|
      format.html { redirect_to phones_url }
      format.json { head :ok }
    end
  end

  private



  def phone_params
    params.require(:phone).permit(:name, :otdel_id, :position_id, :number, :IP, :CompName, :room, :Duties)
  end
  
  def sort_column
    Phone.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end
