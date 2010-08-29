Given /^I have the following persons$/ do |table|
  table.hashes.each do |hash|
    Factory(:product, :item_number => hash['item number'],
      :person_type => PersonType.find_by_name(hash['type'], :first),
      :published => hash['published'] == 'yes' ? true : false)
  end
end

Then /^I should have ([0-9]+) persons?$/ do |count|
  Person.count.should == count.to_i
end