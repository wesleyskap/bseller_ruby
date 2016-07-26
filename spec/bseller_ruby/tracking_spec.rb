require 'spec_helper'

describe BsellerRuby::Tracking do
  describe 'restful' do
    it 'get massive list' do
      VCR.use_cassette('tracking_massive_list') do
        @response = BsellerRuby::Tracking.massive(unidadeNegocio: 'B2W', maxRegistros: 10)
        expect(@response).to an_instance_of(Hash)
      end
    end

    it 'confirm massive list' do
      VCR.use_cassette(('tracking_confirm_massive_list') do
        response = BsellerRuby::Tracking.massive_confirm(batch: @response['batchNumber'])
        expect(response["message"]).to eql("Lote confirmado com sucesso")
      end
    end
  end

  describe '.list' do
    it 'get tracking list' do
      VCR.use_cassette('tracking_list') do
        response = BsellerRuby::Tracking.list({'confirmaSN' => 'S'})
        expect(response).to eql({:tracking=>nil})
      end
    end
  end
end
