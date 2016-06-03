class BandsController < ApplicationController

  def index
    @band = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      render :show
    else
      render :new
    end
  end

  def destroy
    band = Band.find_by_id(params[:id])

    if band
      band.delete
      redirect_to bands_url
    else
      flash.now[:errors] = ["This band does not exist!"]
      redirect_to bands_url
    end
  end

  def edit
    @band = Band.find_by_id(params[:id])
    render :edit
  end

  def update
    @band = Band.find_by_id(params[:id])

    if @band.update_attributes(band_params)
      redirect_to band_url(@band)
    else
      flash.now[:errors] = ["Could not update band!"]
      render :edit
    end
  end

  def show
    @band = Band.find_by_id(params[:id])
    render :show
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

end
