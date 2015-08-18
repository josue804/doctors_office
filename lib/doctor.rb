class Doctor
  attr_reader(:name, :specialty, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id)
  end

  def == (other)
    self.name == other.name && self.specialty == other.specialty
  end

  define_singleton_method(:all) do
    results = DB.exec ('SELECT * FROM doctor;')
    doctor = []
    results.each do |result|
      name = result.fetch("name")
      specialty = result.fetch("specialty")
      id = result.fetch("id").to_i
      doctor.push(Doctor.new({:name => name, :specialty => specialty, :id => id}))
    end
    doctor
  end

  def save
    result = DB.exec("INSERT INTO doctor(name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id")
    @id = result.first().fetch("id").to_i();
  end

  def patients
    results = DB.exec("SELECT * FROM patient WHERE doctor_id=#{@id};")
    patients = []
    results.each() do |patient|
      name = patient.fetch("name")
      birthday = patient.fetch("birthday")
      doctor_id = patient.fetch("doctor_id").to_i
      patients.push(Patient.new({:name => name, :birthday => birthday, :doctor_id => doctor_id}))
    end
    patients
  end
end
