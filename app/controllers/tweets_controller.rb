class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  @tweets = Tweet.all

  if params[:tag_ids].present?
    @tweets = @tweets.joins(:tags).where(tags: { id: params[:tag_ids] }).distinct
  end
end


  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    if @tweet.save
      redirect_to action: "index"
    else
      redirect_to action: "new"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @comment = Comment.new
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
    redirect_to action: "index"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:genre, :purpose, :place, :youtube_url, :body, :video, tag_ids: [])
  end
end
