class Animal < ApplicationRecord
  has_many :sights, dependent: :destroy
end
