require 'csv'

namespace :markov do
  desc 'Build the MarkovGen on a corpus of Trump tweets and text'
  task build: :environment do
    puts 'Building models...'
    markovDicts = {}

    3.times {|i| markovDicts[i+1] = build_dict(i+1) }

    trump = MarkovGen.new(markovDicts)

    # write the model out
    File.open("trump.dump","wb") do |file|
      Marshal.dump(trump, file)
    end
  end

  def build_dict(order)
    trump_d = nil
    time = Benchmark.realtime do
      trump_d = MarkovDict.new(order: order)
      CSV.foreach('storage/tweets_1.csv', headers: true, quote_char:'<') do |row|
        trump_d.process_text(row['text']) unless row['is_retweet'] == 'true'
      end
    end
    puts "\tBuilt order: #{order} in time: #{time.round(2)} seconds"
    trump_d
  end

end
