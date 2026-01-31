class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :genre
      t.string :purpose
      t.string :place

      t.timestamps
    end
  end
end
