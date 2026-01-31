class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @tweets = Tweet.all

    if params[:tag_ids]
      @tweets = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_tweets = Tag.find_by(name: key).tweets
          @tweets = @tweets.empty? ? tag_tweets : @tweets & tag_tweets
        end
      end
    end

    if params[:tag]
      Tag.create(name: params[:tag])
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
   if tweet.user_id == current_user.id
    tweet.destroy
   end
   redirect_to action: "index"
end
   
  private
  def tweet_params
    params.require(:tweet).permit(:genre, :purpose, :place, :youtube_url, :body, :video, tag_ids: [])
  end
end