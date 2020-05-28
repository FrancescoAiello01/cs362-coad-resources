require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do

  let(:admin) { create(:user, :set_admin) }
  let(:region) { create(:region) }

  before :each do
    admin.confirm
    log_in_as(admin)
    region
  end

  context "delete a region" do

    it "should delete a region" do
      visit regions_path
      click_on region.name
      click_on "Delete"
      expect(page).to have_text("was deleted")
    end

  end

end
