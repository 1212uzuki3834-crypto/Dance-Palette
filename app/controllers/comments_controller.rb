class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = Tweet.find(params[:tweet_id])
    comment = tweet.comments.build(comment_params) #buildを使い、contentとtweet_idの二つを同時に代入
    comment.user_id = current_user.id
    if comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path) #直前のページにリダイレクト
    else
      flash[:success] = "コメントを入力してください"
      redirect_back(fallback_location: root_path) #直前のページにリダイレクト
    end
  end

  def destroy
  comment = Comment.find(params[:id])
  # ログインしているユーザーがコメントの投稿者である場合のみ削除を許可
  if comment.user_id == current_user.id
    comment.destroy
    flash[:success] = "コメントを削除しました"
  else
    flash[:error] = "権限がありません"
  end
  redirect_back(fallback_location: root_path)
end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end