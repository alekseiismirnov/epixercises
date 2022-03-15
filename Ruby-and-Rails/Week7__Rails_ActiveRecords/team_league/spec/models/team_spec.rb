require 'rails_helper'

describe Team do
  it { should have_many(:players) }
  it { should have_one(:coordinator) }
end
