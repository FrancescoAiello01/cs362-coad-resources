require 'rails_helper'


RSpec.describe Ticket, type: :model do

  let(:ticket) { build(:ticket) }
  let(:organization) { build(:organization) }

  describe "attributes" do

    specify { expect(ticket).to respond_to(:name) }
    specify { expect(ticket).to respond_to(:description) }
    specify { expect(ticket).to respond_to(:phone) }
    specify { expect(ticket).to respond_to(:organization_id) }
    specify { expect(ticket).to respond_to(:created_at) }
    specify { expect(ticket).to respond_to(:updated_at) }
    specify { expect(ticket).to respond_to(:closed) }
    specify { expect(ticket).to respond_to(:closed_at) }
    specify { expect(ticket).to respond_to(:resource_category_id) }
    specify { expect(ticket).to respond_to(:region_id) }

  end

  describe "relationships" do

    it "belongs to region" do
        expect(ticket).to belong_to(:region)
    end

    it "belongs to resource_category" do
        expect(ticket).to belong_to(:resource_category)
    end

    it "belongs to organization" do
        expect(ticket).to belong_to(:organization).optional
    end

  end

  describe "validations" do

    specify { expect(ticket).to validate_presence_of(:name) }
    specify { expect(ticket).to validate_presence_of(:phone) }
    specify { expect(ticket).to validate_presence_of(:region_id) }
    specify { expect(ticket).to validate_presence_of(:resource_category_id) }
    specify { expect(ticket).to validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    specify { expect(ticket).to validate_length_of(:description).is_at_most(1020).on(:create) }

    it "test valid phone numbers" do
        should allow_values('4512121212').
        for(:phone)
    end

    it "test invalid phone numbers" do
        should_not allow_values('foo').
        for(:phone)
    end

  end

  describe "#open" do

      it "is ticket open" do
          expect(ticket.open?).to eq(true)
      end

      it "is ticket closed" do
        ticket.closed = true
        expect(ticket.open?).to eq(false)
      end

  end

  describe "#captured" do

      it "ticket is not captured by default" do
          expect(ticket).to_not be_captured
      end

      it "ticket is captured if it has an organization" do
        ticket.organization = organization
        expect(ticket).to be_captured
      end

  end

  describe "#to_s" do

    it "has a string representation that is the ticket id" do
      ticket.id = 1
      expect(ticket.to_s).to eq("Ticket 1")
    end

  end

  #TODO: work on scopes
  describe "scopes" do

    it "includes tickets with closed false and organization_id nil" do
      # create(:ticket, :open)
      # # expect(ticket.open?).to eq(true)
      # open_tickets = Ticket.open
      # expect(open_tickets).to include(ticket)
    end

  end

end
