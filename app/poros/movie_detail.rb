class MovieDetail 
  attr_reader :movie_id, 
              :title, 
              :vote_average,
              :runtime,
              :genres

  def initialize(attributes) 
  
    @movie_id = attributes[:id]
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
    @runtime = attributes[:runtime]
    @genres = attributes[:genres].map do |genre|
      genre[:name]
    end

  end

  
end