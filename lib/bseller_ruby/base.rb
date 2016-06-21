#
# Operations provided by your service:
# [:get_versao, :consulta_estoque_parcial, :consulta_estoque_total,
#  :confirma_consulta_estoque_total, :consulta_tracking, :confirma_consulta_tracking,
#  :confirma_consulta_estoque_parcial, :importa_vales, :confirma_importa_vales,
#  :envia_pedido, :consulta_entrega, :confirma_consulta_entrega, :consulta_itens,
#  :confirma_consulta_itens]
#
module BsellerRuby
  class Base
    attr_reader :response

    def initialize(params)
      params.each do |key, value|
        instance_variable_set "@#{key}", value
        define_singleton_method(key) { instance_variable_get "@#{key}" }
      end
    end

    class << self
      %w(ws resource_name collection_name).each do |attribute|
        define_method "#{attribute}=" do |param|
          instance_variable_set "@#{attribute}", param
        end

        define_method "#{attribute}" do
          instance_variable_get "@#{attribute}"
        end
      end

      def collection_name
        @collection_name = "#{resource_name}s"
      end

      def call(method, params)
        @method = method
        params.merge!(authentication) if params.class.eql?(Hash)
        Response.new method, api.call(method, message: params)
      end

      def create(method, params)
        new response: call(method, params)
      end

      def get(resource, params = {})
        json_parse(execute(:get, "#{resource}?#{to_params(params)}"))
      end

      def post(path, body, &block)
        json_parse(execute(:post, path, body: body, &block))
      end

      def put(resource, path, payload)
        json_parse(execute(:put, "#{resource}/#{path}?a=1", body: payload))
      end
    end

    private

    def self.execute(method, path, params = {}, &block)
      begin
        params[:payload] = JSON.generate(params[:body]) if params[:body]
      rescue
        params[:payload] = params[:body]
      end
      headers = { accept: 'application/json', content_type: 'application/json', 'X-AUTH-TOKEN' => ws['json_token'] }
      RestClient::Request.execute({ verify_ssl: false, method: method, url: "#{ws['json_endpoint']}/#{path}&api_key=#{ws['json_token']}", headers: headers, :timeout => 600, :open_timeout => 600}.merge(params), &block)
    end

    def self.to_params(params)
      params.map { |key, value| "#{key}=#{value}" }.join "&"
    end

    def self.camelize(key)
      key.to_s.split(/_/).map{ |word| word.capitalize }.join('')
    end

    def self.json_parse(value)
      value.class.eql?(String) ? JSON.parse(value) : JSON.parse(value.response)
    end

    def self.api
      @api = Savon.client wsdl: "#{ws['soap_endpoint']}/#{get_wsdl}?wsdl", log: true, read_timeout: 600, open_timeout: 600 do
        convert_request_keys_to :camelcase
      end
    end

    def self.get_wsdl
      @method =~ /pagamento/ ? 'CPPagamento' : 'CPPedido'
    end

    def self.ws
      BsellerRuby.config['ws']
    end

    def self.authentication
      unless @method =~ /pagamento/
        @authentication = { 'idCia' => ws['cia_id'], 'usuario' => ws['username'], 'senha' => ws['password'] }
        @method.to_s.end_with?('pedido') ? {} : @authentication
      end
      @authentication || {}
    end
  end
end

