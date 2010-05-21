class Response < ActiveRecord::Base
  validates :body, :presence=>true, :length=>{:minimum=>10}
  belongs_to :post
  belongs_to :police
end
