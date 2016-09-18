require 'rails_helper'

RSpec.describe MakeService do
  describe '.find_all_makes' do
    it 'finds and persists new makes' do
      # Setup
      http_response = [
        { 'Id' => 1, 'Nome' => 'Make 1' },
        { 'Id' => 2, 'Nome' => 'Make 2' }
      ]
      service_mock = double
      expect(service_mock).to receive(:post).with(
        MakeService::WEBMOTORS_MAKES_URL
      ).and_return(http_response)
      make_service = MakeService.new(service_mock)
      expected_makes = [
        { 'name' => 'Make 1', 'webmotors_id' => 1 },
        { 'name' => 'Make 2', 'webmotors_id' => 2 }
      ]

      # Exercise
      found_makes = make_service.find_all_makes

      # Verify
      expect(found_makes).to eq(Make.all)
      expect(
        Make.first.attributes.slice('name', 'webmotors_id')
      ).to eq(expected_makes.first)
      expect(
        Make.second.attributes.slice('name', 'webmotors_id')
      ).to eq(expected_makes.second)
    end
  end
end
