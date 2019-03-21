class StaticPagesController < ApplicationController

require 'flickraw'

flickr = FlickRaw::Flickr.new "fe604483860b654d27e7000dc8a1w6661", "a98616f282415f6f"

def index
  flickr_user_id = search_params[:flickr_user_id] if search_params
  flickr_user_id = "25478444@N06" if flickr_user_id.blank?
    begin                
      @pics = flickr.people.getPhotos(user_id: flickr_user_id, extras: "url_m", per_page: 25)
    rescue FlickRaw::FailedResponse
      flash[:notice] = "Invalid user"
    end
end
    
private
    
  def search_params
    params.require(:search).permit(:flickr_user_id) if params[:search]
  end
end