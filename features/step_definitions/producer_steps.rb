Given /^I have producers named (.+)$/ do |names|
  names.split(' and ').each do |name|
    Factory(:producer, :name => name)
  end
end

Given /^I have no producers?$/ do
  Producer.delete_all
end

Then /^I should have ([0-9]+) producers?$/ do |count|
  Producer.count.should == count.to_i
end