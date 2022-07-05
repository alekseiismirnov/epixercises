class Tournament < ApplicationRecord
  serialize :order # [team_id1, ... ]
  before_create :order_it!

  private

  def order_it!
    self.order = order.sort_by { |id| Team.find(id).scores } if order
  end
end
