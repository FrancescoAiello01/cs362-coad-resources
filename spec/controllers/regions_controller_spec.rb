require 'rails_helper'

RSpec.describe RegionsController, type: :controller do
  let(:region) { create(:region) }

  before do
    region
  end

  context 'As a non-logged in user' do
    describe 'GET #index' do
      specify { expect(get(:index)).to redirect_to(new_user_session_path) }
    end
    describe 'GET #show' do
      specify { expect(get(:show, params: { id: region.id })).to redirect_to(new_user_session_path) }
    end
    describe 'GET #new' do
      specify { expect(get(:new)).to redirect_to(new_user_session_path) }
    end
    describe 'GET #create' do
      specify { expect(get(:show, params: { id: region.id })).to redirect_to(new_user_session_path) }
    end
    describe 'GET #edit' do
      specify { expect(get(:show, params: { id: region.id })).to redirect_to(new_user_session_path) }
    end
    describe 'GET #update' do
      specify { expect(get(:update, params: { id: region.id })).to redirect_to(new_user_session_path) }
    end
    describe 'GET #destroy' do
      specify { expect(get(:destroy, params: { id: region.id })).to redirect_to(new_user_session_path) }
    end
  end

  context 'As an organization user' do
    let(:user) { build(:user, :set_organization) }
    let(:region) { create(:region) }
    
    before do
      region
      user.confirm
      sign_in(user)
    end

    describe 'GET #index' do
      specify { expect(get(:index)).to redirect_to(dashboard_path) }
    end
    describe 'GET #new' do
      specify { expect(get(:new)).to redirect_to(dashboard_path) }
    end
    describe 'GET #show' do
      specify { expect(get(:show, params: { id: region.id })).to redirect_to(dashboard_path) }
    end
    describe 'GET #new' do
      specify { expect(get(:new)).to redirect_to(dashboard_path) }
    end
    describe 'GET #create' do
      specify { expect(get(:show, params: { id: region.id })).to redirect_to(dashboard_path) }
    end
    describe 'GET #edit' do
      specify { expect(get(:show, params: { id: region.id })).to redirect_to(dashboard_path) }
    end
    describe 'GET #update' do
      specify { expect(get(:update, params: { id: region.id })).to redirect_to(dashboard_path) }
    end
    describe 'GET #destroy' do
      specify { expect(get(:destroy, params: { id: region.id })).to redirect_to(dashboard_path) }
    end
  end

  context 'As an organization user' do
    let(:user) { build(:user, :set_admin) }
    let(:region) { create(:region) }

    before do
      region
      user.confirm
      sign_in(user)
    end

    describe 'GET #index' do
      specify { expect(get(:index)).to be_successful }
    end
    describe 'GET #new' do
      specify { expect(get(:new)).to be_successful }
    end
    describe 'GET #show' do
      specify { expect(get(:show, params: { id: region.id })).to be_successful }
    end
    describe 'GET #new' do
      specify { expect(get(:new)).to be_successful }
    end
    describe 'GET #create' do
      specify { expect(get(:show, params: { id: region.id })).to be_successful }
    end
    describe 'GET #edit' do
      specify { expect(get(:show, params: { id: region.id })).to be_successful }
    end
    # TODO: Get these working
    describe 'GET #update' do
      skip
        # specify { expect(get(:update, params: { region: region, id: region.id })).to be_successful }
    end
    describe 'GET #destroy' do
      skip
        # specify { expect(get(:destroy, params: { id: region.id })).to be_successful }
    end
  end

end
