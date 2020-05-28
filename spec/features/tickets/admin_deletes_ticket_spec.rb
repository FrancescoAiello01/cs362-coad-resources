require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do

  let(:admin) { create(:user, :set_admin) }
  let(:ticket) { create(:ticket) }

  before :each do
    admin.confirm
    log_in_as(admin)
    ticket
  end

  context "delete a ticket" do

    it "should delete a ticket" do
      visit dashboard_path
      click_on ticket.name
      click_on "Delete"
      expect(page).to have_text("was deleted.")
    end

  end

end
