class Portfolio < ActiveRecord::Base
  scope :descending, -> { order('id DESC') }

end
