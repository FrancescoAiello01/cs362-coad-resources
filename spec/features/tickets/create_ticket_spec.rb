require 'rails_helper'

RSpec.describe 'Creating a Ticket', type: :feature do

  let(:resource_category) { create(:resource_category) }
  let(:region) { create(:region) }

  before :each do
    region
    resource_category
  end

  context "create a ticket" do

    it "should create a ticket when not signed in" do
      visit new_ticket_path
      fill_in "ticket_name", with: "fake"
      fill_in 'ticket_phone', with: '6501984387'
      select(region.name, from: "ticket_region_id").select_option
      select(resource_category.name, from: "ticket_resource_category_id").select_option
      fill_in "ticket_description", with: "fake"
      click_on "Send this help request"
      expect(page).to have_text("Ticket Submitted")
    end

    it "cannot create an empty ticket" do
      visit new_ticket_path
      click_on "Send this help request"
      expect(page).to have_text("errors prohibited this ticket from being saved:")
    end

  end

end
