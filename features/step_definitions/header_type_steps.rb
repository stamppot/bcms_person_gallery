Given /^I have no product types$/ do
  PersonType.delete_all
end

Given /^I have product types named (.+)$/ do |names|
  names.split(' and ').each do |name|
    Factory(:person_type, :name => name)
  end
end

Given /^the following user records$/ do |table|
  table.hashes.each do |hash|
    current_user = User.create(:login => hash[:first_name].gsub(/\ /, ''), :first_name => hash[:first_name], :last_name => "", :email => "foo@bar.com", :password => "password", :password_confirmation => "password")
    hash[:groups].split(', ').each do |group|
      current_user.groups << Group.find_by_name(group)
    end
  end
end

When /^I browse persons by type ([^\"]*)$/ do |person_type|
  click_link person_type
end

Then /^I should have ([0-9]+) product types?$/ do |count|
  PersonType.count.should == count.to_i
end
