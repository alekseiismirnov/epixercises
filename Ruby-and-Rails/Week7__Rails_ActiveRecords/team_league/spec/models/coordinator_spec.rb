require 'rails_helper'

describe Coordinator do
  it { should belong_to(:team) }
end
