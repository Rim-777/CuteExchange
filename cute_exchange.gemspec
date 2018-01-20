Gem::Specification.new do |spec|
  spec.name            = 'cute_exchange'
  spec.version         = '1.0.1'
  spec.date            = '2018-01-20'
  spec.summary         = 'Gem fo the money conversion'
  spec.authors         = ["Timo Moss"]
  spec.description     = 'implement the money conversion in your Ruby project'

  spec.email           = 'rails.moss@gmail.com'
  spec.homepage        = 'http://rubygems.org/gem/cute_exchange'
  spec.license         = 'MIT'

  spec.files           = [
      "lib/cute_exchange.rb",
      "lib/cute_exchange/money.rb"
  ]

  spec.add_runtime_dependency 'bigdecimal'

  spec.requirements = %w{
  Internet\ connection
  Good\ mood
  A\little\ courage
  }
end
