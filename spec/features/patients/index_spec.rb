require 'rails_helper' 

RSpec.describe 'patients index page' do
  it 'lists names of all adult patients in ascending alphabetical order' do
    # hospital = Hospital.create!(name: "University of California San Diego La Jolla")
    # doc1 = hospital.doctors.create!(name: "Jessica Schulte", specialty: "Nuero-oncology", university: "Northwestern University Feinberg School of Medicine")
    # doc2 = hospital.doctors.create!(name: "Anhnhi Tran", specialty: "Physical Therapy", university: "University of South Florida")
    patient1 = Patient.create!(name: 'John Doe', age: 70)
    patient2 = Patient.create!(name: 'Jane Doe', age: 40)
    patient3 = Patient.create!(name: 'Emma Doe', age: 50)
    patient4 = Patient.create!(name: 'Alex Doe', age: 60)
    patient5 = Patient.create!(name: 'Tim Cook', age: 60)
    patient6 = Patient.create!(name: 'Jim Cook', age: 10)
    # DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient1.id)
    # DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient2.id)
    # DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient3.id)
    # DoctorPatient.create!(doctor_id: doc1.id, patient_id: patient4.id) 
    # DoctorPatient.create!(doctor_id: doc2.id, patient_id: patient1.id) 

    visit patients_path

    expect(page).to have_content("Adult patients:")
    expect(patient4.name).to appear_before(patient3.name)
    expect(patient3.name).to appear_before(patient2.name)
    expect(patient2.name).to appear_before(patient1.name)
    expect(patient1.name).to appear_before(patient5.name)
    expect(page).to have_content(Patient.adults_sorted_alphabetically[0].name)
    expect(page).to have_content(Patient.adults_sorted_alphabetically[-1].name)
    expect(page).to have_no_content(patient6.name)
  end
#   User Story 3, Patient Index Page
# ​
# As a visitor
# When I visit the patient index page
# I see the names of all adult patients (age is greater than 18),
# And I see the names are in ascending alphabetical order (A - Z, you do not need to account for capitalization)

end