class Submission < ActiveRecord::Base

  # Validations
  validates_presence_of :title, :description, :url, :user_id

  # Associations
  belongs_to :user
  has_many :votes, :foreign_key => :item_id

end
