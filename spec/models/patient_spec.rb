require 'rails_helper'

RSpec.describe Patient do
  describe 'relationships' do
    it {should have_many :doctor_patients}
    it {should have_many(:doctors).through(:doctor_patients)}
  end

  describe 'class methods' do
    describe '#adults_sorted_alphabetically' do
      it 'returns all patients ages 18+ and sorts alphabetically' do
        patient1 = Patient.create!(name: 'John Doe', age: 70)
        patient2 = Patient.create!(name: 'Jane Doe', age: 40)
        patient3 = Patient.create!(name: 'Emma Doe', age: 10)
        patient4 = Patient.create!(name: 'Alex Doe', age: 10)
        patient5 = Patient.create!(name: 'Tim Cook', age: 60)

        expect(Patient.adults_sorted_alphabetically).to eq([patient2, patient1, patient5])
        expect(Patient.adults_sorted_alphabetically[0]).to eq(patient2)
        expect(Patient.adults_sorted_alphabetically[-1]).to eq(patient5)
        expect(Patient.adults_sorted_alphabetically.count).to eq(3)
        
        patient6 = Patient.create!(name: 'Andre Doe', age: 30)
        expect(Patient.adults_sorted_alphabetically).to eq([patient6, patient2, patient1, patient5])
        expect(Patient.adults_sorted_alphabetically[0]).to eq(patient6)
        expect(Patient.adults_sorted_alphabetically.count).to eq(4)
      end
    end
  end
end