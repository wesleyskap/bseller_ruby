module BsellerRuby
  class Purchase < Base
    attr_reader :response

    def self.list(params = {})
      get(path, params)
    end

    def self.create!(params = {})
      post("#{path}?", params)
    end

    def self.confirm!(params = {})
      post("#{path}/status?", params)
    end

    private

      def self.path
        'compras/requisicao'
      end
  end
end
