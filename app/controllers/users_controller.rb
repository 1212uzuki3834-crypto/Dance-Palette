class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @tweets = @user.tweets.order(created_at: :desc)
  end
end
