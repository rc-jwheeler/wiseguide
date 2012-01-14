# Create a Ride Connection organization if it doesn't exist.  Add all
# users to it.
class PopulateInitialOrganization < ActiveRecord::Migration
  def self.up
    ['Ride Connection Staff',
     'Government Body',
     'Case Management Organization',
    ].each do |name|
      OrganizationType.find_or_create_by_name(name)
    end
    type = OrganizationType.find_by_name('Ride Connection Staff')
    rc = Organization.find_or_create_by_name(
      :name => 'Ride Connection',
      :organization_type => type)

    User.all.each do |user|
      if user.organization.nil? then
        user.organization = rc
        user.save! :validate => false
      end   
    end
  end

  def self.down
  end
end