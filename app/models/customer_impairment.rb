class CustomerImpairment < ActiveRecord::Base
  belongs_to :customer
  belongs_to :impairment
  stampable :creator_attribute => :created_by_id
  belongs_to :created_by, :foreign_key => :created_by_id, :class_name=>'User'

end
