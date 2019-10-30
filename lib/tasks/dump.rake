require 'csv'

namespace :dump do
  desc 'Load tweets into the truths table'
  task tweets: :environment do
    puts 'Dumping all tweets to a common file'
    loaded = 0
    File.open('all_tweets.txt', 'w') do |file|
      CSV.foreach('storage/tweets_1.csv', headers: true, quote_char:'<') do |row|
        next if row['is_retweet'] == 'true'
        loaded += 1
        file.write clean_text(row['text']) + "\n"
      end

      CSV.foreach('storage/tweets_2.csv', headers: true, quote_char:'<') do |row|
        next if row['is_retweet'] == 'true'
        loaded += 1
        file.write clean_text(row['text']) + "\n"
      end
    end

    puts "Dumped: #{loaded}"
  end

  def clean_text(text)
    text = text.gsub(/(?:f|ht)tps?:\/[^\s]+/, '') # remove urls
    text = text.sub('&amp;', '&')
    text
  end
end
