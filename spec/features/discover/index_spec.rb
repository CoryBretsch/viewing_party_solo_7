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

        expect(page).to have_button('Discover Top Rated Movies')
        expect(page).to have_field('Movie Title')
        expect(page).to have_button('Search by Movie Title')
      end
    end
  end
end