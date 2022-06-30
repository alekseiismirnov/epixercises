class Tournament < ApplicationRecord
  serialize :order # [team_id1, ... ]
  before_create :ordering!

  private

  def ordering!
    self.order = order.sort_by { |id| Team.find(id).scores } if order
  end
end
