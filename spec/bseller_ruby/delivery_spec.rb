require 'spec_helper'

describe BsellerRuby::Delivery do
  describe '.list' do
    it 'get delivery list' do
      VCR.use_cassette('delivery_list') do
        response = BsellerRuby::Delivery.list({'idUniNeg' => '1', 'confirmaSN' => 'S'})
        expect(response).to eql({:pedidos=>nil})
      end
      VCR.use_cassette('delivery_list_confirm') do
        response = BsellerRuby::Delivery.confirm!({'idUniNeg' => '1', 'confirmaSN' => 'S'})
        expect(response).to eql("Confirma consulta entrega efetuada com sucesso")
      end
    end
  end
end

