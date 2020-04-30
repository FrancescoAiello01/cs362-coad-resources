require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let(:resource_category) { ResourceCategory.new() }

  describe "attributes" do

    specify { expect(resource_category).to respond_to(:name) }
    specify { expect(resource_category).to respond_to(:created_at) }
    specify { expect(resource_category).to respond_to(:updated_at) }
    specify { expect(resource_category).to respond_to(:active) }

  end

  describe "relationships" do



  end

  describe "validations" do



  end

end
