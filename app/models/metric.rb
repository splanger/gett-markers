class Metric < ApplicationRecord
  belongs_to :driver
  validates :timestamp, presence: true
  validates :driver_id, presence: true
end
