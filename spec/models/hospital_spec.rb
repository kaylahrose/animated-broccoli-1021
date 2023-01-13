require 'rails_helper'

RSpec.describe Hospital do
  it {should have_many :doctors}
  describe 'instance methods' do
    describe '#doc_patients_count' do
      it 'returns and orders by the patient count for every doctor' do
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

        expect(hospital.doc_patients_count.count).to eq(2)
        expect(hospital.doc_patients_count[0].patient_count).to eq(4)
        expect(hospital.doc_patients_count[1].patient_count).to eq(1)
      end
    end
  end
end
