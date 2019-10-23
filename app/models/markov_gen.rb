class MarkovGen
  attr_reader :model_version

  # Initializes the generator
  # markovDict should be a hash of order => MarkovDict
  #
  def initialize(markovDicts)
    @dicts = markovDicts
    @model_version = @dicts.hash
  end

  # Returns a given number of randonly generated sentences
  #
  # @example Get 5 sentences
  #   get_sentences(5)
  #
  # @param n [int] number of sentences to generate
  # @param order [int] order of model to use
  # @return Array conataining generated sentences
  #
  def get_sentences(n, order = 2)
    sentences = []
    dict = @dicts[order]

    n.times do
      sentence = dict.get_start_words

      while nw = dict.get(sentence[-dict.order, dict.order])
        sentence << nw
      end

      sentences << (sentence[0...-1].join(' ').gsub(/\s([,;:])/, '\1') << sentence.last)
    end

    sentences
  end
  end
