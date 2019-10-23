# Initialize the trump markov generator from a saved object.
File.open('trump.dump', 'rb') { |f| ::Trump = Marshal.load(f) }
puts "Loaded trump_gen version: #{Trump.model_version}"
