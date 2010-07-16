class Storydata < ActiveRecord::Base
  belongs_to :post;
  belongs_to :who;
end
