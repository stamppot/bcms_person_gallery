class RandomPerson
  def self.get(page, divide_equally = true)
    if page.is_a? Array
      page = page.first
    elsif page.is_a? Integer
      page = Page.find page
    end
    sections = page.section.ancestors << page.section
    sections.reverse.each do |section|
      if person_collection = PersonCollection.find_by_section_id(section.id)
        return self.random_person(person_collection, divide_equally)
      end
    end
  end

  private 
  def self.random_person(collection, divide_equally = true)
    path = "/persons/"

    if divide_equally # equal change to get person from person types
      self.random_person_equal_groups(collection, path)
    else # equal change for all persons
      self.random_all_persons(collection, path = nil)
    end
  end

  def self.random_key(hash) # get random key
    key = hash.keys[rand(hash.size)]
  end  

  def self.random_hash(collection)
    # get random key
    key = collection.keys[rand(collection.size)]
    { key => collection[key] }
  end

  def self.random_element(array)
    array[rand(array.size)]
  end

  def random_all_persons(person_collection, path = nil)
    path ||= "/persons/"
    persons = person_collection.person_types.map { |type| type.persons }.flatten
    person = self.random_element(array)
    path += "#{person.person_type.position}/" + person.attachment.name
  end

  # equal chance to get person from person types
  def self.random_person_equal_groups(person_collection, path = nil)
    path ||= "/persons/"

    persons_hash = person_collection.person_types.inject({}) do |result, type|
      result[type.position] = type.persons
      result
    end
    rand_item = self.random_key(persons_hash)
    persons = persons_hash[rand_item]
    path += "#{rand_item}/" + self.random_element(persons).attachment.name
  end
end