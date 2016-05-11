RSpec.shared_examples 'a valid merchant' do
  it 'generates a valid merchant' do
    expect(subject).to be_valid
    expect(subject).to be_a Merchant
  end

  it 'has the correct attribute values' do
    expect(subject.name).to eq data[:merchant][:name]
    expect(subject.emoji).to eq data[:merchant][:emoji]
  end
end
