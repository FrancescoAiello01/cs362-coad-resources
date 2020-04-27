require 'rails_helper'

RSpec.describe User, type: :model do

    let(:user) { User.new() }

    describe "attributes" do

        specify { expect(user).to respond_to(:email) }
        specify { expect(user).to respond_to(:encrypted_password) }
        specify { expect(user).to respond_to(:reset_password_token) }
        specify { expect(user).to respond_to(:reset_password_sent_at) }
        specify { expect(user).to respond_to(:remember_created_at) }
        specify { expect(user).to respond_to(:created_at) }
        specify { expect(user).to respond_to(:updated_at) }
        specify { expect(user).to respond_to(:confirmation_token) }
        specify { expect(user).to respond_to(:confirmed_at) }
        specify { expect(user).to respond_to(:confirmation_sent_at) }
        specify { expect(user).to respond_to(:unconfirmed_email) }
        specify { expect(user).to respond_to(:role) }
        specify { expect(user).to respond_to(:organization_id) }

    end

    describe "relationships" do

        it "belongs to organization" do
            expect(user).to belong_to(:organization)
        end

    end

    describe "validations" do

        specify { expect(user).to validate_presence_of(:email) }
        specify { expect(user).to validate_length_of(:email).is_at_least(1).is_at_most(255) }
        specify { expect(user).to validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create) }

        it "test valid emails" do
            should allow_values('test@test.com', 'other.test@yahoo.com').
            for(:email)
        end

        it "test invalid emails" do
            should_not allow_values('foo', 'buz').
            for(:email)
        end

        it "test uniqueness of email" do
            should validate_uniqueness_of(:email).case_insensitive
        end

        it "test uniqueness of email" do
            should validate_presence_of(:password).on(:create)
        end

    end

end
