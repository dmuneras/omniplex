class SearchesController < ApplicationController
  
def index
  @cities = Searcher.cities
  @movies = Searcher.movies
  @multiplex = Searcher.multiplex nil
end

def search
  respond_to do |format| 
    format.js{
      @movie = params[:movies]
      @search_result = Searcher.search(params[:cities] , params[:movies] , params[:date])
      @search_result.gsub!("href=\"","href= \" http://www.cinecolombia.com/")
      @search_result.gsub!("src=\"","src= \" http://www.cinecolombia.com/")
    }
  end
  
end

def update_multiplex
  @multiplex = Searcher.multiplex params[:city]
  render :layout => false
end

def search_multiplex
  respond_to do |format|
    format.js{
      @search_result = Searcher.searh_multiplex params[:multiplex], params[:city], params[:date]
      @search_result.gsub!("href=\"","href= \" http://www.cinecolombia.com/")
      @search_result.gsub!("src=\"","src= \" http://www.cinecolombia.com/")
    }
  end
end

end