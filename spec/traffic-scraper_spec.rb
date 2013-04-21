require 'traffic-scraper'
require 'fakeweb'

describe Traffic::Scraper do
  describe ".overall_traffic" do
    it "returns the overall traffic when success" do
      FakeWeb.register_uri(:get, "http://www.cetsp.com.br/", :body => File.read("spec/fixtures/traffic-info-page.html"))

      Traffic::Scraper.overall_traffic.should == 2
    end

    it "raises a CouldNotRetrievePageError when something goes wrong" do
      Traffic::Scraper.should_receive(:open).with("http://www.cetsp.com.br/").and_raise RuntimeError

      expect {
        Traffic::Scraper.overall_traffic
      }.to raise_error(CouldNotRetrievePageError)
    end
  end

  describe ".zone_traffic" do
    it 'returns a hash with the traffic on all the zones' do
      FakeWeb.register_uri(:get, "http://www.cetsp.com.br/", :body => File.read("spec/fixtures/traffic-info-page.html"))

      Traffic::Scraper.zone_traffic.should == {
        :north => 0,
        :south => 2,
        :east => 0,
        :west => 0,
        :downtown => 0
      }
    end

    it "raises a CouldNotRetrievePageError when something goes wrong" do
      Traffic::Scraper.should_receive(:open).with("http://www.cetsp.com.br/").and_raise RuntimeError

      expect {
        Traffic::Scraper.zone_traffic
      }.to raise_error(CouldNotRetrievePageError)
    end
  end
end