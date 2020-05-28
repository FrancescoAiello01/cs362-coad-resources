require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do

  let(:admin) { create(:user, :set_admin) }
  let(:resource_category) { create(:resource_category) }

  before :each do
    admin.confirm
    log_in_as(admin)
    resource_category
  end

  context "delete a resource category" do

    it "should delete a resource category" do
      visit resource_categories_path
      click_on resource_category.name
      click_on "Delete"
      expect("was deleted.")
    end

  end

end
