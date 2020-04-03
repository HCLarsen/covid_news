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
