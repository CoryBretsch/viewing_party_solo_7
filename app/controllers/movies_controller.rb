class MoviesController < ApplicationController 
  def index 
    @user = User.find(params[:user_id])
    if input = params[:movie_title]
      conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
        # faraday.headers["X-API-Key"] = Rails.application.credentials.movie[:key]
        faraday.params["api_key"] = Rails.application.credentials.movie[:key]
      end
      response = conn.get("/3/search/movie?query=#{input}&include_adult=false&language=en-US&page=1")
      json = JSON.parse(response.body, symbolize_names: true)
      @movies_details = json[:results].map do |movie_details|
        Movie.new(movie_details)
      end
    else
      conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
        # faraday.headers["X-API-Key"] = Rails.application.credentials.movie[:key]
        faraday.params["api_key"] = Rails.application.credentials.movie[:key]
      end
      response = conn.get("/3/movie/popular")
      json = JSON.parse(response.body, symbolize_names: true)
      @movies_details = json[:results].map do |movie_details|
        Movie.new(movie_details)
      end
    end
  end

  def show 

    @user = User.find(params[:user_id])
    @movie_id = params[:id]

    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      # faraday.headers["X-API-Key"] = Rails.application.credentials.movie[:key]
      faraday.params["api_key"] = Rails.application.credentials.movie[:key]
    end

    response = conn.get("/3/movie/#{@movie_id}?language=en-US")
    json = JSON.parse(response.body, symbolize_names: true)
    
    @movie_details = MovieDetail.new(json)
    
  end
end