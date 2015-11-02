module BsellerRuby
  class Delivery < Base
    attr_reader :response

    def self.list(params)
      call(:consulta_entrega, params).result
    end

    def self.confirm!(params)
      call(:confirma_consulta_entrega, params).result
    end
  end
end

