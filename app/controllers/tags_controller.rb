class TagsController < ApplicationController
  before_action :authenticate_user!, only: [:create]  # ログインユーザーだけ追加できる（不要なら消してOK）

  def create
    if params[:name].present?
      Tag.find_or_create_by(name: params[:name].strip)
    end
    redirect_to tweets_path
  end
end
