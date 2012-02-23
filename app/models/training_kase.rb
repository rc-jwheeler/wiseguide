class TrainingKase < Kase
  validates_presence_of  :funding_source_id
  validates_inclusion_of :county, :in => VALID_COUNTIES.values
end