class AlbumsController < ApplicationController

  def new
    @album = Album.new
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      render :new
    end
  end

  def destroy
    album = Album.find_by_id(params[:id])

    if album.delete
      redirect_to new_band_album
    else
      flash.now[:errors] = ["Cannot delete album!"]
      redirect_to new_band_album
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = ["Could not update band!"]
      render :edit
    end
  end

  def show
    @album = Album.find_by_id(params[:id])
    render :show
  end

  private

  def album_params
    params.require(:album).permit(:title, :band_id)
  end
end
