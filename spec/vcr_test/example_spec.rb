require 'rails_helper'

RSpec.describe "VCR Test", type: :request, vcr: true do
  it "returns a specific text" do
    response = Net::HTTP.get_response(URI('http://www.iana.org/domains/reserved'))
    expect(response.body).to include('Example domains')
  end
end
