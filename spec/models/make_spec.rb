require 'rails_helper'

RSpec.describe Make, type: :model do
  describe '.import' do
    it 'imports makes' do
      # Setup
      make_params = attributes_for_pair(:make)

      # Exercise
      Make.import(make_params)

      # Verify
      expect(Make.count).to eq(2)
      expect(Make.first.attributes.with_indifferent_access)
        .to include(make_params.first)
      expect(Make.second.attributes.with_indifferent_access)
        .to include(make_params.second)
    end
  end

  describe '.find_existing_names' do
    it 'finds existing make names' do
      # Setup
      makes = create_pair(:make)

      # Exercise
      existing_names = Make.find_existing_names(
        makes.map(&:name) + ['anothername']
      )

      # Verify
      expect(existing_names).to eq(makes.map(&:name))
    end
  end
end
