require 'rails_helper'

RSpec.describe 'Releasing a ticket by an', type: :feature do

  let(:user) { create(:user, :set_organization) }

  before :each do
    user.confirm
    user.organization.approve
    log_in_as(user)
  end

  context "release a ticket" do

    it "organization can release a ticket if it is captured" do
      ticket = create(:ticket, :open, organization: user.organization)
      visit dashboard_path
      click_on ticket.name
      click_on "Release"
      click_on ticket.name
      expect(page).to have_link("Capture")
    end

    it "organization cannot release a ticket if it is captured by another organization" do
      ticket = create(:ticket, :open, :add_organization)
      visit dashboard_path
      click_on ticket.name
      expect(page).to_not have_link("Release")
    end

    it "organization cannot release a ticket that is not captured" do
      ticket = create(:ticket, :open)
      visit dashboard_path
      click_on ticket.name
      expect(page).to_not have_link("Release")
    end

  end

end
