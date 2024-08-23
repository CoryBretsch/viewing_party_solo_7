class ViewingPartiesController < ApplicationController 
  def new 
    require 'pry'; binding.pry
    @user = User.find(params[:user_id])
  end

  def create

  end
end