class Animal
  attr_accessor(:id,:name,:gender, :doa,:type,:breed)
  def initialize(attributes)
    @name=attributes.fetch(:name)
    @gender=attributes.fetch(:gender)
    @doa=attributes.fetch(:doa)
    @type=attributes.fetch(:type)
    @breed=attributes.fetch(:breed)
    @id=attributes.fetch(:id)
  end
  def self.all
    my_array=[]
    animals=DB.exec("SELECT * FROM animals WHERE owner IS NULL ORDER BY doa ASC;")
    animals.each() do |animal|
      name=animal.fetch('name')
      gender=animal.fetch('gender')
      doa=animal.fetch('doa')
      type=animal.fetch('type')
      breed=animal.fetch('breed')
      id=animal.fetch('id').to_i()
      new_animal=Animal.new({:id=>id,:name=>name,:gender=>gender,:doa=>doa,:type=>type,:breed=>breed})
      my_array.push(new_animal)
    end
    my_array
  end

  def save
    DB.exec("INSERT INTO animals (name,gender,doa,type,breed) VALUES ('#{@name}',#{@gender},'#{@doa}','#{@type}','#{@breed}');")
  end
  #convert to animal class
  def to_animal
    animal=nil
    animal=Animal.new({:name=>self.name,:gender=>self.gender,:doa=>self.doa,:type=>self.type,:breed=>self.breed})
    animal
  end

  def self.find(id)
    found_animal=nil
    Animal.all.each do |animal|
      animal.id==id ? found_animal=animal : ""
    end
    found_animal
  end

  def update_owner(customer_id)
    DB.exec("UPDATE animals SET owner=#{customer_id} WHERE id=#{self.id};")
  end
end
