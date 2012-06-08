require 'Cinecolombia'
class SearchesController < ApplicationController
  
def index
  @cities = Cinecolombia.cities
  @movies = Cinecolombia.movies
  @multiplex = Cinecolombia.multiplex nil
end

def search
  respond_to do |format| 
    format.js{
      @movie = params[:movies]
      @search_result = Cinecolombia.search(params[:cities] , params[:movies] , params[:date])
      @search_result.gsub!("href=\"","href= \" http://www.cinecolombia.com/")
      @search_result.gsub!("src=\"","src= \" http://www.cinecolombia.com/")
    }
  end
  
end

def update_multiplex
  @multiplex = Cinecolombia.multiplex params[:city]
  render :layout => false
end

def search_multiplex
  respond_to do |format|
    format.js{
      @search_result = Cinecolombia.searh_multiplex params[:multiplex], params[:city], params[:date]
      @search_result.gsub!("href=\"","href= \" http://www.cinecolombia.com/")
      @search_result.gsub!("src=\"","src= \" http://www.cinecolombia.com/")
    }
  end
end

end