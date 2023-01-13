require 'rails_helper' 

RSpec.describe 'patients index page' do
  it 'lists names of all adult patients in ascending alphabetical order' do
    patient1 = Patient.create!(name: 'John Doe', age: 70)
    patient2 = Patient.create!(name: 'Jane Doe', age: 40)
    patient3 = Patient.create!(name: 'Emma Doe', age: 50)
    patient4 = Patient.create!(name: 'Alex Doe', age: 60)
    patient5 = Patient.create!(name: 'Tim Cook', age: 60)
    patient6 = Patient.create!(name: 'Jim Cook', age: 10)

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
end