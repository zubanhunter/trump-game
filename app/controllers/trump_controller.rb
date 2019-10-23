class TrumpController < ApplicationController

  def gen
    @output = Trump.get_sentences(6, 3)
  end
end
