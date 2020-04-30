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



  end

end
