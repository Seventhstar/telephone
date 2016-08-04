class BasesController < ApplicationController
  before_action :set_basis, only: [:show, :edit, :update, :destroy]

  # GET /bases
  def index
    @bases = Basis.all
  end

  # GET /bases/1
  def show
  end

  # GET /bases/new
  def new
    @basis = Basis.new
  end

  # GET /bases/1/edit
  def edit
  end

  # POST /bases
  def create
    @basis = Basis.new(basis_params)

    if @basis.save
      redirect_to bases_url, notice: 'Basis was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /bases/1
  def update
    if @basis.update(basis_params)
      redirect_to bases_url, notice: 'Basis was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /bases/1
  def destroy
    @basis.destroy
    redirect_to bases_url, notice: 'Basis was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basis
      @basis = Basis.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def basis_params
      params.require(:basis).permit(:service_text, :maintenance, :name, :img_name)
    end
end
