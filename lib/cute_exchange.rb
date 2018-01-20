Dir["#{File.dirname(__FILE__)}/cute_exchange/**/*.rb"].each {|f| require f}

module CuteExchange
  def self.create_money(amount, currency)
    Money.new(amount, currency)
  end

  def self.conversion_rates(base, rates = {})
    Money.conversion_rates(base, rates)
  end
end
