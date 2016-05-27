require 'spec_helper'

describe BsellerRuby::Item do
  describe 'massive' do
    it "get massive list" do
      response = BsellerRuby::Item.massive(tipoInterface: 'WA')
      expect(response).to an_instance_of(Hash)
    end

    it "put to confirm massive list" do
      response = BsellerRuby::Item.massive_confirm(batch: '1')
      expect(response).to an_instance_of(Hash)
      expect(response["message"]).to eql("Lote confirmado com sucesso")
    end

    it "put to confirm massive list(2)" do
      response = BsellerRuby::Item.massive_confirm(batch: 1)
      expect(response['message']).to eql("Lote confirmado com sucesso")
    end
  end

  describe '.get_list' do
    context 'when is valid' do
      it 'get items list' do
        VCR.use_cassette('item_list_2') do
          response = BsellerRuby::Item.get_list({'confirmaSN' => 'S', 'tpInterface' => 'WAL', 'maxReg' => '10'})
          expect(response.class).to be(Hash)
          expect(response[:cadastro][:item]).to an_instance_of(Array)
        end

        VCR.use_cassette('item_list') do
          response = BsellerRuby::Item.get_list({'confirmaSN' => 'S', 'tpInterface' => 'WAL', 'maxReg' => '1'})
          expect(response.class).to be(Hash)
          expect(response).to have_key(:cadastro)
          expect(response[:cadastro]).to have_key(:item)
          expect(response[:cadastro][:item]).to an_instance_of(Hash)
          expect(response[:cadastro][:item]).to have_key(:ean)
          expect(response[:cadastro][:item][:ean]).to have_key(:cod_ean)
          expect(response[:cadastro][:item]).to have_key(:id_item_pai)
          expect(response[:cadastro][:item]).to have_key(:in_geral)
          expect(response[:cadastro][:item]).to have_key(:cod_terc)
          expect(response[:cadastro][:item]).to have_key(:tp_item)
          expect(response[:cadastro][:item]).to have_key(:tp_nao_produto)
          expect(response[:cadastro][:item]).to have_key(:in_fisico_virtual_np)
          expect(response[:cadastro][:item]).to have_key(:operacao)
          expect(response[:cadastro][:item]).to have_key(:nome)
          expect(response[:cadastro][:item]).to have_key(:cod_fornec)
          expect(response[:cadastro][:item]).to have_key(:departamento)
          expect(response[:cadastro][:item]).to have_key(:nome_departamento)
          expect(response[:cadastro][:item]).to have_key(:setor)
          expect(response[:cadastro][:item]).to have_key(:nome_setor)
          expect(response[:cadastro][:item]).to have_key(:familia)
          expect(response[:cadastro][:item]).to have_key(:nome_familia)
          expect(response[:cadastro][:item]).to have_key(:subfamilia)
          expect(response[:cadastro][:item]).to have_key(:nome_subfamilia)
          expect(response[:cadastro][:item]).to have_key(:unidade)
          expect(response[:cadastro][:item]).to have_key(:in_brinde)
          expect(response[:cadastro][:item]).to have_key(:dt_lancto)
          expect(response[:cadastro][:item]).to have_key(:qt_prevenda)
          expect(response[:cadastro][:item]).to have_key(:pz_crossdocking)
          expect(response[:cadastro][:item]).to have_key(:altura)
          expect(response[:cadastro][:item]).to have_key(:largura)
          expect(response[:cadastro][:item]).to have_key(:comprimento)
          expect(response[:cadastro][:item]).to have_key(:peso_unitario)
          expect(response[:cadastro][:item]).to have_key(:tp_transp)
          expect(response[:cadastro][:item]).to have_key(:ok_fiscal)
          expect(response[:cadastro][:item]).to have_key(:pz_validade)
          expect(response[:cadastro][:item]).to have_key(:tp_garantia)
          expect(response[:cadastro][:item]).to have_key(:peso_bruto)
          expect(response[:cadastro][:item]).to have_key(:pz_gar_forn)
          expect(response[:cadastro][:item]).to have_key(:ean)
          expect(response[:cadastro][:item]).to have_key(:pr_medio)
          expect(response[:cadastro][:item]).to have_key(:situacao)
          expect(response[:cadastro][:item]).to have_key(:dt_cadastro)
          expect(response[:cadastro][:item]).to have_key(:dt_atu_situacao)
          expect(response[:cadastro][:item]).to have_key(:modelo_fabric)
          expect(response[:cadastro][:item]).to have_key(:ult_preco_compra)
          expect(response[:cadastro][:item]).to have_key(:especificacoes)
          expect(response[:cadastro][:item]).to have_key(:kit)
          expect(response[:cadastro][:item]).to have_key(:@id_item)
        end
      end
    end
  end

  describe '.confirm_item_list' do
    context 'when is valid' do
      it 'confirm items list' do
        VCR.use_cassette('confirm_item_list') do
          response = BsellerRuby::Item.confirm_to_list!({'confirmaSN' => 'S', 'tpInterface' => 'B2W'})
          expect(response.class).to be(Nori::StringWithAttributes)
          expect(response).to eql("Confirma consulta itens efetuada com sucesso")
        end
      end
    end
  end

  describe ".find" do
    it 'find an item' do
      binding.pry
      VCR.use_cassette('item_find', match_requests_on: [:headers]) do
        item = BsellerRuby::Item.find('262261', 'SITE')
        expect(item).to eql({"codigoItem"=>"262261", "codigoTerceiro"=>"262261", "codigoFornecedor"=>"7858778", "nome"=>"Teste", "titulo"=>nil, "descricao"=>nil, "marca"=>nil, "situacao"=>"A", "dataCadastro"=>"2015-10-23 19:55:12", "dataAtualizacaoCadastro"=>nil, "operacao"=>"N", "itemPai"=>false, "codigoItemPai"=>nil, "brinde"=>false, "tipoItem"=>"P", "itemVirtual"=>{"tipoItemVirtual"=>nil, "itemFisico"=>false, "prazoValidadeGarantia"=>nil, "tipoGarantia"=>nil}, "prazoGarantiaFornecedor"=>nil, "tipoTransporte"=>{"id"=>1, "nome"=>"Leve"}, "unidadeMedida"=>{"id"=>"UN", "nome"=>"Unidade"}, "okFiscal"=>false, "vendavel"=>false, "controlaVenda"=>false, "estruturaMercadologica"=>{"departamento"=>{"id"=>1, "nome"=>"Livro"}, "setor"=>{"id"=>1, "nome"=>"Negócio"}, "familia"=>{"id"=>1, "nome"=>"Administração e Negócios"}, "subFamilia"=>{"id"=>1, "nome"=>"Administração"}}, "dataLancamento"=>nil, "quantidadePrevenda"=>nil, "dimensoes"=>{"altura"=>1.0, "largura"=>1.0, "comprimento"=>1.0}, "peso"=>{"unitario"=>1.0, "bruto"=>1.0}, "ean"=>[{"codEan"=>119697000386}], "componentesKit"=>[], "fichaTecnica"=>[], "categorias"=>[], "variacoes"=>[], "preco"=>[], "tags"=>nil})
      end
    end

    it 'dont find an item' do
      VCR.use_cassette('item_dont_find', match_requests_on: [:headers]) do
        item = BsellerRuby::Item.find('1', 'SITE')
        expect(item).to eql({"message"=>"pck_api_item.get_item: ORA-20000: Item não cadastrado - Código Terceiro: 1", "detalheErro"=>nil})
      end
    end
  end
end
