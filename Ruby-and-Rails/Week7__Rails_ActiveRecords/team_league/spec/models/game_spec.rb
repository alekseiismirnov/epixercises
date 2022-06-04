describe Game do
  it { should belong_to(:winner) }
  it { should belong_to(:loser) }
end
