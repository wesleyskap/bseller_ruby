require 'spec_helper'

describe BsellerRuby::Price do
  describe 'Items' do
    context 'when is valid' do
      it 'get price list and confirm' do
        VCR.use_cassette('price_list') do
          response = BsellerRuby::Price.list({'tipoInterface' => 'B2W'})
          expect(response.class).to be(Array)
        end
      end
    end
  end
end

