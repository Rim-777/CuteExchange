require 'spec_helper'

RSpec.describe Money do
  describe '.conversion_rates' do
    it 'assigns right values' do
      Money.conversion_rates('EUR', 'USD' => 1.11, 'RUB' => 70)
      expect(Money.base).to eq 'EUR'
      expect(Money.rates).to eq 'USD' => 1.11, 'RUB' => 70
    end
  end
end
