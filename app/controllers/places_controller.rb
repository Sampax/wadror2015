class PlacesController < ApplicationController
  before_action :set_place, only: [:show]
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
  end

  private

  def set_place
    @place = BeermappingApi.place(params[:location], params[:id])
    @mapQuery = "https://www.google.com/maps/embed/v1/place?q=#{ERB::Util.url_encode(@place.street)},#{ERB::Util.url_encode(@place.city)}"
    end
end