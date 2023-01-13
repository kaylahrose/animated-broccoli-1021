require 'rails_helper'

RSpec.describe 'hospital show page' do
#   Extension, Hospital Show Page
# ​
# As a visitor
# When I visit a hospital's show page
# I see the hospital's name
# And I see the names of all doctors that work at this hospital,
# And next to each doctor I see the number of patients associated with the doctor,
# And I see the list of doctors is ordered from most number of patients to least number of patients
# (Doctor patient counts should be a single query)
  it 'lists hospital name and all doctors working there' do
    hospital = Hospital.create!(name: "University of California San Diego La Jolla")
    doc1 = hospital.doctors.create!(name: "Jessica Schulte", specialty: "Nuero-oncology", university: "Northwestern University Feinberg School of Medicine")
    doc2 = hospital.doctors.create!(name: "Anhnhi Tran", specialty: "Physical Therapy", university: "University of South Florida")
    patient1 = Patient.create!(name: 'John Doe', age: 70)
    patient2 = Patient.create!(name: 'Jane Doe', age: 40)
    patient3 = Patient.create!(name: 'Emma Doe', age: 50)
    patient4 = Patient.create!(name: 'Alex Doe', age: 60)
    patient5 = Patient.create!(name: 'Tim Cook', age: 60)
    DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient1.id)
    DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient2.id)
    DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient3.id)
    DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient4.id) 
    DoctorPatient.create!(doctor_id: doc2.id, patient_id: patient1.id) 

    visit hospital_path(hospital)

    expect(page).to have_content(hospital.name + " Hospital")
    expect(page).to have_content("Doctors on staff:\n" + doc1.name)
    expect(page).to have_content(doc2.name)
  end

  it 'does not list other hospital information' do
    hospital1 = Hospital.create!(name: "University of California San Diego La Jolla")
    doc1 = hospital1.doctors.create!(name: "Jessica Schulte", specialty: "Nuero-oncology", university: "Northwestern University Feinberg School of Medicine")
    doc2 = hospital1.doctors.create!(name: "Anhnhi Tran", specialty: "Physical Therapy", university: "University of South Florida")
    hospital2 = Hospital.create!(name: "UC San Francisco Weill Institute for Neurosciences")
    doc3 = hospital2.doctors.create!(name: "Meredith Grey", specialty: "general surgery", university: "Harvard University")
    
    visit hospital_path(hospital1)

    expect(page).to have_no_content(doc3.name)
  end

  it 'shows number of patients next to each doctor and orders docs by patient count' do
    hospital = Hospital.create!(name: "University of California San Diego La Jolla")
    doc1 = hospital.doctors.create!(name: "Jessica Schulte", specialty: "Nuero-oncology", university: "Northwestern University Feinberg School of Medicine")
    doc2 = hospital.doctors.create!(name: "Anhnhi Tran", specialty: "Physical Therapy", university: "University of South Florida")
    patient1 = Patient.create!(name: 'John Doe', age: 70)
    patient2 = Patient.create!(name: 'Jane Doe', age: 40)
    patient3 = Patient.create!(name: 'Emma Doe', age: 50)
    patient4 = Patient.create!(name: 'Alex Doe', age: 60)
    patient5 = Patient.create!(name: 'Tim Cook', age: 60)
    DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient1.id)
    DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient2.id)
    DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient3.id)
    DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient4.id) 
    DoctorPatient.create!(doctor_id: doc2.id, patient_id: patient1.id) 
    
    visit hospital_path(hospital)

    expect(doc1.name).to appear_before(doc2.name)
    within ("#doctor-#{doc1.id}") do
      expect(page).to have_content("Patients: #{doc1.patient_count}")
    end
    within ("#doctor-#{doc2.id}") do
      expect(page).to have_content("Patients: #{doc2.patient_count}")
    end
  end
  it 'lists doctors ordered by patient count'
end