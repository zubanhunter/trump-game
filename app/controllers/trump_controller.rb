require 'csv'
require 'benchmark'

class TrumpController < ApplicationController

  def gen
    trump_d = nil
    @time = Benchmark.realtime do
      trump_d = MarkovDict.new(order: 2)
      CSV.foreach('storage/tweets_1.csv', headers: true, quote_char:'<') do |row|
        trump_d.process_text(row['text']) unless row['is_retweet'] == 'true'
      end
    end
    puts "Time: #{@time.round(2)}"

    trump = MarkovGen.new(trump_d)
    @output = trump.get_sentences(3)
  end
end
