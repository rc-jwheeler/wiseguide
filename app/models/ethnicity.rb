class Ethnicity < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  has_paper_trail
end
