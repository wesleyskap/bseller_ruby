require 'spec_helper'

describe BsellerRuby::Order do
  describe '.create!' do
    context 'when the order already is registered' do
      it 'return mensage' do
        VCR.use_cassette('_order_sale') do
          response = BsellerRuby::Order.create!(sale_params)
          expect(response).to include('PED_CLIENTE 1509161747 ja foi incluido no sistema')
        end
      end

      it 'return mensage' do
        VCR.use_cassette('_order_with_two_item') do
          response = BsellerRuby::Order.create!(sale_params)
          expect(response).to include('PED_CLIENTE 1509161747 ja foi incluido no sistema')
        end
      end
    end
  end

  describe '.find' do
    context 'when need to confirm' do
      it 'return mensage' do
        VCR.use_cassette('order_find') do
          response = BsellerRuby::Order.find({'confirmaSN' => 'S', 'maxReg' => '10'})
          expect(response).to an_instance_of(Hash)
        end

        VCR.use_cassette('order_find_confirm') do
          response = BsellerRuby::Order.find_confirm({'confirmaSN' => 'S'})
          expect(response).to include('Confirma consulta entrega efetuada com sucesso')
        end
      end
    end
  end

  def sale_params
    {
      'pedido' =>
      {
        'cabecalho' =>
        {
          'clienteent' =>
          {
            'p_bairro_ent' => 'Brooklin Novo',
            'p_cep_ent' => '04602000',
            'p_cidade_ent' => 'São Paulo',
            'p_compl_ent' => 'Complemento 1',
            'p_email_ent' => 'email@isupply.com.br',
            'p_fax_ent' => '11 11111111',
            'p_id_cliente_ent' => '31636302866',
            'p_id_tipclie_ent' => '2',
            'p_insest_ent' => '',
            'p_logradouro_ent' => 'Rua 1',
            'p_nome_ent' => 'Wesley Conde',
            'p_numero_ent' => '123',
            'p_pais_ent' => 'Brasil',
            'p_referencia_ent' => 'Referencia 1',
            'p_tel_celular' => '11 922222222',
            'p_tel_comercial' => '11 33333333',
            'p_tel_residencial' => '11 44444444',
            'p_uf_ent' => 'SP',
            'p_zip_code_ent' => ''
          },
          'clientefat' =>
          {
            'p_bairro_fat' => 'Brooklin Novo',
            'p_cep_fat' => '04602000',
            'p_cidade_fat' => 'São Paulo',
            'p_compl_fat' => 'Complemento 1',
            'p_email_fat' => 'email@isupply.com.br',
            'p_fax_fat' => '11 11111111',
            'p_id_clasf_cliente_fat' => '0',
            'p_id_cliente_fat' => '31636302866',
            'p_id_tipclie_fat' => '2',
            'p_insest_fat' => '',
            'p_logradouro_fat' => 'Rua 1',
            'p_nome_fat' => 'Wesley Conde',
            'p_numero_fat' => '73',
            'p_pais_fat' => 'Brasil',
            'p_referencia_fat' => 'Referencia 1',
            'p_tel_celular' => '11 922222222',
            'p_tel_comercial' => '11 33333333',
            'p_tel_residencial' => '11 44444444',
            'p_uf_fat' => 'SP',
            'p_zip_code_fat' => '',
          },

          'entrega' =>
          {
            'p_dt_entrega_prom' => '',
            'p_id_periodo_agenda' => '',
            'p_id_tp_entrega' => '1',
          },

          'p_cif_fob' => 'C',
          'p_cod_vendedor' => '',
          'p_dt_emissao' => '25/07/2015',
          'p_dt_inclusao' => '25/07/2015 12:00:00',
          'p_id_canal' => 'SITE',
          'p_id_cia' => '11263',
          'p_in_consumo' => '',
          'p_id_unineg' => '1',
          'p_in_pedido' => 'N',
          'p_in_quebra' => '',
          'p_ip_origem' => '200.185.249.113',
          'p_obs_etiqueta' => '',
          'p_origem_interface' => '',
          'p_ped_cliente' => '1509161747',
          'p_ped_externo' => 'B2W-987654321',
          'p_ped_loja' => '',
          'p_utm_campaign' => '',
          'p_utm_medium' => '',
          'p_utm_source' => '',

          'valores' =>
          {
            'p_vl_desp_fin' => '1.00',
            'p_vl_despesas' => '3.00',
            'p_vl_frete' => '0.00',
            'p_vl_merc' => '100.00'
          }
        },

        'item' =>
        [[{ 'Item' => {
            'p_cod_estab_saida' => '1',
            'p_cod_estab_est' => '3',
            'p_filial_cnpj' => '13933305000289',
            'p_id_contr_transp' => '',
            'p_id_item' => '118991',
            'p_id_item_garantido' => '',
            'p_id_item_kit' => '',
            'p_id_item_pai' => '',
            'p_id_transp' => '',
            'p_pz_cd' => '1',
            'p_pz_forn' => '1',
            'p_pz_transit' => '1',
            'p_qt' => '1',
            'p_seq' => '1',
            'p_seq_garantido' => '',
            'p_tp_estoque' => '',
            'p_vl_custo' => '',
            'p_vl_desc_cond_unit' => '0',
            'p_vl_desc_inc_unit' => '0',
            'p_vl_despesa' => '2',
            'p_vl_frete' => '0',
            'p_vl_unitario' => '75.00'
          }}],
          [{'Item' => {
            'p_cod_estab_saida' => '1',
            'p_cod_estab_est' => '3',
            'p_filial_cnpj' => '13933305000289',
            'p_id_contr_transp' => '',
            'p_id_item' => '118991',
            'p_id_item_garantido' => '',
            'p_id_item_kit' => '',
            'p_id_item_pai' => '',
            'p_id_transp' => '',
            'p_pz_cd' => '1',
            'p_pz_forn' => '1',
            'p_pz_transit' => '1',
            'p_qt' => '1',
            'p_seq' => '1',
            'p_seq_garantido' => '',
            'p_tp_estoque' => '',
            'p_vl_custo' => '',
            'p_vl_desc_cond_unit' => '0',
            'p_vl_desc_inc_unit' => '0',
            'p_vl_despesa' => '2',
            'p_vl_frete' => '0',
            'p_vl_unitario' => '75.00'
          }}]],
        'pagamento' => {
          'Pagamento' =>
          {
            'p_bairro' => 'Novo Broklin',
            'p_cartao_6digs' => '1234****1234',
            'p_cep' => '04602000',
            'p_cidade' => 'São Paulo',
            'p_cod_seguranca' => '123',
            'p_compl' => '3o andar',
            'p_cpf_tit_cartao' => '31636302866',
            'p_dt_vencto_bo' => '',
            'p_dt_vencto_cartao' => '09/2020',
            'p_id_agencia' => '',
            'p_id_banco' => '',
            'p_id_bandeira_cartao' => '1',
            'p_id_conta' => '',
            'p_id_meio_pagto' => '1',
            'p_id_vale' => '',
            'p_logradouro' => 'R. Barão do Triunfo',
            'p_nu_cartao' => '12345678909876543',
            'p_nu_cupom' => '',
            'p_nu_parcelas' => '1',
            'p_numero' => '73',
            'p_pais' => 'Brasil',
            'p_pe_juros' => '1',
            'p_seq' => '1',
            'p_sit_cod_seguranca' => '1',
            'p_titular_cartao' => 'Leonardo D Franco',
            'p_uf' => 'SP',
            'p_vl_juros' => '1',
            'p_vl_juros_adm' => '2',
            'p_vl_meio' => '104.00'
          }
        },
        'credencial' =>
        {
          'senha' => 'ZUm50ZWoQjihbmlE0ELxDw==',
          'usuario' => 'RpnAKtPjGWZ0YJ32atSCmg==',
        }
      }
    }.compare_by_identity
  end
end
