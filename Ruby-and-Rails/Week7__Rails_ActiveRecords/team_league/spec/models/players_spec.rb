require 'rails_helper'

describe Player do
  it { should belong_to(:team) }
end
