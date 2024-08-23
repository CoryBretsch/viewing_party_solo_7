class Movie 
  attr_reader :movie_id, 
              :title, 
              :vote_average 

  def initialize(attributes) 
    @movie_id = attributes[:id]
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
  end
  
end