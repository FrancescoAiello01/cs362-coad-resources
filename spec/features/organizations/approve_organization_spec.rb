require 'rails_helper'

RSpec.describe 'Approving an organization', type: :feature do

  let(:admin) { create(:user, :set_admin) }

  before :each do
    admin.confirm
    log_in_as(admin)
  end

  context "approve organization" do

    it "navigates to pending organizations and approves" do
      organization = create(:organization, :set_submitted)
      visit organization_path(organization)
      click_on "Approve"
      expect(page).to have_text('has been approved.')
    end

    it "cannot approve a non-pending organization" do
      organization = create(:organization)
      visit organization_path(organization)
      expect(page).not_to have_link('Approve')
    end

  end

end
