require 'rails_helper'

RSpec.describe Organization, type: :model do

  let(:organization) { Organization.new(name: 'FAKE') }

  describe "attributes" do

    specify { expect(organization).to respond_to(:agreement_one) }
    specify { expect(organization).to respond_to(:agreement_two) }
    specify { expect(organization).to respond_to(:agreement_three) }
    specify { expect(organization).to respond_to(:agreement_four) }
    specify { expect(organization).to respond_to(:agreement_five) }
    specify { expect(organization).to respond_to(:agreement_six) }
    specify { expect(organization).to respond_to(:agreement_seven) }
    specify { expect(organization).to respond_to(:agreement_eight) }
    specify { expect(organization).to respond_to(:name) }
    specify { expect(organization).to respond_to(:status) }
    specify { expect(organization).to respond_to(:phone) }
    specify { expect(organization).to respond_to(:email) }
    specify { expect(organization).to respond_to(:description) }
    specify { expect(organization).to respond_to(:rejection_reason) }
    specify { expect(organization).to respond_to(:liability_insurance) }
    specify { expect(organization).to respond_to(:primary_name) }
    specify { expect(organization).to respond_to(:secondary_name) }
    specify { expect(organization).to respond_to(:secondary_phone) }
    specify { expect(organization).to respond_to(:title) }
    specify { expect(organization).to respond_to(:transportation) }

  end

  describe "relationships" do

    it "has many users" do
      expect(organization).to have_many(:users)
    end

    it "has many tickets" do
      expect(organization).to have_many(:tickets)
    end

    it "has and belongs to many resource categories" do
      expect(organization).to have_and_belong_to_many(:resource_categories)
    end

  end

  describe "validations" do

    specify { expect(organization).to validate_presence_of(:email) }
    specify { expect(organization).to validate_presence_of(:name) }
    specify { expect(organization).to validate_presence_of(:phone) }
    specify { expect(organization).to validate_presence_of(:status) }
    specify { expect(organization).to validate_presence_of(:primary_name) }
    specify { expect(organization).to validate_presence_of(:secondary_name) }
    specify { expect(organization).to validate_presence_of(:secondary_phone) }

    it "validates length of email" do
      expect(organization).to validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create)
    end

    it "validates format of email" do
      expect(organization).to allow_value('valid@example.com').for(:email)
      expect(organization).to_not allow_values('@example.com', 'example.com', 'INVALID', 'fake@example').for(:email)
    end

    it "validates uniqueness of email" do
      expect(organization).to validate_uniqueness_of(:email).case_insensitive
    end

    it "validates length of name" do
      expect(organization).to validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
    end

    it "validates uniqueness of name" do
      expect(organization).to validate_uniqueness_of(:name).case_insensitive
    end

    it "validates length of description" do
      expect(organization).to validate_length_of(:description).is_at_most(1020).on(:create)
    end

  end

  describe "#approve" do
    it "changes status to approved" do
      organization.status = nil
      organization.approve
      expect(organization.status).to eq("approved")
    end
  end

  describe "#reject" do
    it "changes status to rejected" do
      organization.status = nil
      organization.reject
      expect(organization.status).to eq("rejected")
    end
  end

  describe "#set_default_status" do
    it "changes status to default status" do
      organization.status = nil
      organization.set_default_status
      expect(organization.status).to eq("submitted")
    end
  end

  describe "#to_s" do
    it "has a string representation that is the name" do
      expect(organization.to_s).to eq('FAKE')
    end
  end

end
