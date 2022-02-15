require 'rails_helper'

describe Sight do
  it { should belong_to(:animal) }
  it { should belong_to(:region) }
end
