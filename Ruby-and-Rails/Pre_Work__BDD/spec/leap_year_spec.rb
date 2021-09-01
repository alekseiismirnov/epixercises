require 'leap_year'
require 'rspec'

describe '#leap_year' do
  it 'false, when year not divisible by 4' do
    expect(leap_year?(1911)).to be false
  end
end
