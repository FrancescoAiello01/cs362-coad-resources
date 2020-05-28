require 'rails_helper'

RSpec.describe 'Creating a Region', type: :feature do

  let(:admin) { create(:user, :set_admin) }

  before :each do
    admin.confirm
    log_in_as(admin)
  end

  context "create a region" do

    it "should create a new region" do
      visit regions_path
      click_on "Add Region"
      fill_in "region_name", with: "fake"
      click_on "Add Region"
      expect(page).to have_text("Region successfully created.")
    end

    it "cannot create a new region with no name" do
      visit regions_path
      click_on "Add Region"
      fill_in "region_name", with: ""
      click_on "Add Region"
      expect(page).to have_text("Name can't be blank")
    end

  end

end
