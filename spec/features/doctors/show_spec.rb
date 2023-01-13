require 'rails_helper'

RSpec.describe 'doctor show page' do
  it 'lists doctors attributes, hospital, and lists patients' do
    hospital = Hospital.create!(name: "Sloan Grey Memorial")
    doc = hospital.doctors.create!(name: "Jessica Schulte", specialty: "Nuero-oncology", university: "UCSF")
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
    expect(page).to have_content("University: #{doc.university}")
    expect(page).to have_content(patient1.name)
    expect(page).to have_content(patient2.name)
    expect(page).to have_content(patient3.name)
    expect(page).to have_content(patient4.name)
    expect(page).to have_no_content(patient5.name)
  end
#   User Story 1, Doctors Show Page
# ​
# As a visitor
# When I visit a doctor's show page
# I see all of that doctor's information including:
#  - name
#  - specialty
#  - university where they got their doctorate
# And I see the name of the hospital where this doctor works
# And I see the names of all of the patients this doctor has
end