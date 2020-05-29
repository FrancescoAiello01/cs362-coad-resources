require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  class FakeMailer
    def new_organization_application
      false
    end
  end

  context 'organization user' do
    describe 'POST #create' do
      let(:user) { create(:user, :role_organization) }
      let(:admin) { create(:user, :set_admin) }
      let(:organization) { create(:organization) }

      before do
        user.confirm
        admin.confirm
        sign_in(user)
      end

      it 'creates a new organization as a user' do
        expect(
            post(:create, params: { organization: {
                name: 'FAKE',
                email: 'fake@fake.com',
                phone: '15417777777',
                primary_name: 'fake primary name',
                secondary_name: 'fake secondary name',
                secondary_phone: '18888888888'
            } })
        ).to redirect_to(organization_application_submitted_path)
      end

    end
  end

  context 'admin user' do
    describe 'GET #index' do
      let(:admin) { create(:user, :set_admin) }
      let(:user) { create(:user, :set_organization) }

      before do
        user.confirm
        admin.confirm
        sign_in(admin)
      end

      it 'succeeds' do
        expect(get(:index)).to be_successful
      end
    end

    describe 'POST #update' do
      let(:admin) { create(:user, :set_admin) }
      let(:user) { create(:user, :set_organization) }

      before do
        user.confirm
        admin.confirm
        sign_in(admin)
      end

      it 'succeeds' do
        skip
        expect(get(:update, params: { organization: user.organization })).to redirect_to(organization_path)
      end
    end
  end

end
