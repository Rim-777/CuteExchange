shared_examples_for 'Arithmeticable' do
  it 'receives the perform_arithmetic method for the money instance' do
    [:+, :-, :/, :*].each do |operation|
      expect(fifty_eur).to receive(:perform_arithmetic).with(operation, argument).and_call_original
      fifty_eur.send(operation, argument)
    end
  end
end