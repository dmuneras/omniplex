require 'RoyalFilm'
class RoyalsController < ApplicationController
  
  def index
    @cities = RoyalFilm.cities
    @movies = Cinecolombia.movies
    @multiplex = RoyalFilm.multiplex "Barranquilla"
  end
  
  def update_multiplex
    @multiplex = RoyalFilm.multiplex params[:city]
    render :layout => false
  end
  
  def search_multiplex
    respond_to do |format|
      format.js{
        logger.info "MULTIPLEX =====>  #{params[:multiplex]}"
        @search_result = RoyalFilm.search_multiplex params[:multiplex], params[:city]
        @search_result.gsub!("href=\"","href= \" http://www.royal-films.com/")
        @search_result.gsub!("src=\"","src= \" http://www.royal-films.com/")
      }
    end
  end
  
end