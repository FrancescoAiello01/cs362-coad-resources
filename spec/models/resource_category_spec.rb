require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let(:resource_category) { ResourceCategory.new() }

  describe "attributes" do

    specify { expect(resource_category).to respond_to(:name) }
    specify { expect(resource_category).to respond_to(:created_at) }
    specify { expect(resource_category).to respond_to(:updated_at) }
    specify { expect(resource_category).to respond_to(:active) }

  end

  describe "relationships" do

    it "has many resource_category" do
        expect(resource_category).to have_many(:tickets)
    end

    it "has and belongs to region" do
        expect(resource_category).to have_and_belong_to_many(:organizations)
    end

  end

  describe "validations" do

        specify { expect(resource_category).to validate_presence_of(:name) }
        specify { expect(resource_category).to validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
        it "test uniqueness of name" do
            should validate_uniqueness_of(:name).case_insensitive
        end

  end

  # TODO: get this methode under a proper test
  # describe "#unspecified" do
  #   it "make unspecified region" do
  #     unspecified = resource_category.unspecified()
  #   end
  # end

  describe "#activate" do
    it "changes status to active" do
      resource_category.active = false
      resource_category.activate
      expect(resource_category.active).to eq(true)
    end
  end

  describe "#deactivate" do
    it "changes status to deactivated" do
      resource_category.active = true
      resource_category.deactivate
      expect(resource_category.active).to eq(false)
    end
  end

  describe "#inactive?" do

    it "is resource_category inactive" do
      resource_category.active = true
      expect(resource_category.inactive?).to eq(false)
    end

    it "is resource_category active" do
      resource_category.active = false
      expect(resource_category.inactive?).to eq(true)
    end

  end

  describe "#to_s" do
    it "has a string representation that is the name" do
      resource_category.name = 'FAKE'
      expect(resource_category.to_s).to eq('FAKE')
    end
  end

end
