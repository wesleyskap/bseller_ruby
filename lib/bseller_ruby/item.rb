module BsellerRuby
  class Item < Base
    attr_reader :response

    PATH = "itens"

    # Retorno:
    # {
    #   "batchNumber": 0,
    #   "content": [
    #     {
    #       "codigoDepartamento": 0,
    #       "codigoItem": "string",
    #       "estoqueEstabelecimento": [
    #         {
    #           "codigoEstabelecimento": 0,
    #           "dataDisponivel": "2016-05-07T19:10:38.803Z",
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

    # <maxReg />: 9(9), Quantidade máxima de registros a ser retornada.
    #                   Se nulo ou zero trás todos os registros disponíveis.
    #
    # <confirmaSN />: X(1), Informa se vai chamar a interface confirmaConsultaItens
    #                   S – Irá chamar a interface confirmaConsultaItens
    #                   N – Não irá chamar a interface confirmaConsultaItens
    #                   Se não for informado, considera N
    #
    # <tpInterface />: X(15), Interface cadastrada na ESEA0130. Se NULL
    #                         envia a interface padrão.
    def self.get_list(params)
      call(:consulta_itens, params).result
    end

    # <confirmaSN />: X(1), Informa se a consulta foi recebida e processada corretamente
    #                       S – Recebida e processada corretamente
    #                       N – Não foi recebida ou processada corretamente. Na próxima
    #                           consulta os dados serão enviados novamente.
    #
    # <tpInterface />: X(15), Interface cadastrada na ESEA0130. Se NULL
    #                         envia a interface padrão.
    def self.confirm_to_list!(params)
      call(:confirma_consulta_itens, params).result
    end

    #<idItem />: X(50), Sim, Código do item
    #
    #<tpInterface />: X(15), Não, Código do tipo de interface
    def self.find(id_item, interface=nil)
      get("#{PATH}/#{id_item}", interface)
    end
  end
end
