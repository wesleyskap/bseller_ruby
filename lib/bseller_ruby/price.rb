module BsellerRuby
  class Price < Base
    attr_reader :response

    def self.list(params = {})
      get(path, params)
    end

    def self.confirm(cod_item, params = {})
      post("#{path}/status/#{cod_item}?#{to_params(params)}", {})
    end

    private

      def self.path
        'itens/precos'
      end
  end
end

