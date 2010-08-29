# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def get_random_person(page, divide_equally = true)
    page = Page.find(page) unless page.is_a? Page
    RandomPerson.get(page, divide_equally)
  end
    
  def random_person(collection, divide_equally = true)
    path = "/persons/"

    if divide_equally # equal change to get person from person types
      random_person_equal_groups(collection, path)
    else # equal change for all persons
      random_all_persons(collection, path = nil)
    end
  end

  def random_key(hash) # get random key
    key = hash.keys[rand(hash.size)]
  end  

  def random_hash(collection)
    # get random key
    key = collection.keys[rand(collection.size)]
    { key => collection[key] }
  end

  def random_element(array)
    array[rand(array.size)]
  end

  def random_all_persons(person_collection, path = nil)
    path ||= "/persons/"
    persons = person_collection.person_types.map { |type| type.persons }.flatten
    person = random_element(array)
    path += "#{person.person_type.order}/" + person.attachment.name
  end

  # equal chance to get person from person types
  def random_person_equal_groups(person_collection, path = nil)
    path ||= "/persons/"

    persons_hash = person_collection.person_types.inject({}) do |result, type|
      result[type.order] = type.persons
      result
    end
    rand_item = random_key(persons_hash)
    persons = persons_hash[rand_item]
    path += "#{rand_item}/" + random_element(persons).attachment.name
  end

end
