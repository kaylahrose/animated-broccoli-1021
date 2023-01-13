class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find(params[:id])
  end

  def update
    doctor = Doctor.find(params[:id])
    patient = Patient.find(params[:doctor][:patient_id])
    doctor.patients.delete(patient)
    redirect_to doctor_path(doctor)
  end
end