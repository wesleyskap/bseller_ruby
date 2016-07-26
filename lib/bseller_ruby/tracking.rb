module BsellerRuby
  class Tracking < Base
    attr_reader :response

    PATH = "/entregas/" # -> massivo{?unidadeNegocio,maxRegistros}""

    def self.massive(params)
      get("#{PATH}/massivo", params)
    end

    def self.massive_confirm(batch: nil)
      put("#{PATH}/massivo", batch, nil)
    end

    def self.list(params)
      call(:consulta_tracking, params).result
    end

    def self.confirm(params)
      call(:confirma_consulta_tracking, params).result
    end
  end
end
