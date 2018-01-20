require 'spec_helper'

RSpec.describe Money do
  let(:fifty_eur) {Money.new(50, 'EUR')}
  let(:fifty_five_dollars_fifty_cent) {Money.new(55.5, 'USD')}

  before do
    Money.conversion_rates('EUR', 'USD' => 1.11, 'RUB' => 70)
  end

  describe '.conversion_rates' do
    it 'assigns right values' do
      expect(Money.base).to eq 'EUR'
      expect(Money.rates).to eq 'USD' => 1.11, 'RUB' => 70
    end
  end

  describe '#attr_readers' do
    describe '#amount' do
      it 'returns 50' do
        expect(fifty_eur.amount).to eq 50
      end
    end

    describe '#currency' do
      it 'returns EUR' do
        expect(fifty_eur.currency).to eq 'EUR'
      end
    end
  end

  describe '#inspect' do
    it 'precents the money instance with default precision' do
      expect(fifty_eur.inspect).to eq '50.00 EUR'
    end

    it 'precents the money instance with the given precision' do
      expect(Money.new(0.1234567, 'Bitcoin').inspect(precision: 4)).to eq '0.1235 Bitcoin'
    end
  end

  describe '#convert_to' do
    context 'convert the base currency to other currency' do
      it 'returns the Money instans with currency: USD and amount: 50*1.11' do
        expect(fifty_eur.convert_to('USD')).to eq Money.new(55.5, 'USD')
      end

      it 'receives the method convert_to_base for the Money instance' do
        expect(fifty_eur).to receive(:convert_to_base).and_call_original
        fifty_eur.convert_to('USD')
      end

      it 'receives the method rate_by for the Money instance with USD as an argument' do
        expect(fifty_eur).to receive(:rate_by).with('USD').and_call_original
        fifty_eur.convert_to('USD')
      end
    end

    context 'convert an other currency to the base currency' do
      it 'returns the Money instance with the currency: EUR and amount 50' do
        expect(fifty_five_dollars_fifty_cent.convert_to('EUR')).to eq Money.new(50, 'EUR')
      end

      it 'receives the method convert_to_base for the Money instance' do
        expect(fifty_five_dollars_fifty_cent).to receive(:convert_to_base).and_call_original
        fifty_five_dollars_fifty_cent.convert_to('EUR')
      end
    end

    context 'convert an other currency to another currency' do
      it 'returns the Money instance with the currency:RUB and amount 3500' do
        expect(fifty_five_dollars_fifty_cent.convert_to('RUB')).to eq Money.new(3500, 'RUB')
      end

      it 'receives the method convert_to_base for the Money instance' do
        expect(fifty_five_dollars_fifty_cent).to receive(:convert_to_base).and_call_original
        fifty_five_dollars_fifty_cent.convert_to('RUB')
      end

      it 'receives the method rate_by for the Money instance with USD as an argument' do
        expect(fifty_five_dollars_fifty_cent).to receive(:rate_by).with('RUB').and_call_original
        fifty_five_dollars_fifty_cent.convert_to('RUB')
      end
    end
  end

  describe '#convert_to_base' do
    it 'returns a BigDecimal instance' do
      expect(fifty_five_dollars_fifty_cent.send(:convert_to_base)).to be_a(BigDecimal)
    end

    context 'the method is called for the base currency' do
      it 'returns the ammount of the base currency' do
        expect(fifty_eur.send(:convert_to_base)).to eq fifty_eur.amount
      end
    end

    context 'the method is called for the other currency' do
      it 'returns the converted ammount of the currency' do
        expect(fifty_five_dollars_fifty_cent.send(:convert_to_base)).to eq 50
      end
    end
  end

  describe '#rate_by(currency)' do
    it 'returns the rate of the given currency from the established rates' do
      expect(fifty_eur.send(:rate_by, 'USD')).to eq 1.11
      expect(fifty_eur.send(:rate_by, 'RUB')).to eq 70
    end
  end

  describe '#perform_arithmetic' do
    context 'the number as an argument' do
      it 'gets an operation and number as an argument and performs the operation' do
        expect(fifty_eur.send(:perform_arithmetic, :+, 50)).to eq Money.new(100, 'EUR')
        expect(fifty_eur.send(:perform_arithmetic, :-, 30)).to eq Money.new(20, 'EUR')
        expect(fifty_eur.send(:perform_arithmetic, :/, 2)).to eq Money.new(25, 'EUR')
        expect(fifty_eur.send(:perform_arithmetic, :*, 2)).to eq Money.new(100, 'EUR')
      end

      it "returns a new Money instans and doesn't change the initial instance" do
        fifty_eur.send(:perform_arithmetic, :+, 50)
        expect(fifty_eur.amount).to eq 50
      end
    end

    context 'the money instance as an arument' do
      it 'gets an operation and a money instanse and performs the operation' do
        expect(fifty_eur.send(:perform_arithmetic, :+, Money.new(100, 'EUR')))
            .to eq Money.new(150, 'EUR')
        expect(fifty_eur.send(:perform_arithmetic, :-, Money.new(33.3, 'USD')))
            .to eq Money.new(20, 'EUR')
      end

      it "returns a new Money instans and doesn't change the initial instance" do
        fifty_eur.send(:perform_arithmetic, :+, Money.new(100, 'EUR'))
        expect(fifty_eur.amount).to eq 50
      end
    end
  end

  describe '#arithmetic methods :+,:-,:/, :*' do
    context 'the number as an argument' do
      it 'receives the perform_arithmetic method for the money instance' do
        [:+, :-, :/, :*].each do |operation|
          expect(fifty_eur).to receive(:perform_arithmetic).with(operation, 50).and_call_original
          fifty_eur.send(operation, 50)
        end
      end
    end

    context 'the money instance as an argument' do
      let(:argument) {Money.new(50, 'USD')}

      it 'receives the perform_arithmetic method for the money instance' do
        [:+, :-, :/, :*].each do |operation|
          expect(fifty_eur).to receive(:perform_arithmetic).with(operation, argument).and_call_original
          fifty_eur.send(operation, argument)
        end
      end
    end
  end

  describe '#comparisons' do
    let(:twenty_dollars) {Money.new(20, 'USD')}

    it 'makes the right comparisons' do
      expect(twenty_dollars < fifty_eur).to be_truthy
      expect(twenty_dollars != fifty_eur).to be_truthy
      expect(twenty_dollars >= fifty_eur).to be_falsey
      expect(fifty_eur == fifty_eur).to be_truthy
      expect(fifty_five_dollars_fifty_cent == fifty_eur).to be_truthy
    end
  end
end
