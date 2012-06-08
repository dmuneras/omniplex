require 'open-uri'
class Cinecolombia

  def self.cities
    url = "http://www.cinecolombia.com/Default.aspx" 
    cinecol = Hpricot(open(url))
    cities_cinecol = []
    cities = (cinecol/"select.combociudades/option")
    cities.each do |city|
      val = city.inner_html
      unless /Cambiar Ciudad/.match(val) or /----/.match(val) 
        cities_cinecol.push([val,city.attributes['value']]) 
      end
    end
    return cities_cinecol.uniq!
  end

  def self.multiplex city
    if city.nil?
      url = "http://www.cinecolombia.com/Default.aspx"
    else
      url = "http://www.cinecolombia.com/Default.aspx?idciudad=#{city}"
    end
    movies = []
    cinecol = Hpricot(open(url))
    m = (cinecol/"select.comboteatros/option")
    m.each do |multiplex|
      val = multiplex.inner_html
      movies.push([val,multiplex.attributes['value']]) unless  /----/.match(val) 
    end
    return movies.uniq!
  end

  def self.movies
    url = "http://www.cinecolombia.com/Default.aspx" 
    movies_cinecol = []
    cinecol = Hpricot(open(url))
    movies = ( cinecol/"select.combopeliculas/option")
    movies.each do |m|
      val = m.inner_html
      movies_cinecol.push([val, m.attributes['value']]) unless /Por Pelicula/.match(val) or /----/.match(val) 
    end
    return movies_cinecol.uniq!
  end

  def self.search(city,movie,date)
    url = "http://www.cinecolombia.com/movie.aspx?idciudad=#{city}&idpelicula=#{movie}&caracteristicas=987&fecha=#{date}"
    respond = Hpricot(open(url))
    result = (respond/"div#Subt/div/div#parrilla")
    return result.inner_html.gsub(/\s+/, " ").strip
  end


  def self.searh_multiplex(multiplex,city,date)
    url = "http://www.cinecolombia.com/theater.aspx?idciudad=#{city}&idteatro=#{multiplex}&fecha=#{date}"
    respond = Hpricot(open(url))
    result = (respond/"div#parrillateatros")
    return result.inner_html.gsub(/\s+/, " ").strip
  end
end