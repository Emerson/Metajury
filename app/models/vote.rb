class Vote < ActiveRecord::Base
	# Relationships
	belongs_to :user
	belongs_to :submission, {:foreign_key => :item_id}
  belongs_to :comment, {:foreign_key => :item_id}

	# Named Scopes
	scope :are, lambda { |type| where(:vote_type => type) }

	# Validations
	validates_uniqueness_of :user_id, {:scope => :item_id}
  validates_uniqueness_of :user_id, {:scope => :item_id}

end