class MarkovDict
  attr_reader :order

  # Initialized the dictionary with a text source.
  #
  # @example Create a new dictionary of order 1
  #   MarkovChains::Dictionary.new(string)
  # @example Create a new dictinary of order 2
  #   MarkovChains::Dictionary.new(string, 2)
  #
  # @param [String] the text source
  # @param [int] the order of the dictionary. The order is the "memory" of the dictionary, meaning that an order <n> dictionary will consider <n> words to generate the next one. Order of 1 or 2 are typical. More than 3 and the generated sentences will be the same as the source.
  #
  def initialize(order: 1)
    @order = order
    @words_for = {}
    @start_words = []
  end

  def process_text(text)
    cleaned_text = clean_text(text)
    seps = /([.!?]+)/
    sentences = cleaned_text.split seps
    # puts "#{cleaned_text}\n\t#{sentences}"
    sentences.each_slice(2) { |s, t| process_sentence(s.strip, t) }
  end

  # Processes a single sentence with terminator
  #
  # @example Process a sentence
  #   process_sentence("It is sunny today", "!")
  #
  # @param [String] sentence to process
  # @param [Character] sentence terminator
  #
  def process_sentence(sentence, terminator)
    # Consider phrases/words/clauses separators when splitting
    seps = '([,;:\(\)])'

    # Split <sentence> into words
    words = sentence.gsub(/[^#{seps}\w'\s]/, '').gsub(/(#{seps})\s+/, '\1').split(/\s+|#{seps}/)
    return if words.size <= order
    words << terminator

    # puts "\t#{sentence}\n\t\t #{words}"

    # Add <@order> start words to the list
    @start_words << words[0, @order]

    # Add the words to the frequency hash <words_for>
    until words.size < @order + 1
      (@words_for[words[0, @order]] ||= []) << words[@order]
      words.shift
    end
  end

  # Returns a word based on the likelihood of it appearing after the input array of words
  #
  # @example Get a word likely to appear next to the word 'It'
  #   get(['It'])           # => 'has'
  # @example Get a word likely to appear next to the words 'It has been' (with a dictionary of order 2)
  #   get(['It has'])  # => 'been'
  #
  # @param [[String]] array of words for which we want a possible next word
  # @return [String] word that is likely to follow the input
  #
  def get(words)
    (@words_for[words] || []).sample
  end

  # Returns a list of words beginning a sentence seen in the source
  #
  # @example Get a start words
  #   get_start_word    # => ['It', 'has']
  #
  # @return [[String]] array of words that could start a sentence
  #
  def get_start_words
    @start_words.sample
  end

  # Clean text to remove shit
  def clean_text(text)
    text = text.gsub(/(?:f|ht)tps?:\/[^\s]+/, '') # remove urls
    text = text.sub('&amp;', '&')
    text
  end
end
