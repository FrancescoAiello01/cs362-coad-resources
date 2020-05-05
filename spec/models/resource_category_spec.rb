require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let(:resource_category) { build(:resource_category) }

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

  describe "::unspecified" do
    it "creates a new Unspecified resource category when one does not exist" do
      expect(ResourceCategory.where(name: 'Unspecified')).to be_empty
      expect{ ResourceCategory.unspecified }.to change { ResourceCategory.count }.by(1)
    end
    it "does not create a new Unspecified resource category when one already exists" do
      create(:resource_category, :unspecified)
      expect{ ResourceCategory.unspecified }.to_not change { ResourceCategory.count }
    end
    it "returns a resource category with the name unspecified" do
      expect(ResourceCategory.unspecified.name).to eq('Unspecified')
    end

  end

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
