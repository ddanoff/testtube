class BaselineTask < ActiveRecord::Base
  belongs_to :StoryType
  attr_accessible :description, :is_sensitive_to_size, :name, :review_team_size, :small_doit_loe_hours
  validates :name, 
    :uniqueness => {:message => "name must be unique", :scope => :story_type_id}
end
