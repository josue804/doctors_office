require('spec_helper')


describe(Doctor) do

  describe('#==') do
    it('overrides comparison operator') do
      test_doctor1 = Doctor.new({:name => "Doctor Dolittle", :specialty => "Pets", :id => nil})
      test_doctor2 = Doctor.new({:name => "Doctor Dolittle", :specialty => "Pets", :id => nil})
      expect(test_doctor1).to(eq(test_doctor2))
    end
  end

  describe('.all') do
    it('gets doctor info, stores in hash; empty at first') do
      test_doctor = Doctor.new({:name => "Doctor Death", :specialty => "Psychology", :id => nil})
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a doctor onto the database') do
      test_doctor = Doctor.new({:name => "Doctor Doom", :specialty => "Dentist", :id => nil})
      test_doctor.save()
      expect(Doctor.all()).to(eq([test_doctor]))
    end
  end

  describe('#patients') do
    it('returns an array of patients belonging to a doctor') do
      test_doctor = Doctor.new({:name => "Doctor Dandelion", :specialty => "Monster Hunting", :id => nil})
      test_doctor.save()
      test_patient = Patient.new({:name => "Patricia", :birthday => "1991-11-23", :doctor_id => test_doctor.id().to_i()})
      test_patient.save()
      expect(test_doctor.patients()).to(eq([test_patient]))
    end
  end
end
