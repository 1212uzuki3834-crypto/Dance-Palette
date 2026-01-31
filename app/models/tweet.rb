class Tweet < ApplicationRecord
    belongs_to :user 
    #tweetsテーブルから中間テーブルに対する関連付け
  has_many :tweet_tag_relations, dependent: :destroy
  #tweetsテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :tags, through: :tweet_tag_relations, dependent: :destroy
  has_many :comments, dependent: :destroy
  #投稿が誰にいいねされているかの情報を取得
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  mount_uploader :video, VideoUploader
  has_one_attached :video
  validate :at_least_one_content_set
  private

  def at_least_one_content_set
    # テキストセットが揃っているか
    text_set_present = genre.present? && purpose.present? && place.present?
    
    # 動画セットがあるか
    video_set_present = youtube_url.present? || video.present?

    if !text_set_present && !video_set_present
      errors.add(:base, "テキスト情報または動画情報を入力してください")
    end
  end
end
