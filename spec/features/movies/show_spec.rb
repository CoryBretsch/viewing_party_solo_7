require 'rails_helper'

RSpec.describe 'User can Discover', type: :feature do
  describe 'When user visits "/user/:user_id/discover"' do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @user2 = User.create!(name: 'Sam', email: 'sam@email.com')
    end
    
    describe "user story 3" do 
      it "can show movie's detail page" do 
        VCR.use_cassette("movie_search") do
          visit user_discover_index_path(@user1.id)

          fill_in :movie_title, with: "Twisters" 
          click_on "Search by Movie Title"
        end

        VCR.use_cassette("movie_detail_page") do
          click_on "Twisters"

          expect(current_path).to eq(user_movie_path(@user1.id, 718821))

          expect(page).to have_content("Movie Show Page")
        
          expect(page).to have_button("Create a Viewing Party")
          expect(page).to have_button("Return to Discover Page")

        save_and_open_page
          expect(page).to have_content("fail so it does not save vcr cassette")
        end
      
      end
    end
  end
end


# As a user, 
# When I visit a movie's detail page (`/users/:user_id/movies/:movie_id`) where :id is a valid user id,
# I should see
# - a button to Create a Viewing Party
# - a button to return to the Discover Page

# I should also see the following information about the movie:

# - Movie Title
# - Vote Average of the movie
# - Runtime in hours & minutes
# - Genre(s) associated to movie
# - Summary description
# - List the first 10 cast members (characters & actress/actors)
# - Count of total reviews
# - Each review's author and information