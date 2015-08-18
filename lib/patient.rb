class Patient
  attr_reader(:name, :birthday, :doctor_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @birthday = Time.new(attributes.fetch(:birthday))
    @doctor_id = attributes.fetch(:doctor_id)
  end

  define_singleton_method(:all) do
    results = DB.exec("SELECT * FROM patient;")
    patients = []
    results.each() do |each|
      name = each.fetch("name")
      birthday = Time.new(each.fetch("birthday"))
      doctor_id = each.fetch("doctor_id")
      patients.push({:name => name, :birthday => birthday, :doctor_id => doctor_id})
    end
    patients
  end

  def save
    result = DB.exec("INSERT INTO patient (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', #{@doctor_id} )")
  end

  def ==(other)
    self.name == other.name && self.birthday == other.birthday
  end
end
