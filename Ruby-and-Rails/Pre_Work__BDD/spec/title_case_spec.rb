require 'rspec'
require 'title_case'

describe '#title_case' do
  it 'capitalizes the first letter of the word' do
    expect(title_case('beowulf')).to eq 'Beowulf'
  end

  it 'capitalize first letter of all words in multi-word title' do
    expect(title_case('long long leaf last least')). to eq 'Long Long Leaf Last Least'
  end
end
