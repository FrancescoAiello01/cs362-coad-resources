require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TIcketsHelper. For example:
#
# describe TIcketsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TicketsHelper, type: :helper do

  let(:expected_number) { "+15416966969" }

  it "formats a phone number with area code in parenthesis" do
    formatted_number = format_phone_number("(541) 696-6969")
    expect(formatted_number).to eq(expected_number)
  end

  it "formats a phone number with dashes to separate parts of number" do
    formatted_number = format_phone_number("(541-696-6969")
    expect(formatted_number).to eq(expected_number)
  end

  it "adds a +1 to any given number" do
    formatted_number = format_phone_number("6966969")
    expected_number = "+16966969"
    expect(formatted_number).to eq(expected_number)
  end

end
