class Who < ActiveRecord::Base
  validates_presence_of :name
  has_many :post
end
