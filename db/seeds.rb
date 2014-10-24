# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


["Administrator", "Instructor", "Student", "Parent"].each do |role|
  Role.find_or_create_by_name(role)
end

{:Textbooks=>"textbook_delegations", :Videos=>"videos", :Documents=>"documents", :Links=>"links", "Plain Text"=>"textboxes"}.each do |name, model|
  CourseAssetModelType.find_or_create_by_name_and_name_of_model(:name=>name, :name_of_model=>model)
end

