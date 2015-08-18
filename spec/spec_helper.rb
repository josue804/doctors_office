require('rspec')
require('doctor')
require('patient')
require('pg')

DB = PG.connect({:dbname => 'doctor_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctor *;")
    DB.exec("DELETE FROM patient *;")
  end
end
