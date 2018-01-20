require 'bigdecimal'

class Money
  include Comparable

  class << self
    attr_reader :base, :rates

    def conversion_rates(base, rates = {})
      @base = base
      @rates = rates
    end
  end

  attr_reader :amount, :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def convert_to(target)
    return self if target == currency
    result = target == Money.base ? convert_to_base : convert_to_base * rate_by(target)
    self.class.new(result.to_s('F'), target)
  end

  def inspect(options={})
    precision = options[:precision] || 2
    "#{"%.#{precision}f" % amount} #{currency}"
  end

  def + arg
    perform_arithmetic(__method__, arg)
  end

  def - arg
    perform_arithmetic(__method__, arg)
  end

  def / arg
    perform_arithmetic(__method__, arg)
  end

  def * arg
    perform_arithmetic(__method__, arg)
  end

  def <=>(arg)
    BigDecimal(amount.to_s)  <=> BigDecimal(arg.convert_to(currency).amount.to_s)
  end

  private
  def convert_to_base
    return BigDecimal(amount.to_s) if currency == Money.base
    BigDecimal(amount.to_s) /  Money.rates.fetch(currency)
  end

  def rate_by(currency)
    Money.rates.fetch(currency)
  end

  def perform_arithmetic(operation, arg)
    converted_amount = arg.is_a?(Numeric) ? arg : arg.convert_to(currency).amount
    new_amount = BigDecimal(amount.to_s).send(operation, BigDecimal(converted_amount.to_s))
    self.class.new(new_amount, currency)
  end
end
