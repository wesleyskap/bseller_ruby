require 'spec_helper'

describe BsellerRuby::Purchase do
  describe '#Purchase' do
    it 'purchase flow' do
      VCR.use_cassette('purchases_list') do
        response = BsellerRuby::Purchase.list({fornecedor: '52007010000152', departamento: '2'})
        expect(response).to an_instance_of(Array)
        @response_id = response.first['numeroRequisicao']
      end

      VCR.use_cassette('purchases_list_confirm') do
        response = BsellerRuby::Purchase.confirm!(@response_id.to_s)
        expect(response).to eql({"message"=>"Sucesso ao atualizar status das requisições"})
      end

      VCR.use_cassette('purchases_list_create') do
        response = BsellerRuby::Purchase.create!({'codigoExterno' => 1, 'numerosRequisicoes' => [@response_id]})
        expect(response).to eql({"message"=>"Sucesso ao inserir as requisições de compra"})
      end
    end
  end
end
