Gem::Specification.new do |spec|
  spec.name            = 'cute_exchange'
  spec.version         = '1.0.1'
  spec.date            = '2018-01-20'
  spec.summary         = 'Gem for the money conversion'
  spec.authors         = ["Timo Moss"]
  spec.description     = 'implement the money conversion in your Ruby project'

  spec.email           = 'rails.moss@gmail.com'
  spec.homepage        = 'http://rubygems.org/gem/cute_exchange'
  spec.license         = 'MIT'

  spec.files           = [
      "lib/cute_exchange.rb",
      "lib/cute_exchange/money.rb"
  ]

  spec.add_runtime_dependency 'bigdecimal', '~> 1.2', '>= 1.2.7'

  spec.requirements = %w{
  Good\ mood
  A\little\ courage
  }
end
