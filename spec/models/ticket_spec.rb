require 'rails_helper'


RSpec.describe Ticket, type: :model do

  let(:ticket) { build(:ticket) }
  let(:organization) { build(:organization) }
  let(:region) { build(:region) }
  let(:resource_category) { build(:resource_category) }

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

  describe "::open" do

    it "retrieves only non-closed tickets without an organization" do
      ticket = create(:ticket, :open)
      open_tickets = Ticket.open
      expect(open_tickets).to include(ticket)
    end

    it "does not retrieve closed tickets" do
      ticket = create(:ticket, :closed)
      open_tickets = Ticket.open
      expect(open_tickets).not_to include(ticket)
    end

  end

  describe "::closed" do

    it "retrieves only closed tickets with an organization" do
      ticket = create(:ticket, :closed)
      closed_tickets = Ticket.closed
      expect(closed_tickets).to include(ticket)
    end

    it "does not retrieve open tickets" do
      ticket = create(:ticket, :open)
      closed_tickets = Ticket.closed
      expect(closed_tickets).not_to include(ticket)
    end

  end

  describe "::all_organization" do

    it "retrieves only open tickets with an organization" do
      ticket = create(:ticket, :open, :add_organization)
      organization_tickets = Ticket.all_organization
      expect(organization_tickets).to include(ticket)
    end

    it "retrieves only open tickets without an organization" do
      ticket = create(:ticket, :open)
      organization_tickets = Ticket.all_organization
      expect(organization_tickets).not_to include(ticket)
    end

    it "does not retrieve closed tickets with no organization" do
      ticket = create(:ticket, :closed)
      organization_tickets = Ticket.all_organization
      expect(organization_tickets).not_to include(ticket)
    end

    it "does not retrieve closed tickets with organization" do
      ticket = create(:ticket, :closed, :add_organization)
      organization_tickets = Ticket.all_organization
      expect(organization_tickets).not_to include(ticket)
    end

  end

  describe "::organization" do

    it "retrieves open tickets for an organization" do
      ticket = create(:ticket, :open, :add_organization)
      org_id = ticket.organization.id
      organization_tickets = Ticket.organization(org_id)
      expect(organization_tickets).to include(ticket)
    end

    it "does not retrieve closed tickets for an organization" do
      ticket = create(:ticket, :closed, :add_organization)
      org_id = ticket.organization.id
      organization_tickets = Ticket.organization(org_id)
      expect(organization_tickets).not_to include(ticket)
    end

    it "does not retrieve open tickets for a different organization" do
      ticket = create(:ticket, :open, :add_organization)
      organization = create(:organization)
      org_id = organization.id
      organization_tickets = Ticket.organization(org_id)
      expect(organization_tickets).not_to include(ticket)
    end

    it "does not retrieve closed tickets for a different organization" do
      ticket = create(:ticket, :closed, :add_organization)
      organization = create(:organization)
      org_id = organization.id
      organization_tickets = Ticket.organization(org_id)
      expect(organization_tickets).not_to include(ticket)
    end

  end

  describe "::closed_organization" do

    it "retrieves closed tickets for an organization" do
      ticket = create(:ticket, :closed, :add_organization)
      org_id = ticket.organization.id
      organization_tickets = Ticket.closed_organization(org_id)
      expect(organization_tickets).to include(ticket)
    end

    it "does not retrieve open tickets for an organization" do
      ticket = create(:ticket, :open, :add_organization)
      org_id = ticket.organization.id
      organization_tickets = Ticket.closed_organization(org_id)
      expect(organization_tickets).not_to include(ticket)
    end

    it "does not retrieve open tickets for a different organization" do
      ticket = create(:ticket, :open, :add_organization)
      organization = create(:organization)
      org_id = organization.id
      organization_tickets = Ticket.closed_organization(org_id)
      expect(organization_tickets).not_to include(ticket)
    end

    it "does not retrieve closed tickets for a different organization" do
      ticket = create(:ticket, :closed, :add_organization)
      organization = create(:organization)
      org_id = organization.id
      organization_tickets = Ticket.closed_organization(org_id)
      expect(organization_tickets).not_to include(ticket)
    end

  end

  describe "::region" do

    it "retrieves tickets with a given region" do
      ticket = create(:ticket)
      region_id = ticket.region.id
      region_tickets = Ticket.region(region_id)
      expect(region_tickets).to include(ticket)
    end

    it "does not retrieve tickets with a different region" do
      ticket = create(:ticket)
      region = create(:region)
      region_id = region.id
      region_tickets = Ticket.region(region_id)
      expect(region_tickets).not_to include(ticket)
    end

  end

  describe "::resource_category" do

    it "retrieves tickets with a given resource_category" do
      ticket = create(:ticket)
      resource_category_id = ticket.resource_category.id
      rc_tickets = Ticket.resource_category(resource_category_id)
      expect(rc_tickets).to include(ticket)
    end

    it "does not retrieve tickets with a different region" do
      ticket = create(:ticket)
      resource_category = create(:resource_category)
      resource_category_id = resource_category.id
      rc_tickets = Ticket.resource_category(resource_category_id)
      expect(rc_tickets).not_to include(ticket)
    end

  end


end
