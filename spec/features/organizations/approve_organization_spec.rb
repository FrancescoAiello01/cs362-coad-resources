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
      visit organizations_path(organization)
      click_on organization.name
      click_on "Approve"
      expect(page).to have_text('has been approved.')
    end

  end

end
