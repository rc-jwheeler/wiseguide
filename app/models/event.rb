class Event < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :kase
  has_one    :customer, through: :kase
  belongs_to :user
  belongs_to :event_type
  belongs_to :funding_source

  validates_presence_of :kase_id
  validates_presence_of :user_id
  validates :date, timeliness: { on_or_before: lambda { Date.current }, type: :date }
  validates_presence_of :event_type_id
  validates_presence_of :funding_source_id
  validates_numericality_of :duration_in_hours
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :notes, if: lambda { |e| e.event_type.try(:require_notes) }

  default_scope { order(:date) }
  scope :in_range, lambda { |date_range| where(date: date_range) }

  def customer
    return kase.customer
  end

  def start_time
    read_attribute(:start_time).try :to_s, :just_time
  end

  def end_time
    read_attribute(:end_time).try :to_s, :just_time
  end

end
