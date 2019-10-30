class MarkovGen
  # Initializes the generator
  # markovDict should be a hash of order => MarkovDict
  #
  def initialize(markovDicts, reference_texts)
    @dicts = markovDicts
    @reference_texts = reference_texts
    @model_version = @dicts.hash
  end

  def model_version
    @model_version.abs.to_s(16)
  end

  def model_orders
    @dicts.keys
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

    ref_ids = []

    n.times do
      sentence = dict.get_start_words

      while nw = dict.get(sentence[-dict.order, dict.order])
        ref_ids += dict.get_references(sentence[-dict.order, dict.order])
        sentence << nw
      end

      sentences << (sentence[0...-1].join(' ').gsub(/\s([,;:])/, '\1') << sentence.last)
    end

    [sentences, ref_ids]
  end

  def sample_ref_texts(ref_ids, n=10)
    @reference_texts.fetch_values(*ref_ids.sample(n))
  end
end
