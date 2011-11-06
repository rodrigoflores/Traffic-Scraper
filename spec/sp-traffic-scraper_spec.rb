require 'sp-traffic-scraper'
require 'fakeweb'

describe Traffic::Scraper do
  describe ".overall_traffic" do
    it "returns the overall traffic when success" do
      FakeWeb.register_uri(:get, "http://cetsp1.cetsp.com.br/monitransmapa/agora/", :body => File.read("spec/fixtures/traffic-info-page.html"))

      Traffic::Scraper.overall_traffic.should == 322
    end

    it "raises a CouldNotRetrievePageError when something goes wrong" do
      Traffic::Scraper.should_receive(:open).with("http://cetsp1.cetsp.com.br/monitransmapa/agora/").and_raise RuntimeError

      expect {
        Traffic::Scraper.overall_traffic
      }.to raise_error(CouldNotRetrievePageError)
    end
  end

  describe ".zone_traffic" do
    it 'returns a hash with the traffic on all the zones' do
      FakeWeb.register_uri(:get, "http://cetsp1.cetsp.com.br/monitransmapa/agora/", :body => File.read("spec/fixtures/traffic-info-page.html"))

      Traffic::Scraper.zone_traffic.should == {
        :north => 25,
        :south => 34,
        :east => 444,
        :west => 32,
        :downtown => 22
      }
    end
  end
end