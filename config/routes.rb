ActionController::Routing::Routes.draw do |map|

  map.resources :seduc_candidatos, :collection => {:votacao => :get,:verificacao => :get, :votar => :get}
  
  map.resources :seduc_funcionarios

   map.resources :agendas

  map.resources :reservar_salas_servicos_salas

  map.resources :reservar_salas, :collection => {:confirma_agenda => :get}

  map.resources :servicos_salas

  map.resources :salas

  map.resources :mmanutencaos_tipos_manutencaos

  #map.resources :mmanutencaos

  #map.resources :manutencaos

  map.resources :acompanhamento_despachos

  map.resources :acompanhamentos, :collection => {:acompanhamento=>:get, :consulta => :get, :editar => :get}

  map.resources :despachos

  map.resources :prefprotocolos, :collection => {:consulta => :get, :protocolo=>:get, :protocolos => :get, :indexe => :get, :reabrir => :get}
  
  map.resources :servicos_internos, :collection => {:consulta => :get, :consultaint=>:get}

  map.resources :oficios, :collection => {:consulta => :get, :c=>:get, :oficios => :get,}

  map.resources :curriculos, :collection => {:curriculo => :get, :indexadmin => :get, :indexpedag => :get}

  map.resources :chefias

  map.resources :funcionarios

  map.resources :situacao_manutencaos

  map.resources :manutencaos_tipos_manutencaos

  #map.resources :manutencaos,  :collection => {:protocolo => :get, :consultas => :get, :selected_print => :get,:imprimir_manutencao => :get,:imp_manutencao => :get,:encerrados => :get, :busca_protocolo => :get}

  map.resources :mmanutencaos,  :collection => {:protocolo => :get, :consultas => :get, :selected_print => :get,:imprimir_manutencao => :get,:imp_manutencao => :get,:encerrados => :get, :busca_protocolo => :get , :estatistica => :get, :estatisticasM => :get, :estatisticasMA => :get, :estatisticasME => :get, :estatisticasMAt => :get, :estatisticasMANT => :get, :estatisticasMANTA => :get, :estatisticasMANTE => :get, :estatisticasMANTAt => :get, :consulta_unidade => :get}

  map.resources :tipos_manutencaos

  map.resources :cursos_inscricaos
#  map.resources :inscricaos
#  map.resources :participantes
#  map.resources :cursos

  map.resources :inscricaos, :collection => {:gera_pdf => :get,:listagem => :get, :listagem_participantes => :get,:checar => :get,:confirmacao => :get,:envia_email => :get,:estatistica => :get, :voltarinscricao => :get, :tipo_opcao => :get, :consultas => :get,:por_curso => :get}

  map.resources :cursos, :collection => {:voltar => :get, :c_curso => :get}

  map.resources :participantes, :collection => {:busca_por_turno => :get,:consulta => :get,:voltarparticipante => :get}, :member => [:addemail,:update_email]

  map.resources :noticias

  map.resources :importar

  map.resources :contato_internos

  map.resources :anexos

  map.resources :equipamentos, :collection => {:encerrado => :get, :consulta => :get}

  map.resources :justificativas

  map.resources :chats, :collection => {:busca => :get, :classe => :get}

  map.resources :informativos

  map.resources :mes_bases

  map.resources :pontos

  map.resources :relatestagiarios, :collection => {:validacao => :get}

  map.resources :tipo_osexternas

  map.resources :c_externos, :has_many => :documentos, :collection => {:instrucao => :get}

  map.resources :empresas

  map.resources :listaestagiarios

  map.resources :protocolos

  map.resources :emprestimos

  map.resources :regiaos

  map.resources :emfaltas

  map.resources :tipo_controles

  map.resources :datashows

  map.resources :impressoras

  map.resources :computadores

  map.resources :itinerarios

  map.resources :chamados, :collection => {:selected_print => :get, :busca_protocolo => :get}

  map.resources :situacao_chamados

  map.resources :tipos_problemas

  map.resources :fornecedores

  map.resources :componentes

  map.resources :relatorios

  map.resources :saidas

  map.resources :entradas

  map.resources :estoques

  map.resources :senhas

  map.resources :tipos

  map.resources :departamentos

  map.resources :seduc

  map.resources :administracaos, :collection => {:internet => :get}

  map.resources :estagiarios, :collection => {:periodo_unidade => :get, :periodo_estagio => :get, :periodo_trabalho => :get, :print_all => :get, :carga_horaria => :get, :rel_ponto => :get}

  map.resources :unidades, :collection => {:print_all => :get}

  map.resources :users

  map.resource :session, :informatica => :get

  map.resources :roles_users

  map.desconectar '/chat/desconectar', :controller => 'chats', :action => 'desconectar'
  #map.connect '/homes/acertar_online_users', :controller => 'homes', :action => 'acertar_online_users'

  map.resources :homes, :collection => {:push_data => :get}

  map.resource :password

  map.novo 'novo', :controller => 'chamados', :action => 'novo'

  map.sobre '/sobre', :controller => 'unidades', :action => 'sobre'

  map.connect '/estagiarios/rel_ponto/:year/:month', :controller => 'estagiarios', :action => 'rel_ponto', :year => nil, :month => nil
  map.connect '/estagiarios/carga_horaria/:estagiario_id_equals/:year/:month', :controller => 'estagiarios', :action => 'carga_horaria', :year => nil, :month => nil
  map.root :controller => 'homes', :action => 'index'
  map.internos 'internos', :controller => 'servicos_internos', :action => 'index'
  map.informatica 'informatica', :controller => 'sessions', :action => 'informatica'
  map.manutencao 'manutencao', :controller => 'sessions', :action => 'manutencao'
  map.seduc_candidato 'seduc_candidato', :controller => 'sessions', :action => 'seduc_candidato'
  map.oficio 'oficio', :controller => 'sessions', :action => 'oficio'
  map.protocolo 'protocolo', :controller => 'sessions', :action => 'protocolo'
  map.interno 'interno', :controller => 'sessions', :action => 'interno'
  map.upload 'upload', :controller => 'importar', :action => 'index'
  map.termo '/termo_servico', :controller => 'administracaos', :action => 'termo_servico'
  map.modelo '/download', :controller => 'inscricaos', :action => 'modelo'
  map.consulta_relatestagiario '/consulta_relatestagiario', :controller => 'relatestagiarios', :action => 'consulta1'
  map.geo "/geos/geo/:id", :controller => "geos", :action => "geo"
  map.exencerra '/exencerra', :controller => 'c_externos', :action => 'exencerra'
  map.resources :fornecedores
  map.consulta_unidade '/consulta_unidade', :controller => 'c_externos', :action => 'consultaunidade'
  map.consulta_tipo '/consulta_tipo', :controller => 'c_externos', :action => 'consultatipo'
  map.lista '/lista', :controller => 'estagiarios', :action => 'lista'
  #map.c_rel_iti '/c_rel_iti', :controller => 'relatorios', :action => 'consulta'
  map.c_datashow_uni '/c_datashow_uni', :controller => 'datashows', :action => 'consulta'
  map.c_imp_tpuni '/c_imp_tpuni', :controller => 'impressoras', :action => 'consultatiponome'
  map.c_imp_tp '/c_imp_tp', :controller => 'impressoras', :action => 'consultatipo'
  map.c_imp_uni '/c_imp_uni', :controller => 'impressoras', :action => 'consulta'
  map.c_comp_tpuni '/c_comp_tpuni', :controller => 'computadores', :action => 'consultatiponome'
  map.c_comp_fabr '/c_comp_fabr', :controller => 'computadores', :action => 'consultasfabricante'
  map.c_comp_tp '/c_comp_tp', :controller => 'computadores', :action => 'consultatipo'
  map.c_comp_uni '/c_comp_uni', :controller => 'computadores', :action => 'consulta'
  map.c_adm_tpuni '/c_adm_tpuni', :controller => 'administracaos', :action => 'consultatiponome'
  map.c_adm_tp '/c_adm_tp', :controller => 'administracaos', :action => 'consultatipo'
  map.c_adm_uni '/c_adm_uni', :controller => 'administracaos', :action => 'consulta'
  map.c_est_nom '/c_est_nom', :controller => 'estagiarios', :action => 'consulta'
  #map.c_curso '/c_curso', :controller => 'cursos', :action => 'consulta'
  map.c_curso_and '/c_curso_and', :controller => 'cursos', :action => 'consulta_and'
  map.c_curso_enc '/c_curso_enc', :controller => 'cursos', :action => 'consulta_enc'
  map.prefprot '/prefprot', :controller => 'prefprotocolos', :action => 'index'
  map.teste '/teste', :controller => 'prefprotocolos', :action => 'teste'
  map.impressao_chamado_manutencao '/impressao_chamado_manutencao', :controller =>'mmanutencao', :action =>'impressao_chamado_manutencao'
  

  map.estagio'/estagio', :controller => 'estagiarios', :action => 'estagio'
  map.c_uni_end '/c_uni_end', :controller => 'unidades', :action => 'por_endereco'
  map.c_uni_tp '/c_uni_tp', :controller => 'unidades', :action => 'consultatipo'
  map.c_uni_uni '/c_uni_uni', :controller => 'unidades', :action => 'consulta'
  map.totalizaS '/totalizaS', :controller => 'datashows', :action => 'totalizaS'
  map.totalizaI '/totalizaI', :controller => 'impressoras', :action => 'totalizaI'
  map.totalizaC '/totalizaC', :controller => 'computadores', :action => 'totalizaC'
  map.encerrados '/cencerrados', :controller => 'chamados', :action => 'encerrados'
  map.consulta '/consultas', :controller => 'fornecedores', :action => 'consulta'
  map.consulta_relatorio '/consulta_relatorio', :controller => 'relatestagiarios', :action => 'consulta'
  map.valida '/valida', :controller => 'relatestagiarios', :action => 'valida'
  map.sem_estagiario '/sem_estagiario', :controller => 'unidades', :action => 'sem_estagiarios'
  map.baixas '/baixas', :controller => 'estagiarios', :action => 'baixas'
  map.analistas '/analistas', :controller => 'estagiarios', :action => 'analistas'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.reset_password '/reset_password/:id', :controller => 'passwords', :action => 'edit'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
