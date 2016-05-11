RSpec.shared_examples 'a valid transaction' do
  it 'generates a valid transaction' do
    expect(subject).to be_valid
    expect(subject).to be_a Transaction
  end

  it 'has the correct attribute values' do
    expect(subject.mondo_id).to eq data[:id]
    expect(subject.data[:amount]).to eq data[:amount]
  end
end
