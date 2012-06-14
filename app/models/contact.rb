class Contact < ActiveRecord::Base
  belongs_to :user
  stampable :creator_attribute => :created_by_id, :updater_attribute => :updated_by_id
  belongs_to :created_by, :foreign_key => :created_by_id, :class_name=>'User'
  belongs_to :updated_by, :foreign_key => :updated_by_id, :class_name=>'User'
  belongs_to :contactable, :polymorphic => true

  validates :description, :presence => true, :length => {:maximum => 200}
  validates :date_time, :date => { :before_or_equal_to => Proc.new {Time.current} }
  validates :contactable_type, :inclusion => { :in => %w(AssessmentRequest Customer Kase CoachingKase TrainingKase) }
  validates :contactable, :presence => true, :associated => true

  default_scope order(:date_time)
end
