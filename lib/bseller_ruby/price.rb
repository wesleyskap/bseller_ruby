module BsellerRuby
  class Price < Base
    attr_reader :response

    PATH = "itens/precos"

    def self.list(params = {})
      get(PATH, params)
    end

    def self.confirm(cod_item, params = {})
      post("#{PATH}/status/#{cod_item}?#{to_params(params)}", {})
    end
  end
end

