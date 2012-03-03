class Vote < ActiveRecord::Base
	# Relationships
	belongs_to :user
	belongs_to :submission, {:foreign_key => :item_id}

	# Validations
	validates_uniqueness_of :user_id, {:scope => :item_id}

end