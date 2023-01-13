require 'rails_helper'

RSpec.describe 'doctor show page' do
  it 'lists doctors attributes, hospital, and lists patients' do
    hospital = Hospital.create!(name: "University of California San Diego La Jolla")
    doc = hospital.doctors.create!(name: "Jessica Schulte", specialty: "Nuero-oncology", university: "Northwestern University Feinberg School of Medicine")
    patient1 = Patient.create!(name: 'John Doe', age: 70)
    patient2 = Patient.create!(name: 'Jane Doe', age: 40)
    patient3 = Patient.create!(name: 'Emma Doe', age: 50)
    patient4 = Patient.create!(name: 'Alex Doe', age: 60)
    patient5 = Patient.create!(name: 'Tim Cook', age: 60)
    DoctorPatient.create!(doctor_id: doc.id, patient_id: patient1.id)
    DoctorPatient.create!(doctor_id: doc.id, patient_id: patient2.id)
    DoctorPatient.create!(doctor_id: doc.id, patient_id: patient3.id)
    DoctorPatient.create!(doctor_id: doc.id, patient_id: patient4.id)

    visit doctor_path(doc)

    expect(page).to have_content("Dr. #{doc.name}")
    expect(page).to have_content("Specialty: #{doc.specialty}")
    expect(page).to have_content("Medical Degree from: #{doc.university}")
    expect(page).to have_content("Working at: #{doc.hospital.name}")
    expect(page).to have_content(patient1.name)
    expect(page).to have_content(patient2.name)
    expect(page).to have_content(patient3.name)
    expect(page).to have_content(patient4.name)
    expect(page).to have_no_content(patient5.name)
  end

  it 'does not list other doctors information' do
    hospital = Hospital.create!(name: "University of California San Diego La Jolla")
    doc1 = hospital.doctors.create!(name: "Jessica Schulte", specialty: "Nuero-oncology", university: "Northwestern University Feinberg School of Medicine")
    doc2 = hospital.doctors.create!(name: "Anhnhi Tran", specialty: "Physical Therapy", university: "University of South Florida")
    
    visit doctor_path(doc1)

    expect(page).to have_content("Dr. #{doc1.name}")
    expect(page).to have_no_content("Dr. #{doc2.name}")
  end

  it 'removes a patient from a doctor' do
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

    visit doctor_path(doc2)
    expect(page).to have_content(patient1.name)

    visit doctor_path(doc1)
    expect(page).to have_content(patient1.name)
    expect(page).to have_content(patient2.name)

    within("#patient-#{patient1.id}") do
      click_button 'Remove'
    end
    
    expect(current_path).to eq(doctor_path(doc1))
    expect(page).to have_no_content(patient1.name)
    expect(page).to have_content(patient2.name)

    visit doctor_path(doc2)
    expect(page).to have_content(patient1.name)
  end
end