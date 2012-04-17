class Tag < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :submissions
  validates_uniqueness_of :slug


  def self.from_list(list)
    tags = Array.new
    list.split(',').each do |name|
      tag = self.find_or_initialize_by_name(:name => name)
      if tag.valid? and tag.save
        tags << tag
      end
    end
    tags
  end

end