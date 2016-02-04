require 'spec_helper'

describe BsellerRuby::Stock do
  describe 'Items' do
    before(:context) { @list = [] }
    context 'when is valid' do
      it 'get stock list' do
        @list << 1
        expect(@list).to eq([1])

        VCR.use_cassette('stock_total_list') do
          response = BsellerRuby::Stock.get_total({'confirmaSN' => 'S', 'tpInterface' => 'B2W'})
          expect(response.class).to be(Hash)
          expect(response).to                         have_key(:estoque)
          expect(response[:estoque]).to               have_key(:item)
          expect(response[:estoque][:item].first).to  have_key(:id_cia)
          expect(response[:estoque][:item].first).to  have_key(:estabelecimento)
          expect(response[:estoque][:item].first).to  have_key(:qtde)
          expect(response[:estoque][:item].first).to  have_key(:dt_disp)
          expect(response[:estoque][:item].first).to  have_key(:pz_disp)
          expect(response[:estoque][:item].first).to  have_key(:@id_item)
        end
      end
    end

    context 'when is not valid' do
      it 'get stock list' do
        @list << 2
        expect(@list).to eq([1, 2])
        VCR.use_cassette('not_confirmed_stock_total_list') do
          response = BsellerRuby::Stock.get_total({'confirmaSN' => 'S', 'tpInterface' => 'B2W'})
          expect(response).to an_instance_of(Nori::StringWithAttributes)
          expect(response).to start_with("CallableStatementCallback")
          expect(response).to match(/Existem processo\(s\) de interface em aberto/)
        end
      end
    end

    context 'when is valid' do
      it 'confirm total list' do
        @list << 3
        expect(@list).to eq([1, 2, 3])
        VCR.use_cassette('confirm_to_total_list') do
          response = BsellerRuby::Stock.confirm_to_total_list!({'confirmaSN' => 'S', 'tpInterface' => 'B2W'})
          expect(response).to an_instance_of(Nori::StringWithAttributes)
          expect(response).to eql("Confirma consulta estoque total efetuada com sucesso")
        end
      end
    end

    context 'when is valid' do
      it 'get stock list' do
        @list << 4
        expect(@list).to eq([1, 2, 3, 4])
        VCR.use_cassette('stock_partial_list') do
          response = BsellerRuby::Stock.get_partial({'confirmaSN' => 'S', 'tpInterface' => 'B2W'})
          expect(response).to an_instance_of(Hash)
        end
      end
    end

    context 'when is valid' do
      it 'confirm partial list' do
        @list << 5
        expect(@list).to eq([1, 2, 3, 4, 5])
        VCR.use_cassette('confirm_to_partial_list') do
          response = BsellerRuby::Stock.confirm_to_partial_list!({'confirmaSN' => 'S', 'pTpInterface' => 'B2W'})
          expect(response).to an_instance_of(Nori::StringWithAttributes)
          expect(response).to eql("Confirma consulta estoque parcial efetuada com sucesso")
        end
      end
    end

    describe ".find" do
      it 'find an stock' do
        VCR.use_cassette('stock_find', match_requests_on: [:headers]) do
          item = BsellerRuby::Stock.find('262261', 'SITE')
          expect(item).to eql({"codigoDepartamento"=>1, "estoqueEstabelecimento"=>[]})
        end
      end

      it 'dont find an stock' do
        VCR.use_cassette('stock_dont_find', match_requests_on: [:headers]) do
          item = BsellerRuby::Stock.find('1', 'SITE')
          expect(item).to eql({"message"=>"Código Terceiro inexistente", "detalheErro"=>nil})
        end
      end
    end
  end
end
