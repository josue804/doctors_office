require('sinatra')
require('sinatra/reloader')
require('./lib/doctor')
require('./lib/patient')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'doctor_office'})

get('/') do
  erb(:index)
end

get('/doctors/new') do
  erb(:doctors_form)
end

get('/doctors') do
  @doctors = Doctor.all()
  erb(:doctors)
end

post('/doctors') do
  name = params.fetch('name')
  specialty = params.fetch('specialty')
  @doctor = Doctor.new({:name => name, :specialty => specialty, :id => nil})
  @doctor.save()
  erb(:doctors)
end

get('/doctors/:id/new') do

  erb(:patients_form)
end

get('/doctors/:id') do
   @doctor_id = params.fetch('id').to_i()
   erb(:patients)
end

post('/doctors/:id') do
  @doctor_id = params.fetch('id').to_i()
  name = params.fetch('name')
  birthday = params.fetch('birthday')
  @patient = Patient.new({:name => name, :birthday => birthday, :doctor_id => @doctor_id})
  erb(:patients)
end
