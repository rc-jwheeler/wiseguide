module DevelopmentKaseBehavior
  def self.included(base_class)
    base_class.class_eval do
      belongs_to :referral_type
      belongs_to :funding_source
      
      has_one  :assessment_request, :dependent => :nullify, :foreign_key => :kase_id
      has_many :events, :dependent => :destroy, :foreign_key => :kase_id
      has_many :response_sets, :dependent => :destroy, :foreign_key => :kase_id
      has_many :kase_routes, :dependent => :destroy, :foreign_key => :kase_id
      has_many :routes, :through => :kase_routes, :foreign_key => :kase_id
      has_many :outcomes, :dependent => :destroy, :foreign_key => :kase_id
      has_many :referral_documents, :dependent => :destroy, :foreign_key => :kase_id
      has_many :trip_authorizations, :dependent => :destroy, :foreign_key => :kase_id
      
      validates_presence_of :referral_type_id
      validates             :household_income,     :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }, :allow_blank => true
      validates             :household_size,       :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }, :allow_blank => true
      validates             :adult_ticket_count,   :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }, :allow_blank => true
      validates             :honored_ticket_count, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }, :allow_blank => true
      validates             :household_income_alternate_response, :inclusion => { :in => %w( Unknown Refused ) }, :allow_blank => true
      validates             :household_size_alternate_response,   :inclusion => { :in => %w( Unknown Refused ) }, :allow_blank => true
      
      before_save :cleanup_household_stats
      
      scope :for_funding_source_id, lambda {|funding_source_id| funding_source_id.present? ? where(:funding_source_id => funding_source_id) : where(true) }
    end
  end
  
  def cleanup_household_stats
    self.household_income = nil if !self.household_income_alternate_response.blank?
    self.household_size = nil if !self.household_size_alternate_response.blank?
  end
end