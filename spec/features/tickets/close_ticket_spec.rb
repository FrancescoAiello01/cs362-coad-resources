require 'rails_helper'

RSpec.describe 'Closing a ticket', type: :feature do

  let(:user) { create(:user, :set_organization) }

  before :each do
    user.confirm
    user.organization.approve
    log_in_as(user)
  end

  context "closes a ticket" do

    it "organization can close a ticket if it is captured" do
      ticket = create(:ticket, :open, organization: user.organization)
      visit dashboard_path
      click_on ticket.name
      click_on "Close"
      click_on ticket.name
      expect(page).to have_text("Closed")
    end

    it "organization cannot close a ticket if it is not captured" do
      ticket = create(:ticket, :open)
      visit dashboard_path
      click_on ticket.name
      expect(page).to_not have_link("Close")
    end

    it "organization cannot close a closed ticket" do
      ticket = create(:ticket, :closed)
      visit dashboard_path
      click_on ticket.name
      expect(page).to_not have_link("Close")
    end

  end

end
