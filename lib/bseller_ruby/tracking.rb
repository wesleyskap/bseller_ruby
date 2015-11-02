module BsellerRuby
  class Tracking < Base
    attr_reader :response

    def self.list(params)
      call(:consulta_tracking, params).result
    end

    def self.confirm(params)
      call(:confirma_consulta_tracking, params).result
    end
  end
end
