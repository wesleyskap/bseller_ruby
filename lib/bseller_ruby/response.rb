require 'forwardable'

module BsellerRuby
  class Response
    include Enumerable
    extend Forwardable
    def_delegators :@savon, :to_s

    def initialize(method, savon)
      @method = method
      @savon = savon
    end

    def result
      @result = doc
    end

    private

    def doc
      @method =~ /confirm|envia_pedido/ || savon_hash =~ /CallableStatementCallback|PED_CLIENTE|sucesso/ ? savon_hash : xml_parser(savon_hash)
    end

    def xml_parser(xml)
      @xml_parser ||= Nori.new(convert_tags_to: lambda { |tag| tag.snakecase.to_sym }).parse(xml)
    end

    def savon_hash
      @savon_hash ||= @savon.hash[:envelope][:body]["#{@method}_response".to_sym]["#{@method}_return".to_sym]
    end
  end
end
