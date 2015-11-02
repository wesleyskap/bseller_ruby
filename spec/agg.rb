require 'rspec/expectations'
include RSpec::Matchers

Response = Struct.new(:status, :headers, :body)
response = Response.new(404, { "Content-Type" => "text/plain" }, "Not Found")

begin
  aggregate_failures "testing response" do
    expect(response.status).to eq(200)
    expect(response.headers["Content-Type"]).to eq("application/json")
    expect(response.body).to eq('{"message":"Success"}')
  end
rescue RSpec::Expectations::MultipleExpectationsNotMetError => e
  puts e.message
  exit(1)
end

