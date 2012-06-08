require 'open-uri'
class RoyalFilm

  @cities = %W[ Barranquilla Bucaramanga Cali Cartagena Cucuta Dosquebradas Magangue Medellin
    Pasto Pereira Popayan Sincelejo Tulua Yopal]
    def self.cities
      cities = []
      for city in @cities
        cities.push([city,city])
      end
      return cities
    end

    def self.multiplex city
      royal = Hpricot(open("http://www.royal-films.com/cartelera_ciudad.php?ciudad=#{city}"))
      multiplex = (royal/"span.Estilo7/a")
      m = []
      multiplex.each do |mul|
        val = mul.inner_html
        m.push([val,val])
      end
      return m
    end
    
    def self.search_multiplex(multiplex,city)
      multiplex = multiplex.gsub(" ", "%20")
      url = "http://www.royal-films.com/cartelera_ciudad_sala.php?sala=#{multiplex}&ciudad=#{city}"
      royal = Hpricot(open(url))
      movies = (royal/"table")
      return movies.inner_html.gsub(/\s+/, " ").strip
   end
end