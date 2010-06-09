class Response < ActiveRecord::Base
  validates :body, :presence=>true
  belongs_to :post
  belongs_to :police
end
