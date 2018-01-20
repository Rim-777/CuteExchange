shared_examples_for 'Unchangeble' do
  it "returns a new Money instans and doesn't change the initial instance" do
    fifty_eur.send(:perform_arithmetic, :+, argument)
    expect(fifty_eur.amount).to eq 50
  end
end