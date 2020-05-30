require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
  let(:resource_category) { create(:resource_category) }

  before do
    resource_category
  end

  context 'As a non-logged in user' do
    describe 'GET #index' do
      specify { expect(get(:index)).to redirect_to(new_user_session_path) }
    end
    describe 'GET #new' do
      specify { expect(get(:new)).to redirect_to(new_user_session_path) }
    end
    describe 'GET #create' do
      specify { expect(get(:create, params: { id: resource_category.id })).to redirect_to(new_user_session_path) }
    end
    describe 'GET #update' do
      specify { expect(get(:update, params: { id: resource_category.id })).to redirect_to(new_user_session_path) }
    end
    describe 'GET #activate' do
      specify { expect(get(:activate, params: { id: resource_category.id })).to redirect_to(new_user_session_path) }
    end
    describe 'GET #deactivate' do
      specify { expect(get(:deactivate, params: { id: resource_category.id })).to redirect_to(new_user_session_path) }
    end
    describe 'GET #destroy' do
      specify { expect(get(:destroy, params: { id: resource_category.id })).to redirect_to(new_user_session_path) }
    end
  end

  context 'As an organization user' do
    let(:user) { build(:user, :role_organization) }
    let(:resource_category) { create(:resource_category) }

    before do
      resource_category
      user.confirm
      sign_in(user)
    end

    describe 'GET #index' do
      specify { expect(get(:index)).to redirect_to(dashboard_path) }
    end
    describe 'GET #new' do
      specify { expect(get(:new)).to redirect_to(dashboard_path) }
    end
    describe 'GET #create' do
      specify { expect(get(:create, params: { resource_category: {
          name: 'fake'
      } })).to redirect_to(dashboard_path) }
    end
    describe 'GET #update' do
      specify { expect(get(:update, params: { id: resource_category.id })).to redirect_to(dashboard_path) }
    end
    describe 'GET #activate' do
      specify { expect(get(:activate, params: { id: resource_category.id })).to redirect_to(dashboard_path) }
    end
    describe 'GET #deactivate' do
      specify { expect(get(:deactivate, params: { id: resource_category.id })).to redirect_to(dashboard_path) }
    end
    describe 'GET #destroy' do
      specify { expect(get(:destroy, params: { id: resource_category.id })).to redirect_to(dashboard_path) }
    end
  end

  context 'As an admin user' do
    let(:user) { build(:user, :set_admin) }
    let(:resource_category) { create(:resource_category) }
    let(:active_resource_category) { create(:resource_category, :active) }
    let(:inactive_resource_category) { create(:resource_category, :inactive) }

    before do
      resource_category
      active_resource_category
      inactive_resource_category
      user.confirm
      sign_in(user)
    end

    describe 'GET #index' do
      specify { expect(get(:index)).to be_successful }
    end
    describe 'GET #new' do
      specify { expect(get(:new)).to be_successful }
    end
    describe 'GET #new' do
      specify { expect(get(:new)).to be_successful }
    end
    describe 'GET #create' do
      specify { expect(get(:create, params: { resource_category: { name: 'KAHJLF' } })).to redirect_to(resource_categories_path) }
      specify { expect(get(:create, params: { resource_category: { name: '' } })).to be_successful }
    end
    describe 'GET #update' do
      specify { expect(get(:update, params: { resource_category: {
          name: 'FAKE',
      }, id: resource_category.id })).to redirect_to(resource_category_path(resource_category))}
      specify { expect(get(:update, params: { resource_category: {
          name: '',
      }, id: resource_category.id })).to be_successful}
    end
    describe 'GET #activate' do
      specify { expect(get(:activate, params: { id: resource_category.id })).to redirect_to(resource_category_path(resource_category)) }
      specify { expect(get(:activate, params: { id: active_resource_category.id })).to redirect_to(resource_category_path(active_resource_category)) }
    end
    describe 'GET #deactivate' do
      specify { expect(get(:deactivate, params: { id: resource_category.id })).to redirect_to(resource_category_path(resource_category)) }
      specify { expect(get(:deactivate, params: { id: inactive_resource_category.id })).to redirect_to(resource_category_path(inactive_resource_category)) }
    end
    describe 'GET #destroy' do
      specify { expect(get(:destroy, params: { id: resource_category.id })).to redirect_to(resource_categories_path) }
    end
  end

end
