module BsellerRuby
  class Stock < Base
    attr_reader :response

    PATH = "itens/estoque"

    # {
    #   "batchNumber": 0,
    #   "content": [
    #     {
    #       "codigoDepartamento": 0,
    #       "codigoItem": "string",
    #       "estoqueEstabelecimento": [
    #         {
    #           "codigoEstabelecimento": 0,
    #           "dataDisponivel": "2016-05-27T17:00:49.906Z",
    #           "prazoDisponivel": 0,
    #           "quantidade": 0
    #         }
    #       ]
    #     }
    #   ],
    #   "totalElements": 0
    # }
    #
    def self.massive(params)
      get("#{PATH}/massivo", params)
    end

    def self.massive_confirm(batch: nil)
      put("#{PATH}/massivo", batch, nil)
    end

    # <confirmaSN />: X(1), Informa se a consulta foi recebida e processada corretamente
    #                       S – Recebida e processada corretamente
    #                       N – Não foi recebida ou processada corretamente. Na próxima
    #                           consulta os dados serão enviados novamente.
    #
    # <tpInterface />: X(15), Interface cadastrada na ESEA0130. Se NULL
    #                         envia a interface padrão.

    def self.get_total(params)
      call(:consulta_estoque_total, params).result
    end

    def self.confirm_to_total_list!(params)
      call(:confirma_consulta_estoque_total, params).result
    end

    def self.get_partial(params)
      call(:consulta_estoque_parcial, params).result
    end

    def self.confirm_to_partial_list!(params)
      call(:confirma_consulta_estoque_parcial, params).result
    end

    def self.find(id_item, interface=nil)
      get("itens/#{id_item}/estoque", interface ? {tpInterface: interface} : nil)
    end
  end
end
