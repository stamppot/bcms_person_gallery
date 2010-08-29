Factory.define :person_type do |f|
  f.sequence(:name) { |n| "Shawl#{n}" }
  f.published true
end

Factory.define :wool_type do |f|
  f.sequence(:name) { |n| "Sheep#{n}" }
  f.published true
end

Factory.define :producer do |f|
  f.sequence(:name) { |n| "Bob#{n}" }
  f.published true
end

Factory.define :product do |f|
  f.sequence(:item_number) { |n| "W00#{n}" }
  f.person_type { |person_type| person_type.association(:person_type) }
  f.wool_type { |wool_type| wool_type.association(:wool_type) }
  f.producer { |producer| producer.association(:producer) }
  f.summary_description 'Summary description goes here.'
  f.description 'Person description goes here.'
end
