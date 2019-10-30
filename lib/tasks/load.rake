require 'csv'

namespace :load do
  desc 'Load tweets into the truths table'
  task truths: :environment do
    puts 'Loading real actual Trump tweets into truths table...'
    loaded = 0
    CSV.foreach('storage/tweets_1.csv', headers: true, quote_char:'<') do |row|
      next if row['is_retweet'] == 'true' || Truth.exists?(tweet_id: row['id_str'])
      Truth.create(
        text: row['text'],
        sent: row['created_at'],
        tweet_id: row['id_str'],
        retweet_count: row['retweet_count'],
        state: 'REVIEW'
      )
      loaded += 1
    end
    puts "Created: #{loaded}"
  end
end
