class Who < ActiveRecord::Base
  validates :name, :presence=>true
  has_many :post
end
