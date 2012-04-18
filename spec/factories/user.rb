Factory.define :user do |f|
  f.first_name 'Test'
  f.last_name 'User'
  f.email {"user.#{Time.current.to_f}@rideconnection.org"}
  f.association :organization, :factory => :staff_organization
  f.level 0
  f.password "password 1"
  f.password_confirmation { |u| u.password }
end

Factory.define :trainer, :parent => :user do |f|
  f.first_name 'Trainer'
  f.last_name 'User'
  f.email {"trainer.#{Time.current.to_f}@rideconnection.org" }
  f.association :organization, :factory => :staff_organization
  f.level 50
end

Factory.define :admin, :parent => :user do |f|
  f.first_name 'Admin'
  f.last_name 'User'
  f.email {"admin.#{Time.current.to_f}@rideconnection.org"}
  f.association :organization, :factory => :staff_organization
  f.level 100
end

Factory.define :case_manager, :parent => :user do |f|
  f.first_name 'Case'
  f.last_name 'Manager'
  f.email {"case.manager.#{Time.current.to_f}@outside.org"}
  f.association :organization, :factory => :case_mgmt_organization
  f.level 25
end
