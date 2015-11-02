require 'spec_helper'

describe BsellerRuby::Tracking do
  describe '.list' do
    it 'get tracking list' do
      VCR.use_cassette('tracking_list') do
        response = BsellerRuby::Tracking.list({'confirmaSN' => 'S'})
        expect(response).to eql({:tracking=>nil})
      end
    end
  end
end
