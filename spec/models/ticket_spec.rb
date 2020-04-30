require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let(:ticket) { Ticket.new() }

  describe "attributes" do

    specify { expect(ticket).to respond_to(:name) }
    specify { expect(ticket).to respond_to(:description) }
    specify { expect(ticket).to respond_to(:phone) }
    specify { expect(ticket).to respond_to(:organization_id) }
    specify { expect(ticket).to respond_to(:created_at) }
    specify { expect(ticket).to respond_to(:updated_at) }
    specify { expect(ticket).to respond_to(:closed) }
    specify { expect(ticket).to respond_to(:closed_at) }
    specify { expect(ticket).to respond_to(:resource_category_id) }
    specify { expect(ticket).to respond_to(:region_id) }

  end

  describe "relationships" do



  end

  describe "validations" do



  end

end
