require "webmock"

def loadfile(filename : String)
  file = File.new("test/files/#{filename}.json")
  content = file.gets_to_end
  file.close

  return content
end

WebMock.stub(:get, "https://covidapi.info/api/v1/country/CAN").to_return(status: 200, body: loadfile("canada-covid"))

WebMock.stub(:get, "https://restcountries.eu/rest/v2/alpha/can").to_return(status: 200, body: loadfile("canada-info"))

WebMock.stub(:get, "https://covidapi.info/api/v1/global/count").to_return(status: 200, body: loadfile("global"))

WebMock.stub(:get, "https://data.ontario.ca/api/3/action/datastore_search?limit=8&sort=_id%20desc&resource_id=ed270bb8-340b-41f9-a7c6-e8ef587e6d11").to_return(status: 200, body: File.read("test/files/response.json"))
