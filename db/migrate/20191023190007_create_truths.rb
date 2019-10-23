class CreateTruths < ActiveRecord::Migration[5.2]
  def change
    create_table :truths do |t|
      t.text :text
      t.datetime :sent
      t.string :tweet_id
      t.integer :retweet_count
      t.string :state

      t.timestamps
    end
  end
end
