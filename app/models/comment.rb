class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  # --- 追加：content（内容）が空ではないことを確認 ---
  validates :content, presence: true
end
