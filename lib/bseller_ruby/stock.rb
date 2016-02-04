module BsellerRuby
  class Stock < Base
    attr_reader :response

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
