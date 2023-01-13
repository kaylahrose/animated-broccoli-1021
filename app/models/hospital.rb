class Hospital < ApplicationRecord
  has_many :doctors

  def doc_patients_count
    doctors
      .joins(:doctor_patients)
      .select("doctors.*, COUNT(doctor_patients.patient_id) as patient_count")
      .group(:id)
      .order(patient_count: :desc)
  end
end
