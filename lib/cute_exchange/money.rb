class Money
  class << self
    attr_reader :base, :rates

    def conversion_rates(base, rates = {})
      @base = base
      @rates = rates
    end
  end
end
