class Response < ActiveRecord::Base
  validates_presence_of :body
  belongs_to :post
  belongs_to :police
end
