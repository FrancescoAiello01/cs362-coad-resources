require 'rails_helper'

RSpec.describe Organization, type: :model do

  let(:organization) { Organization.new }

  describe "attributes" do

    it "should have agreement_one" do
      expect(organization).to respond_to(:agreement_one)
    end

    it "should have agreement_two" do
      expect(organization).to respond_to(:agreement_two)
    end

    it "should have agreement_three" do
      expect(organization).to respond_to(:agreement_three)
    end

    it "should have agreement_four" do
      expect(organization).to respond_to(:agreement_four)
    end

    it "should have agreement_five" do
      expect(organization).to respond_to(:agreement_five)
    end

    it "should have agreement_six" do
      expect(organization).to respond_to(:agreement_six)
    end

    it "should have agreement_seven" do
      expect(organization).to respond_to(:agreement_seven)
    end

    it "should have agreement_eight" do
      expect(organization).to respond_to(:agreement_eight)
    end

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

    it "validates email" do
      expect(organization).to validate_presence_of(:email)
    end

    it "validates length of email" do
      expect(organization).to validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create)
    end


  end

end
