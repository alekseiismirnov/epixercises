# frozen_string_literal: true

require_relative './spec_helper.rb'

describe('List doctors of the particular speciality', type: :feature) do
  before :all do
    @specialities = (0..12).map do |i|
      Speciality.new(speciality: "specialist ##{i}")
    end
    @specialities.each(&:save)

    @doctors = ('A'..'J').map do |c|
      Doctor.new(name: "Doctor #{c}")
    end
    @doctors.each(&:save)

    @doctors[0,6].each do |doctor|
      @specialities[2].add_related doctor
    end
  end

  it 'lists all and only doctors with same speciality' do
    id = @specialities[2].id

    visit "/specialities/#{id}"
    expect(page.status_code).to eq 200
    within '.doctors_list' do
      expect(all('.doctor').map(&:text)).to match_array @doctors[0,6].map(&:name)
    end
  end
end
