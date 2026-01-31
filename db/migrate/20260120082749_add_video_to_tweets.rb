class AddVideoToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :video, :string
  end
end
