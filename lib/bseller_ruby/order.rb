module BsellerRuby
  class Order < Base
    attr_reader :response

    def self.create!(params)
      call(:envia_pedido, params).result
    end

    def self.find(params)
      call(:consulta_entrega, params).result
    end

    def self.find_confirm(params)
      call(:confirma_consulta_entrega, params).result
    end

    #def self.sent_purchase
    #end
    #
    # Cabeçalho do Pedido
    #
    # => CLIENTEENT
    #
    # <P_BAIRRO_ENT />:      X(50),  Bairro do endereço de entrega
    # <P_CEP_ENT />:         9(8),   CEP do endereço de entrega
    # <P_CIDADE_ENT />:      X(50),  Cidade do endereço de entrega
    # <P_COMPL_ENT />:       X(50),  Complemento do endereço de entrega
    # <P_ID_TIPCLIE_ENT />:   9(9),   Tipo de cliente de entrega
    #                                 1 - Pessoa Jurídica no país
    #                                 2 - Pessoa Física no país
    #                                 5 - Pessoa Jurídica no País sem IE
    #
    # <P_INSEST_ENT/>:        X(18),  Inscrição Estadual do cliente do
    #                                 endereço de entrega.
    #                                 Obrigatório se o P_ID_TIPCLIE_ENT = 1
    #                                 (Pessoa Jurídica no país)
    #
    # <P_LOGRADOURO_ENT />:  X(60),  Endereço de Entrega
    # <P_NOME_ENT/>:          X(40),  Nome do cliente do endereço de entrega
    # <P_NUMERO_ENT />:      9(6),   Número do endereço de entrega
    # <P_PAIS_ENT />:        X(30),  País do endereço de entrega. Geralmente Brasil.
    # <P_REFERENCIA_ENT />:  X(100)  Ponto de referencia do endereço de entrega
    # <P_TEL_CELULAR />:      X(15),  Celular do cliente do endereço de entrega
    # <P_TEL_COMERCIAL />:    X(15),  Telefone comercial do cliente do endereço de entrega
    # <P_TEL_RESIDENCIAL />: X(15),  Telefone residencial do cliente do endereço de entrega
    # <P_UF_ENT />:          X(2),   Unidade Federativa do endereço de entrega
    # <P_ZIP_CODE_ ENT />:    X(14),  ZIP CODE do endereço de entrega
    #
    # => CLIENTEFAT
    #
    # <P_BAIRRO_FAT/>:          X(50)   Bairro do endereço de faturamento
    # <P_CEP_FAT/>:              9(8)   CEP do endereço de faturamento
    # <P_CIDADE_FAT/>:           X(50)  Cidade do endereço de faturamento
    # <P_COMPL_FAT/>:            X(50)  Complemento do endereço de faturamento
    # <P_DT_NASC/>:              D      Data de nascimento do cliente do endereço de faturamento -  DD/MM/AAAA
    # <P_EMAIL_FAT/>:            X(45)  E-mail do cliente de faturamento
    # <P_FAX_FAT/>:              X(15)  Fax do cliente de faturamento
    # <P_ID_CLASF_CLIENTE_FAT/>  9(9)   Classificação de cliente
    #                                   0 – Normal
    #                                   1 – VIP
    #                                   2 - Crítico
    #
    # <P_ID_CLIENTE_FAT/>         9(14)  CPF/CNPJ do cliente de faturamento
    # <P_ID_TIPCLIE_FAT/>         9(9)   Tipo de cliente de faturamento (FK)
    #                                     1 - Pessoa Jurídica no país
    #                                     2 - Pessoa Física no país
    #                                     5 - Pessoa Jurídica no País sem IE
    #
    # <P_INSEST_FAT/>             X(18)   Inscrição estadual do endereço de faturamento.
    #                                     Obrigatório se P_ID_TIPCLIE_FAT = 1
    #                                     (Pessoa Jurídica no país)
    #
    # <P_LOGRADOURO_FAT/>         X(60)   Endereço de Faturamento
    # <P_NOME_FAT/>               X(40)   Nome do cliente de faturamento
    # <P_NUMERO_FAT/>             9(6)    Número do endereço de faturamento
    # <  P_PAIS_FAT/>             X(30)   País do endereço de faturamento. Geralmente Brasil.
    # <P_REFERENCIA_FAT/>         X(100)  Ponto de referencia do endereço de faturamento
    # <P_RG/>                     X(20)   RG do cliente de faturamento
    # <P_SEXO/>                   X(1)    Sexo do cliente do endereço de faturamento:
    #                                     [F] - Feminino
    #                                     [M] - Masculino
    #
    # <P_TEL_CELULAR/>            X(15)   Celular do cliente de faturamento
    # <P_TEL_COMERCIAL/>          X(15)   Telefone comercial do cliente de faturamento
    # <P_TEL_RESIDENCIAL/>        X(15)   Telefone residencial do cliente de faturamento
    # <P_UF_FAT/>                 X(2)    Unidade Federativa do endereço de faturamento
    # <P_ZIP_CODE_FAT/>           X(14)   ZIP CODE do endereço de faturamento
    # <P_ID_CRT>                  9(1)    Código do Regime Tributário
    #                                     1 – Simples Nacional
    #                                     3 – Regime Normal
  end
end
