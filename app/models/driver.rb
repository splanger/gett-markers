class Driver < ApplicationRecord
  has_many :metrics, dependent: destroy
end
