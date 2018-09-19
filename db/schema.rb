# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20180919133518) do

  create_table "acompanhamento_despachos", :force => true do |t|
    t.integer  "acompanhamento_id"
    t.string   "despacho",          :limit => 600
    t.datetime "data"
    t.string   "funcionario"
    t.string   "obs"
    t.string   "aceite",                           :default => "RECUSADO"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acompanhamentos", :force => true do |t|
    t.string   "codigo"
    t.string   "crianca"
    t.string   "RA",             :limit => 20
    t.string   "inscricao"
    t.string   "mae"
    t.string   "responsavel"
    t.datetime "nascimento"
    t.string   "endereco"
    t.integer  "num"
    t.string   "complemento"
    t.string   "cep"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "fone"
    t.string   "fone1"
    t.string   "cel"
    t.string   "email"
    t.string   "assunto",        :limit => 600
    t.integer  "encerrado",                     :default => 0
    t.datetime "data_encerrado"
    t.string   "obs"
    t.string   "funcionario"
    t.string   "solicitante"
    t.string   "por",            :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administracaos", :force => true do |t|
    t.integer  "unidade_id",       :null => false
    t.integer  "tipo_controle_id"
    t.string   "servidor"
    t.string   "rede"
    t.string   "internet"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agendas", :force => true do |t|
    t.integer  "unidade_id"
    t.integer  "estagiario_id"
    t.date     "data"
    t.time     "horai"
    t.time     "horaf"
    t.string   "solicitante",   :limit => 100
    t.string   "proposito",     :limit => 200
    t.string   "obs",           :limit => 300
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "anexos", :force => true do |t|
    t.string   "titulo"
    t.text     "descricao"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "unidade_id"
  end

  create_table "aulas_eventuals", :force => true do |t|
    t.integer  "eventual_id"
    t.integer  "unidade_id"
    t.integer  "aulas_falta_id"
    t.integer  "classe_id"
    t.string   "categoria",      :limit => 20
    t.string   "periodo"
    t.integer  "ano_letivo"
    t.date     "data"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aulas_faltas", :force => true do |t|
    t.integer  "professor_id"
    t.integer  "funcionario_id"
    t.integer  "unidade_id"
    t.string   "funcao"
    t.string   "setor",          :limit => 20
    t.string   "classe",         :limit => 10
    t.string   "periodo",        :limit => 30
    t.string   "tipo",           :limit => 20
    t.date     "data"
    t.integer  "ano_letivo"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "c_externos", :force => true do |t|
    t.integer  "empresa_id"
    t.string   "atendente"
    t.datetime "data_hora"
    t.text     "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "protocolo"
    t.integer  "unidade_id"
    t.integer  "tipo_id"
    t.integer  "tipo"
    t.integer  "situacao",     :default => 0, :null => false
    t.datetime "data_encerra"
    t.string   "executado"
  end

  create_table "chamados", :force => true do |t|
    t.datetime "data_sol"
    t.string   "solicitante"
    t.integer  "unidade_id"
    t.string   "forma_sol"
    t.text     "problema"
    t.datetime "data_aten"
    t.integer  "estagiario_id"
    t.integer  "tipos_problema_id"
    t.integer  "patrimonio"
    t.string   "local"
    t.string   "procedimentos"
    t.integer  "situacao_chamado_id",                :default => 1
    t.datetime "data_enc"
    t.string   "obs",                 :limit => 200
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "chefias", :force => true do |t|
    t.string   "nome"
    t.string   "setor"
    t.boolean  "desligado",  :default => false, :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "componentes", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "computadores", :force => true do |t|
    t.integer  "unidade_id"
    t.integer  "tipo_controle_id"
    t.integer  "quant",                           :default => 1
    t.string   "config"
    t.string   "pat",              :limit => 10
    t.string   "serie",            :limit => 10
    t.string   "user",             :limit => 100
    t.string   "local",            :limit => 20
    t.string   "pertence",         :limit => 50,  :default => "SEDUC"
    t.string   "contato"
    t.string   "tipo",             :limit => 10
    t.string   "fabricante",       :limit => 15
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "computadores(ANTIGO)", :force => true do |t|
    t.integer  "unidade_id"
    t.integer  "tipo_controle_id"
    t.integer  "quant",            :default => 1
    t.string   "config"
    t.string   "pat"
    t.string   "user"
    t.string   "pertence"
    t.string   "contato"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contato_internos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contatos", :force => true do |t|
    t.string   "nome"
    t.integer  "telefone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "curriculos", :force => true do |t|
    t.string   "atuacao"
    t.string   "nome"
    t.string   "RG",              :limit => 12
    t.string   "CPF",             :limit => 14
    t.datetime "nascimento"
    t.string   "endereco"
    t.string   "complemento"
    t.string   "CEP"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "fone"
    t.string   "cel"
    t.string   "email"
    t.string   "civil"
    t.string   "modalidade"
    t.string   "curso"
    t.string   "instituicao"
    t.string   "periodo"
    t.string   "semestre"
    t.datetime "data_ingresso"
    t.datetime "data_termino"
    t.string   "pergunta1"
    t.string   "pergunta2"
    t.string   "pergunta3"
    t.string   "obs"
    t.string   "aval"
    t.string   "status"
    t.datetime "data_entrevista"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cursos", :force => true do |t|
    t.string   "nome_curto"
    t.string   "nome"
    t.string   "ministrante"
    t.string   "carga_horaria"
    t.text     "ementa"
    t.text     "obs"
    t.string   "horario",           :limit => 50
    t.integer  "qtde"
    t.integer  "vagas_disponiveis"
    t.boolean  "status",                           :default => false
    t.string   "datas",             :limit => 200
    t.string   "publico",           :limit => 200
    t.string   "local",             :limit => 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cursos_inscricaos", :id => false, :force => true do |t|
    t.integer "curso_id",     :null => false
    t.integer "inscricao_id", :null => false
  end

  create_table "data_files", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datashows", :force => true do |t|
    t.integer  "unidade_id"
    t.integer  "tipo_controle_id"
    t.integer  "quant"
    t.string   "config"
    t.string   "pat"
    t.string   "user"
    t.string   "pertence"
    t.string   "contato"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departamentos", :force => true do |t|
    t.integer  "unidade_id", :default => 53
    t.string   "depto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "despachos", :force => true do |t|
    t.integer  "prefprotocolo_id"
    t.string   "procedencia"
    t.datetime "data_recebimento"
    t.string   "para"
    t.string   "despacho",         :limit => 600
    t.string   "funcionario"
    t.string   "destino"
    t.string   "destinofinal"
    t.datetime "data_saida"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentos", :force => true do |t|
    t.string   "titulo"
    t.text     "descricao"
    t.integer  "c_externo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "documento_file_name"
    t.string   "documento_content_type"
    t.integer  "documento_file_size"
    t.datetime "documento_updated_at"
  end

  create_table "emfaltas", :force => true do |t|
    t.integer  "componente_id"
    t.string   "especifica"
    t.integer  "quant"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresas", :force => true do |t|
    t.string   "nome"
    t.string   "tipo_servico"
    t.string   "telefone"
    t.boolean  "status",       :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emprestimos", :force => true do |t|
    t.integer  "unidade_id"
    t.integer  "departamento_id",                :default => 1
    t.datetime "emprestimo"
    t.string   "periodo",         :limit => 100
    t.datetime "devolucao"
    t.string   "responsavel"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entradas", :force => true do |t|
    t.integer  "componente_id"
    t.integer  "estoque_id"
    t.integer  "quantidade"
    t.datetime "data_ent"
    t.string   "procedencia"
    t.string   "NF"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipamentos", :force => true do |t|
    t.string   "equipamento"
    t.string   "pat"
    t.string   "configuracao"
    t.integer  "unidade_id"
    t.datetime "dataent"
    t.string   "estado"
    t.string   "providencia"
    t.string   "procedimento"
    t.string   "instalacao"
    t.datetime "dataexec"
    t.string   "destinacao"
    t.string   "trouxe"
    t.integer  "estagiario_id"
    t.datetime "datasaida"
    t.integer  "os"
    t.integer  "encerrado",     :default => 0
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estagiarios", :force => true do |t|
    t.integer  "matricula_pma"
    t.integer  "unidade_id"
    t.integer  "regiao_id"
    t.string   "nome"
    t.string   "RG"
    t.string   "CPF"
    t.string   "endereco"
    t.integer  "num"
    t.string   "complemento"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "fone"
    t.string   "cel"
    t.string   "email"
    t.datetime "data_nasc"
    t.string   "faculdade"
    t.string   "matricula"
    t.string   "periodo_est"
    t.string   "carga_horaria",      :limit => 6
    t.string   "horario",            :limit => 20
    t.string   "responsavel"
    t.datetime "data_ingresso"
    t.datetime "data_termino"
    t.datetime "data_admissao"
    t.string   "matriculaPMA",       :limit => 10
    t.datetime "data_desliga"
    t.string   "locacao"
    t.string   "periodo_trab"
    t.string   "aval"
    t.string   "obs"
    t.integer  "flag",                             :default => 0
    t.integer  "desligado",                        :default => 0
    t.integer  "etinerante",                       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "tipo",               :limit => 50
  end

  create_table "estoques", :force => true do |t|
    t.integer  "componente_id",                              :null => false
    t.string   "especifica"
    t.integer  "saldo",                       :default => 0
    t.string   "condicao",      :limit => 20
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eventuals", :force => true do |t|
    t.integer  "professor_id"
    t.integer  "unidade_id"
    t.integer  "regiao_id"
    t.string   "categoria",       :limit => 20
    t.string   "disponibilidade"
    t.string   "periodo",         :limit => 25
    t.string   "contato",         :limit => 200
    t.integer  "ano_letivo"
    t.string   "obs"
    t.integer  "nao_atua",                       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fornecedores", :force => true do |t|
    t.string   "nome"
    t.string   "endereco"
    t.integer  "num"
    t.string   "complemento"
    t.string   "cidade"
    t.string   "fone"
    t.string   "cel"
    t.string   "email"
    t.string   "contato"
    t.string   "tipo_servico"
    t.string   "aval"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funcionarios", :force => true do |t|
    t.integer  "chefia_id"
    t.string   "nome"
    t.string   "matricula",   :limit => 15
    t.date     "nascimento"
    t.string   "endereco",    :limit => 200
    t.string   "num",         :limit => 10
    t.string   "complemento", :limit => 150
    t.string   "cep",         :limit => 15
    t.string   "bairro",      :limit => 150
    t.string   "cidade",      :limit => 150
    t.string   "fone",        :limit => 100
    t.string   "cel",         :limit => 100
    t.string   "email",       :limit => 150
    t.integer  "unidade_id"
    t.string   "funcao",      :limit => 50
    t.string   "setor"
    t.string   "atribuicao"
    t.string   "horario",     :limit => 20
    t.string   "status",      :limit => 50
    t.boolean  "desligado",                  :default => false
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impressoras", :force => true do |t|
    t.integer  "unidade_id"
    t.integer  "tipo_controle_id"
    t.integer  "quant"
    t.string   "config"
    t.string   "pat"
    t.string   "user"
    t.string   "pertence"
    t.string   "contato"
    t.integer  "baixado",          :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "informativos", :force => true do |t|
    t.text     "mensagem"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inscricaos", :force => true do |t|
    t.integer  "participante_id",                    :null => false
    t.integer  "curso_id",                           :null => false
    t.date     "data_inscricao"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",          :default => true
    t.boolean  "encerrado",       :default => false
  end

  create_table "itinerarios", :force => true do |t|
    t.integer  "estagiario_id"
    t.integer  "unidade_id"
    t.date     "data_visita"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "justificativas", :force => true do |t|
    t.integer  "ponto_id"
    t.text     "justificativa"
    t.boolean  "entrada",         :default => false
    t.boolean  "saida",           :default => false
    t.date     "dia"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estagiario_id"
    t.boolean  "cumpriu_horario"
    t.integer  "qtd_hrs"
    t.datetime "hora_saida"
    t.boolean  "feriado",         :default => false
    t.boolean  "recesso"
    t.boolean  "fimsemana"
  end

  create_table "mes_bases", :force => true do |t|
    t.date     "data"
    t.integer  "mes"
    t.integer  "qtde_dias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mmanutencaos", :force => true do |t|
    t.integer  "unidade_id",                                           :null => false
    t.integer  "situacao_manutencao_id",                :default => 1
    t.integer  "funcionario_id"
    t.string   "ffuncionario",           :limit => 100
    t.integer  "chefia_id"
    t.integer  "user_id"
    t.string   "descricao",              :limit => 500
    t.datetime "data_sol"
    t.datetime "data_ate"
    t.datetime "data_enc"
    t.datetime "data_autoriza"
    t.string   "forma"
    t.string   "solicitante"
    t.string   "procedimentos"
    t.string   "executado"
    t.string   "justificativa"
    t.string   "obs"
    t.string   "situacao",               :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mmanutencaos_tipos_manutencaos", :id => false, :force => true do |t|
    t.integer "tipos_manutencao_id", :null => false
    t.integer "mmanutencao_id",      :null => false
  end

  create_table "noticias", :force => true do |t|
    t.string   "titulo"
    t.text     "corpo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.string   "descricao_curta"
  end

  create_table "oficios", :force => true do |t|
    t.string   "codigo"
    t.string   "emissor"
    t.string   "assunto"
    t.string   "destinatario"
    t.datetime "data"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "online_users", :force => true do |t|
    t.string   "username"
    t.date     "last_seen"
    t.boolean  "online"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "chat_session"
  end

  create_table "orc_empenho_itens", :force => true do |t|
    t.integer  "orc_empenho_id"
    t.decimal  "quantidade",     :precision => 14, :scale => 2
    t.string   "descricao"
    t.decimal  "unitario",       :precision => 14, :scale => 2
    t.decimal  "total",          :precision => 14, :scale => 2
    t.decimal  "total_geral",    :precision => 14, :scale => 2
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orc_empenhos", :force => true do |t|
    t.integer  "orc_pedido_compra_id"
    t.string   "codigo"
    t.string   "processo"
    t.string   "npedido",              :limit => 20
    t.date     "data"
    t.date     "data_chegou"
    t.string   "projeto",              :limit => 50
    t.string   "interessado"
    t.integer  "ficha_id"
    t.string   "ficha",                :limit => 15
    t.string   "cnpj"
    t.date     "vencimento"
    t.date     "validade"
    t.string   "despesa"
    t.string   "cat_economica"
    t.string   "destinacao"
    t.string   "modalidade",           :limit => 50
    t.decimal  "valor_total",                        :precision => 14, :scale => 2, :default => 0.0
    t.integer  "pagamento",                                                         :default => 0
    t.date     "data_pg"
    t.string   "obs"
    t.integer  "cancelado",                                                         :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orc_empenhos(anterior)", :force => true do |t|
    t.integer  "orc_pedido_compra_id"
    t.string   "codigo"
    t.string   "processo"
    t.string   "npedido",              :limit => 20
    t.date     "data"
    t.date     "data_chegou"
    t.string   "projeto",              :limit => 50
    t.string   "interessado"
    t.string   "ficha",                :limit => 15
    t.string   "cnpj"
    t.date     "vencimento"
    t.date     "validade"
    t.string   "despesa"
    t.string   "cat_economica"
    t.string   "destinacao"
    t.string   "modalidade",           :limit => 50
    t.decimal  "valor_total",                        :precision => 14, :scale => 2, :default => 0.0
    t.integer  "pagamento",                                                         :default => 0
    t.date     "data_pg"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orc_fichas", :force => true do |t|
    t.string   "codigo"
    t.integer  "ano"
    t.string   "descricao"
    t.string   "ficha",                   :limit => 15
    t.integer  "orc_uni_orcamentaria_id"
    t.string   "dr"
    t.integer  "fonte"
    t.decimal  "valor_inicial",                         :precision => 14, :scale => 2, :default => 0.0
    t.decimal  "saldo_atual",                           :precision => 14, :scale => 2, :default => 0.0
    t.decimal  "saldo",                                 :precision => 14, :scale => 2, :default => 0.0
    t.decimal  "saldo_aporte",                          :precision => 14, :scale => 2, :default => 0.0
    t.decimal  "saldo_empenhado",                       :precision => 14, :scale => 2, :default => 0.0
    t.decimal  "saldo_transferido",                     :precision => 14, :scale => 2, :default => 0.0, :null => false
    t.decimal  "saldo_reservado",                       :precision => 14, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orc_nota_fiscals", :force => true do |t|
    t.integer  "orc_empenho_id_id"
    t.integer  "valor",             :limit => 10, :precision => 10, :scale => 0
    t.date     "data"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orc_pagamentos", :force => true do |t|
    t.integer  "orc_empenho_id"
    t.string   "codigo",         :limit => 10
    t.integer  "orc_ficha_id"
    t.string   "ficha",          :limit => 20
    t.string   "interessado"
    t.integer  "valor_pg",       :limit => 10,  :precision => 10, :scale => 0
    t.date     "data_pg"
    t.string   "nf",             :limit => 100
    t.date     "data_nf"
    t.string   "obs_pg"
    t.integer  "pago",                                                         :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orc_pedido_compras", :force => true do |t|
    t.string   "codigo"
    t.string   "objetivo"
    t.string   "fornecedor"
    t.string   "cnpj",          :limit => 20
    t.integer  "orc_ficha_id"
    t.decimal  "valor_total",                 :precision => 14, :scale => 2
    t.string   "justificativa"
    t.integer  "ano"
    t.datetime "devolucao"
    t.integer  "empenhado",                                                  :default => 0, :null => false
    t.string   "obs"
    t.integer  "user_id"
    t.date     "created_at"
    t.datetime "updated_at"
  end

  create_table "orc_pedido_descricaos", :force => true do |t|
    t.integer  "orc_pedido_compra_id"
    t.integer  "item"
    t.decimal  "quantidade",           :precision => 14, :scale => 2
    t.string   "descricao"
    t.decimal  "unitario",             :precision => 14, :scale => 2, :default => 0.0
    t.decimal  "total",                :precision => 14, :scale => 2, :default => 0.0
    t.decimal  "total_geral",          :precision => 14, :scale => 2, :default => 0.0
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orc_suplementacaos", :force => true do |t|
    t.integer  "orc_ficha_id"
    t.integer  "orc_ficha_origem_id",                                                 :null => false
    t.string   "processo"
    t.decimal  "valor_suplemento",    :precision => 14, :scale => 2, :default => 0.0
    t.date     "data"
    t.string   "orcamentaria"
    t.string   "destinacao"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orc_uni_despesas", :force => true do |t|
    t.string   "codigo"
    t.string   "descricao"
    t.integer  "ano"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orc_uni_orcamentarias", :force => true do |t|
    t.string   "codigo"
    t.string   "descricao"
    t.integer  "ano"
    t.integer  "orc_uni_despesa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participantes", :force => true do |t|
    t.string   "nome"
    t.string   "matricula"
    t.integer  "unidade_id"
    t.integer  "professor_id"
    t.integer  "funcionario_id"
    t.string   "funcao"
    t.string   "endereco"
    t.string   "num"
    t.string   "complemento"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "telefone"
    t.string   "cel"
    t.string   "email"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo_participante"
    t.string   "profissao"
    t.string   "CEP"
    t.string   "rg"
    t.string   "cpf"
    t.boolean  "desligado",         :default => true, :null => false
  end

  create_table "poda_gramas", :force => true do |t|
    t.integer  "unidade_id"
    t.string   "solicitante"
    t.date     "execucao"
    t.date     "agendamento"
    t.string   "executado",   :limit => 100
    t.string   "obs"
    t.date     "created_at"
    t.datetime "updated_at"
  end

  create_table "pontos", :force => true do |t|
    t.integer  "estagiario_id"
    t.datetime "entrada"
    t.datetime "saida"
    t.integer  "total_trabalhado", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ano"
    t.integer  "mes"
  end

  create_table "prefprotocolos", :force => true do |t|
    t.string   "codigo"
    t.datetime "data"
    t.string   "de"
    t.string   "assunto"
    t.string   "para"
    t.string   "destino"
    t.integer  "encerrado",         :default => 0
    t.datetime "data_encerramento"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "produtos", :force => true do |t|
    t.string   "produto"
    t.string   "fornecedor"
    t.integer  "estoque",      :limit => 10,  :precision => 10, :scale => 0, :default => 0
    t.string   "unidade"
    t.datetime "data_entrada"
    t.datetime "data_saida"
    t.string   "nf"
    t.string   "complemento"
    t.string   "funcionario"
    t.string   "destino",      :limit => 200
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "produtos_lancamentos", :force => true do |t|
    t.integer  "produto_id",                                                                 :null => false
    t.integer  "entrada",       :limit => 10,  :precision => 10, :scale => 0, :default => 0
    t.integer  "saida",         :limit => 10,  :precision => 10, :scale => 0, :default => 0
    t.date     "data_entrada"
    t.date     "data_saida"
    t.string   "nf"
    t.string   "complemento"
    t.string   "funcionario_e"
    t.string   "destino",       :limit => 200
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "protocolos", :force => true do |t|
    t.integer  "unidade_id"
    t.string   "problema"
    t.integer  "estagiario_id"
    t.datetime "data_sol"
    t.string   "solicitado"
    t.string   "atendente"
    t.string   "solicitacao"
    t.string   "protocolo"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regiaos", :force => true do |t|
    t.string   "regiao"
    t.string   "local"
    t.string   "unidade"
    t.string   "obs"
    t.boolean  "sem_esta",   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relatestagiarios", :force => true do |t|
    t.integer  "estagiario_id"
    t.integer  "unidade_id"
    t.string   "periodo"
    t.datetime "datahora"
    t.string   "responsavel"
    t.text     "ocorrencia"
    t.string   "providencia",   :limit => 800
    t.text     "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "validacao",                    :default => false
    t.string   "nome"
  end

  create_table "relatorios", :force => true do |t|
    t.integer  "unidade_id"
    t.integer  "estagiario_id"
    t.string   "responsavel"
    t.datetime "data"
    t.string   "problema"
    t.string   "procedimentos"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservar_salas", :force => true do |t|
    t.integer  "sala_id"
    t.date     "data_reserva"
    t.time     "horario_reservai"
    t.time     "horario_reservaf"
    t.string   "utilizacao"
    t.string   "solicitante"
    t.integer  "quantidade"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservar_salas_servicos_salas", :id => false, :force => true do |t|
    t.integer "servicos_sala_id", :null => false
    t.integer "reservar_sala_id", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "saidas", :force => true do |t|
    t.integer  "componente_id"
    t.integer  "estoque_id"
    t.integer  "estagiario_id"
    t.integer  "unidade_id"
    t.integer  "quantidade"
    t.datetime "data_saida"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salas", :force => true do |t|
    t.string   "sala"
    t.string   "descricao"
    t.string   "localizacao"
    t.string   "obs"
    t.boolean  "status",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "senhas", :force => true do |t|
    t.integer  "unidade_id", :null => false
    t.string   "de"
    t.string   "usuario"
    t.string   "senha"
    t.string   "fone"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servicos_internos", :force => true do |t|
    t.string   "codigo"
    t.string   "emissor"
    t.string   "assunto"
    t.string   "destinatario"
    t.datetime "data"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servicos_salas", :force => true do |t|
    t.string   "servico"
    t.string   "obs"
    t.boolean  "status",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "situacao_chamados", :force => true do |t|
    t.string   "situacao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "situacao_manutencaos", :force => true do |t|
    t.string   "situacao"
    t.boolean  "status",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temps", :force => true do |t|
    t.string   "nome"
    t.integer  "telefone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_controles", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_osexternas", :force => true do |t|
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipos", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipos_estagios", :force => true do |t|
    t.string   "nome",       :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipos_manutencaos", :force => true do |t|
    t.string   "servico"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipos_problemas", :force => true do |t|
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unidades_OLD", :force => true do |t|
    t.integer  "tipo_id",                    :null => false
    t.integer  "regiao_id"
    t.string   "nome"
    t.string   "endereco"
    t.integer  "num"
    t.string   "complemento"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "fone"
    t.string   "email"
    t.string   "diretor"
    t.string   "coordenador"
    t.string   "obs"
    t.integer  "estagiarioM", :default => 0, :null => false
    t.integer  "estagiarioV", :default => 0, :null => false
    t.integer  "estagiarioE", :default => 0, :null => false
    t.integer  "estagiarioN", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "biblioteca"
    t.string   "ip"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.integer  "unidade_id"
    t.string   "password_reset_code"
  end

end
