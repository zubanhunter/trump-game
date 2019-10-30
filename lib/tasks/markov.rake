require 'csv'

namespace :markov do
  desc 'Build the MarkovGen on a corpus of Trump tweets and text'
  task build: :environment do
    puts 'Building models...'
    markov_dicts = {}
    reference_texts = {}
    orders = (1..5)
    orders.each { |order| markov_dicts[order] = MarkovDict.new(order: order) }

    CSV.foreach('storage/tweets_1.csv', headers: true, quote_char:'<') do |row|
      next if row['is_retweet'] == 'true'
      orders.each { |order| markov_dicts[order].process_text(row['text'], row['id_str']) }
      reference_texts[row['id_str']] = row['text']
    end

    CSV.foreach('storage/tweets_2.csv', headers: true, quote_char:'<') do |row|
      next if row['is_retweet'] == 'true'
      orders.each { |order| markov_dicts[order].process_text(row['text'], row['id_str']) }
      reference_texts[row['id_str']] = row['text']
    end

    trump = MarkovGen.new(markov_dicts, reference_texts)

    # write the model out
    File.open("trump.dump","wb") do |file|
      Marshal.dump(trump, file)
    end
  end

end
