require 'rails_helper'

RSpec.describe 'Capturing a ticket', type: :feature do

  let(:user) { create(:user, :set_organization) }

  before :each do
    user.confirm
    user.organization.approve
    log_in_as(user)
  end

  context "capture a ticket" do

    it "should capture a ticket as a organization user" do
      ticket = create(:ticket, :open)
      visit dashboard_path
      click_on ticket.name
      click_on "Capture"
      expect(page).to have_text("Dashboard")
    end

    it "can only release a ticket that is already captured" do
      ticket = create(:ticket, :open, :add_organization)
      visit dashboard_path
      click_on ticket.name
      save_and_open_page
      expect(page).to have_text(ticket.organization.name)
    end

  end

end
