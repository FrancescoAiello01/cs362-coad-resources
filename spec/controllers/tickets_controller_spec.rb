require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:ticket) { create(:ticket) }

  before do
    ticket
  end

  context 'As a non-logged in user' do
    describe 'GET #new' do
      specify { expect(get(:new)).to be_successful }
    end
    describe 'GET #create' do
      specify { expect(get(:create, params: { ticket: {
          name: 'fake',
          phone: '15416666666',
          description: 'fake description',
          region_id: ticket.region.id,
          resource_category_id: ticket.resource_category.id
      }
      })).to redirect_to(ticket_submitted_path) }
    end
    describe 'GET #destroy' do
      specify { expect(get(:destroy, params: { id: ticket.id })).to redirect_to(dashboard_path) }
    end
  end

  context 'As an organization user' do
    let(:user) { build(:user, :role_organization) }
    let(:ticket) { create(:ticket) }

    before do
      ticket
      user.confirm
      sign_in(user)
    end

    describe 'GET #new' do
      specify { expect(get(:new)).to be_successful }
    end
    describe 'GET #create' do
      specify { expect(get(:create, params: { ticket: {
          name: 'fake'
      } })).to be_successful }
    end
    describe 'GET #destroy' do
      specify { expect(get(:destroy, params: { id: ticket.id })).to redirect_to(dashboard_path) }
    end
  end

  context 'As an admin user' do
    let(:user) { build(:user, :set_admin) }
    let(:ticket) { create(:ticket) }

    before do
      ticket
      user.confirm
      sign_in(user)
    end

    describe 'GET #new' do
      specify { expect(get(:new)).to be_successful }
    end
    describe 'GET #new' do
      specify { expect(get(:new)).to be_successful }
    end
    describe 'GET #create' do
      specify { expect(get(:create, params: { ticket: { name: 'KAHJLF' } })).to be_successful }
      specify { expect(get(:create, params: { ticket: { name: '' } })).to be_successful }
    end
    describe 'GET #destroy' do
      specify { expect(get(:destroy, params: { id: ticket.id })).to redirect_to(dashboard_path + '#tickets') }
    end
  end
end
