require 'rails_helper'

RSpec.describe 'Rejecting an organization', type: :feature do

  let(:admin) { create(:user, :set_admin) }

  before :each do
    admin.confirm
    log_in_as(admin)
  end

  context "reject organization" do

    it "navigates to pending organizations and rejects" do
      organization = create(:organization, :set_submitted)
      visit organization_path(organization)
      click_on "Reject"
      expect(page).to have_text('has been rejected.')
    end

    it "a rejected organization can be approved" do
      organization = create(:organization, :set_rejected)
      visit organization_path(organization)
      click_on "Approve"
      expect(page).to have_text('has been approved.')
    end

  end

end
