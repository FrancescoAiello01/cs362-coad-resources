require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  let(:base_title) { 'Disaster Resource Network' }

  it "returns base title if page title is not given" do
    title = full_title
    expect(title).to eq(base_title)
  end

  it "returns base title if page title is empty" do
    title = full_title('')
    expect(title).to eq(base_title)
  end

  it "returns '{page_title} | {base_title}' when passed page_title" do
    title = full_title('Fake Title')
    expected_title = "Fake Title | #{base_title}"
    expect(title).to eq(expected_title)
  end

end
