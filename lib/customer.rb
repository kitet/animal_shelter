class Customer
  attr_accessor(:id, :name, :phone,:type_pref,:breed_pref)
  def initialize(attributes)
    @id=attributes.fetch(:id)
    @name=attributes.fetch(:name)
    @phone=attributes.fetch(:phone)
    @type_pref=attributes.fetch(:type_pref)
    @breed_pref=attributes.fetch(:breed_pref)
  end
  def self.all
    my_array=[]
    customers=DB.exec("SELECT * FROM customers;")
    customers.each() do |customer|
      name=customer.fetch('name')
      phone=customer.fetch('phone')
      type=customer.fetch('type_pref')
      breed=customer.fetch('breed_pref')
      id=customer.fetch('id')
      new_customer=Customer.new({:id=>id,:name=>name,:phone=>phone,:type_pref=>type,:breed_pref=>breed})
      my_array.push(new_customer)
    end
    my_array
  end
  def save
    DB.exec("INSERT INTO customers (name,phone,type_pref,breed_pref) VALUES ('#{@name}',#{@phone},'#{@type_pref}','#{@breed_pref}');")
  end

  def self.find_by_breed(breed,type)
    i_customers=[]
    allcustomers=DB.exec("SELECT * FROM customers WHERE breed_pref='#{breed}' AND type_pref='#{type}';")
    allcustomers.each() do |customer|
      id=customer.fetch('id')
      name=customer.fetch('name')
      phone=customer.fetch('phone')
      type=customer.fetch('type_pref')
      breed=customer.fetch('breed_pref')
      new_icustomer=Customer.new({:id=>id,:name=>name,:phone=>phone,:type_pref=>type,:breed_pref=>breed})
      i_customers.push(new_icustomer)
    end
    i_customers
  end
end
