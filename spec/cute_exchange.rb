require 'spec_helper'
RSpec.describe CuteExchange do

  describe '.create_money' do
    it 'receives the "new" method for the "Money" class with given arguments' do
      expect(Money).to receive(:new).with(50, 'EUR')
      CuteExchange.create_money(50, 'EUR')
    end
  end

  describe '.conversion_rates' do
    it 'receives the "conversion_rates" method for the "Money" class with given arguments' do
      expect(Money).to receive(:conversion_rates).with('EUR', 'USD' => 1.11, 'RUB' => 70)
      CuteExchange.conversion_rates('EUR', 'USD' => 1.11, 'RUB' => 70)
    end
  end
end
