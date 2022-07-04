describe Game do
  it { should belong_to(:winner) }
  it { should belong_to(:loser) }
  it { should validate_presence_of(:scores) }
  it { should validate_numericality_of(:scores) }
end
