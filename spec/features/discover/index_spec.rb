require 'rails_helper'

RSpec.describe 'User can Discover', type: :feature do
  describe 'When user visits "/user/:user_id/discover"' do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @user2 = User.create!(name: 'Sam', email: 'sam@email.com')
    end
    
    describe "user story 1" do   
      it 'should have a button to Discover Top Rated Movies' do
        visit user_discover_index_path(@user1.id)
        
        expect(page).to have_link('Discover Top Rated Movies')
        expect(page).to have_field('Movie Title')
        expect(page).to have_button('Search by Movie Title')
      end
    end

    describe "user story 2" do 
      it "can navigate to Top Rated Movies" do 
        VCR.use_cassette("top_rated_movies") do
          visit user_discover_index_path(@user1.id)

          click_on "Discover Top Rated Movies"
          expect(current_path).to eq(user_movies_path(@user1.id))

          expect(page.status_code).to eq 200
          expect(page).to have_content("List of Movies")
          expect(page).to have_css("#movie", count: 20)
          expect(page).to have_css("#vote_average", count: 20)
          
          expect(page).to have_button("Return to Discover Page")
          click_on "Return to Discover Page"
          expect(current_path).to eq(user_discover_index_path(@user1.id))
        end
      end

      it "can navigate to movie title search results" do 
        VCR.use_cassette("movie_search") do
          visit user_discover_index_path(@user1.id)

          fill_in :movie_title, with: "Twisters" 
          click_on "Search by Movie Title"
          
          expect(page.status_code).to eq 200
          expect(current_path).to eq(user_movies_path(@user1.id))

          expect(page).to have_content("List of Movies")
          expect(page).to have_css("#movie", count: 20)
          expect(page).to have_css("#vote_average", count: 20)

          expect(page).to have_link("Twisters")
          click_on "Twisters"

          expect(current_path).to eq(user_movie_path(@user1.id, 718821))
        end
      
      end
    end
  end
end


# When I visit the discover movies page ('/users/:id/discover'),
# and click on either the Discover Top Rated Movies button or fill out the movie title search and click the Search button,
# I should be taken to the movies results page (`users/:user_id/movies`) where I see: 

# - Title (As a Link to the Movie Details page (see story #3))
# - Vote Average of the movie

# I should also see a button to return to the Discover Page.