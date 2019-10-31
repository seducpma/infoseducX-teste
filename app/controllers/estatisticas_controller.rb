class EstatisticasController < ApplicationController
  before_filter :load_unidades
  def index

  end


def estatistica
end

  def grafico_demanda_geral
    @graph = open_flash_chart_object(600,300,"/grafico/graph_code_demanda_geral")

        @static_graph = Gchart.pie_3d(
          :data => [(Crianca.matriculada).length,(Crianca.na_demanda).length, (Crianca.cancelada).length],
          :title => "Demanda Geral - Crianças Cadastradas: #{Crianca.total_demanda.length}",
          :size => '600x300',
          :format => 'image_tag',
          :labels => ["Matriculadas: #{(Crianca.matriculada).length}", "Demanda: #{(Crianca.na_demanda).length}" , "Canceladas: #{(Crianca.cancelada).length}",])
  end  

  def impressao_geral


    if  session[:geral] == 0
      @graph = open_flash_chart_object(600,300,"/grafico/graph_code_demanda_geral")

          @static_graph = Gchart.pie_3d(
            :data => [(Crianca.matriculada).length,(Crianca.na_demanda).length, (Crianca.cancelada).length],
            :title => "Demanda Geral - Crianças Cadastradas: #{Crianca.total_demanda.length}",
            :size => '700x350',
            :format => 'image_tag',
            :labels => ["Matriculadas: #{(Crianca.matriculada).length}", "Demanda: #{(Crianca.na_demanda).length}" , "Canceladas: #{(Crianca.cancelada).length}",])
    else

      @static_graph = Gchart.pie_3d(
            :data => [(Crianca.matriculas_crianca_por_unidade(session[:input])).length,(Crianca.nao_matriculas_crianca_por_unidade(session[:input])).length, (Crianca.cancelada_crianca_por_unidade(session[:input])).length],
            :title => "Demanda por Unidade: #{Crianca.nome_unidade(session[:input])} - #{(Crianca.todas_crianca_por_unidade(session[:input])).length}" ,
            :size => '700x350',
            :format => 'image_tag',
            :labels => ["Matriculadas: #{(Crianca.matriculas_crianca_por_unidade(session[:input])).length}", "Demanda: #{(Crianca.nao_matriculas_crianca_por_unidade(session[:input])).length}", "Canceladas: #{(Crianca.cancelada_crianca_por_unidade(session[:input])).length}"])

    end
      render :layout => "impressao"

end

    def impressao_estatistica_unidade

t=0


#    if  session[:geral] == 0
    vencerrado=(Mmanutencao.aberto_unidade(session[:input])).length
    vaberto =  (Mmanutencao.encerrado_unidade(session[:input])).length
    vtotal= Mmanutencao.geral.length
    pe = (vencerrado.to_f/vtotal.to_f)*100
    pa = (vaberto.to_f/vtotal.to_f)*100
    pr = (vtotal.to_f-vencerrado.to_f-vaberto.to_f)/vtotal.to_f * 100

        valvenaria = (Mmanutencao.alvernaria_aberto_unidade(session[:input])).length
        vdedetizacao = (Mmanutencao.dedetizacao_aberto_unidade(session[:input])).length
        veletrodomesticos = (Mmanutencao.eletro_aberto_unidade(session[:input])).length
        veletrica = (Mmanutencao.eletri_aberto_unidade(session[:input])).length
        vequipamento_cozinha = (Mmanutencao.cozinha_aberto_unidade(session[:input])).length
        vhidraulica = (Mmanutencao.hidrau_aberto_unidade(session[:input])).length
        vlimpeza = (Mmanutencao.limpeza_aberto_unidade(session[:input])).length
        vmarcenaria = (Mmanutencao.marcenaria_aberto_unidade(session[:input])).length
        vpintura = (Mmanutencao.pintura_aberto_unidade(session[:input])).length
        vplayground = (Mmanutencao.playground_aberto_unidade(session[:input])).length
        vpoda_grama = (Mmanutencao.aberto_unidade(session[:input])).length
        vserralheria = (Mmanutencao.serallheria_aberto_unidade(session[:input])).length
        vtelhado = (Mmanutencao.telhado_aberto_unidade(session[:input])).length
        voutros = (Mmanutencao.outros_aberto_unidade(session[:input])).length


        palvenaria = (valvenaria.to_f / vaberto)*100
        pdedetizacao = (vdedetizacao.to_f / vaberto)*100
        peletrodomesticos =(veletrodomesticos.to_f / vaberto)*100
        peletrica= (veletrica.to_f / vaberto)*100
        pequipamento_cozinha= (vequipamento_cozinha / vaberto)*100 
        phidraulica=(vhidraulica.to_f / vaberto)*100
        plimpeza=(vlimpeza.to_f / vaberto)*100 
        pmarcenaria=(vmarcenaria.to_f / vaberto)*100 
        ppintura=(vpintura.to_f / vaberto)*100 
        pplayground=(vplayground.to_f / vaberto)*100 
        ppoda_grama=(vpoda_grama.to_f / vaberto)*100 
        pserralheria=(vserralheria.to_f / vaberto)*100
        ptelhado=(vtelhado.to_f / vaberto)*100 
        poutros=(voutros.to_f / vaberto)*100



   @static_graph = Gchart.pie_3d(
        :data => [vaberto,vencerrado, (vtotal-vencerrado-vaberto)/3],
        :title => "Unidade: #{Mmanutencao.nome_unidade(session[:input])} - #{(Mmanutencao.por_unidade(session[:input]) ).length} chamados de um total de #{vtotal} " ,
        :size => '600x300',
        :format => 'image_tag',
        :labels => ["Abertas:  #{vaberto} ", "Encerradas:  #{vencerrado}", "Outras: #{(vtotal-vencerrado-vaberto)}",])


   @static_graph2 = Gchart.pie_3d(
        :data => [vaberto,vencerrado],
        :title => "Unidade: #{Mmanutencao.nome_unidade(session[:input])} - #{(Mmanutencao.por_unidade(session[:input])).length} chamados" ,
        :size => '900x450',
        :format => 'image_tag',
        :labels => ["Abertas:  #{vaberto}", "Encerradas:  #{vencerrado}", ])



@static_graph3 = Gchart.pie_3d(
        :data => [ valvenaria, vdedetizacao, veletrodomesticos, veletrica, vequipamento_cozinha, vhidraulica, vlimpeza,  vmarcenaria,  vpintura, vplayground, vpoda_grama, vserralheria, vtelhado, voutros],               
        :title => "Unidade: #{Mmanutencao.nome_unidade(session[:input])} - #{(Mmanutencao.por_unidade(session[:input])).length} Serviços" ,
        :size => '1000x500',
        :format => 'image_tag',
        :labels => ["Alvenaria:  #{valvenaria}", "Dedetização:  #{vdedetizacao}", "Eletrodomésticos:  #{veletrodomesticos}","Elétrica:  #{veletrica}", "Equip.Cozinha:  #{vequipamento_cozinha}", "Hidráulica:  #{vhidraulica}","Limp.Cx.Água:  #{vlimpeza}", "Marcenaria:  #{ vmarcenaria}", "Pintura:  #{ vpintura}","Playground:  #{vplayground}", "Poda grama:  #{vpoda_grama}","Serralheria:  #{vserralheria}","Telhado:  #{ vtelhado}","Outros:  #{voutros}",])

        
    
 #    else

#      @static_graph = Gchart.pie_3d(
#            :data => [(Crianca.matriculas_crianca_por_unidade(session[:input])).length,(Crianca.nao_matriculas_crianca_por_unidade(session[:input])).length, (Crianca.cancelada_crianca_por_unidade(session[:input])).length],
#            :title => "Demanda por Unidade: #{Crianca.nome_unidade(session[:input])} - #{(Crianca.todas_crianca_por_unidade(session[:input])).length}" ,
#            :size => '700x350',
#            :format => 'image_tag',
#            :labels => ["Matriculadas: #{(Crianca.matriculas_crianca_por_unidade(session[:input])).length}", "Demanda: #{(Crianca.nao_matriculas_crianca_por_unidade(session[:input])).length}", "Canceladas: #{(Crianca.cancelada_crianca_por_unidade(session[:input])).length}"])

#    end
      render :layout => "impressao"

end

  def grafico_demanda_unidade

  end

  def por_unidade
    $menu=1
    session[:input] = params[:contact][:grafico_id]
    @graph = open_flash_chart_object(600,300,"/estatistica/grafico_por_unidade?unidade=#{session[:input]}",false,'/')

    vencerrado=(Mmanutencao.encerrado_unidade(session[:input])).length
    vaberto =  (Mmanutencao.aberto_unidade(session[:input])).length
    vtotal= Mmanutencao.geral.length
        valvenaria = (Mmanutencao.alvenaria_aberto_unidade(session[:input])).length
        vdedetizacao = (Mmanutencao.dedetizacao_aberto_unidade(session[:input])).length
        veletrodomesticos = (Mmanutencao.eletro_aberto_unidade(session[:input])).length
        veletrica = (Mmanutencao.eletrica_aberto_unidade(session[:input])).length
        vequipamento_cozinha = (Mmanutencao.cozinha_aberto_unidade(session[:input])).length
        vhidraulica = (Mmanutencao.hidrau_aberto_unidade(session[:input])).length
        vlimpeza = (Mmanutencao.limpeza_aberto_unidade(session[:input])).length
        vmarcenaria = (Mmanutencao.marcenaria_aberto_unidade(session[:input])).length
        vpintura = (Mmanutencao.pintura_aberto_unidade(session[:input])).length
        vplayground = (Mmanutencao.playground_aberto_unidade(session[:input])).length
        vpoda_grama = (Mmanutencao.aberto_unidade(session[:input])).length
        vserralheria = (Mmanutencao.serralheria_aberto_unidade(session[:input])).length
        vtelhado = (Mmanutencao.telhado_aberto_unidade(session[:input])).length
        voutros = (Mmanutencao.outros_aberto_unidade(session[:input])).length
    pe = (vencerrado.to_f/vtotal.to_f)*100
    pa = (vaberto.to_f/vtotal.to_f)*100
    pr = (vtotal.to_f-vencerrado.to_f-vaberto.to_f)/vtotal.to_f * 100

      
    @static_graph = Gchart.pie_3d(
        :data => [vaberto,vencerrado, (vtotal-vencerrado-vaberto)/2],
        :title => "Unidade: #{Mmanutencao.nome_unidade(session[:input])} - #{(Mmanutencao.por_unidade(session[:input]) ).length} chamados de um total de #{vtotal} " ,
        :size => '700x400',
        :format => 'image_tag',
        :labels => ["Abertas: #{vaberto}", "Encer.:#{vencerrado}", "Outras: #{(vtotal-vencerrado-vaberto)}",])
        

   @static_graph2 = Gchart.pie_3d(
        :data => [vaberto,vencerrado],
        :title => "Unidade: #{Mmanutencao.nome_unidade(session[:input])} - #{(Mmanutencao.por_unidade(session[:input])).length} chamados" ,
        :size => '700x400',
        :format => 'image_tag',
        :labels => ["Abertas: #{vaberto}", "Encer.: #{vencerrado}", ])

    @static_graph3 = Gchart.pie_3d(
        :data => [ valvenaria, vdedetizacao, veletrodomesticos, veletrica, vequipamento_cozinha, vhidraulica, vlimpeza,  vmarcenaria,  vpintura, vplayground, vpoda_grama, vserralheria, vtelhado, voutros],
        :title => "Unidade: #{Mmanutencao.nome_unidade(session[:input])} - #{vaberto} Serviços em Aberto"  ,
        :size => '700x400',
        :format => 'image_tag',
        :labels => ["Alven.: #{valvenaria}", "Dedetiz.: #{vdedetizacao}", "Ele.dom.: #{veletrodomesticos}","Elétrica: #{veletrica}", "E.Coz.: #{vequipamento_cozinha}", "Hidráu.: #{vhidraulica}","CxÁgua: #{vlimpeza}", "Marcen.: #{ vmarcenaria}", "Pintura: #{ vpintura}","Playgrou.: #{vplayground}", "P.Grama: #{vpoda_grama}","Serral.:  #{vserralheria}","Telhado: #{ vtelhado}","Outros: #{voutros}",])


      render :action => "estatistica_unidade"
  end


   def por_servico
    $menu=1
    session[:input] = params[:contact][:grafico_id]
    @graph = open_flash_chart_object(600,300,"/estatistica/grafico_por_servico?servico=#{session[:input]}",false,'/')

    vencerrado= (Mmanutencao.encerrado_servico(session[:input])).length
    vaberto = (Mmanutencao.aberto_servico(session[:input])).length
    vtotal= Mmanutencao.geral.length

        quant_unidade = Unidade.all(:conditions =>['desativada = 0']).count


        valvenaria = (Mmanutencao.alvenaria_aberto_unidade(session[:input])).length
        vdedetizacao = (Mmanutencao.dedetizacao_aberto_unidade(session[:input])).length
        veletrodomesticos = (Mmanutencao.eletro_aberto_unidade(session[:input])).length
        veletrica = (Mmanutencao.eletrica_aberto_unidade(session[:input])).length
        vequipamento_cozinha = (Mmanutencao.cozinha_aberto_unidade(session[:input])).length
        vhidraulica = (Mmanutencao.hidrau_aberto_unidade(session[:input])).length
        vlimpeza = (Mmanutencao.limpeza_aberto_unidade(session[:input])).length
        vmarcenaria = (Mmanutencao.marcenaria_aberto_unidade(session[:input])).length
        vpintura = (Mmanutencao.pintura_aberto_unidade(session[:input])).length
        vplayground = (Mmanutencao.playground_aberto_unidade(session[:input])).length
        vpoda_grama = (Mmanutencao.aberto_unidade(session[:input])).length
        vserralheria = (Mmanutencao.serralheria_aberto_unidade(session[:input])).length
        vtelhado = (Mmanutencao.telhado_aberto_unidade(session[:input])).length
        voutros = (Mmanutencao.outros_aberto_unidade(session[:input])).length


    pe = (vencerrado.to_f/vtotal.to_f)*100
    pa = (vaberto.to_f/vtotal.to_f)*100
    pr = (vtotal.to_f-vencerrado.to_f-vaberto.to_f)/vtotal.to_f * 100
    @static_graph4 = Gchart.pie_3d(
        :data => [vaberto,vencerrado, (vtotal-vencerrado-vaberto)/2],
        :title => "Serviço: #{Mmanutencao.servico(session[:input])} - #{(Mmanutencao.por_servico(session[:input]) ).length} serviços de um total de #{vtotal} " ,
        :size => '700x400',
        :format => 'image_tag',
        :labels => ["Aberto: #{vaberto}", "Encer: #{vencerrado}", "Outros: #{(vtotal-vencerrado-vaberto)}",])


   @static_graph5 = Gchart.pie_3d(
        :data => [vaberto,vencerrado],
        :title => "Serviço: #{Mmanutencao.servico(session[:input])} - #{(Mmanutencao.por_servico(session[:input])).length} chamados" ,
        :size => '700x400',
        :format => 'image_tag',
        :labels => ["Aberto: #{vaberto}", "Encer: #{vencerrado}", ])

    @static_graph3 = Gchart.pie_3d(
        :data => [ valvenaria, vdedetizacao, veletrodomesticos, veletrica, vequipamento_cozinha, vhidraulica, vlimpeza,  vmarcenaria,  vpintura, vplayground, vpoda_grama, vserralheria, vtelhado, voutros],
        :title => "Unidade: #{Mmanutencao.nome_unidade(session[:input])} - #{(Mmanutencao.por_unidade(session[:input])).length} Serviços em Aberto"  ,
        :size => '700x400',
        :format => 'image_tag',
        :labels => ["Alven.: #{valvenaria}", "Dedetiz.: #{vdedetizacao}", "Ele.dom.: #{veletrodomesticos}","Elétrica: #{veletrica}", "E.Coz.: #{vequipamento_cozinha}", "Hidráu.: #{vhidraulica}","Cx.Água: #{vlimpeza}", "Marcenar.: #{ vmarcenaria}", "Pintura: #{ vpintura}","Playgrou.: #{vplayground}", "P.Grama: #{vpoda_grama}","Serral.:  #{vserralheria}","Telhado: #{ vtelhado}","Outros: #{voutros}",])







      render :action => "estatistica_servico"
  end



  def graph_code_demanda_geral
    title = Title.new("Demanda Geral - Crianças Cadastradas: #{Crianca.total_demanda.length}")
    pie = Pie.new
    pie.start_angle = 0
    pie.animate = true
    pie.tooltip = '#val# of #total#<br>#percent# of 100%'
    pie.colours = ["#d01f3c", "#356aa0", "#C79810"]
    pie.values  = [PieValue.new(Crianca.matriculada.length,"Crianças Matriculadas"),
                   PieValue.new(Crianca.matriculada.length,"Crianças Não Matriculadas"),
                   PieValue.new(Crianca.cacnelada.length,"Inscrição Cancelada")
                   ]
    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)
    chart.x_axis = nil
    render :text => chart.to_s
  end

  def estatistica_unidade

  end


  def grafico_unidade    #graph_por_unidade
    unidade = params[:unidade]
    title = Title.new("Manutenção Unidade: #{Mmanutencao.nome_unidade(unidade)} - Solicitações: #{Mmanutencao.por_unidade(unidade).length}" )
    pie = Pie.new
    pie.start_angle = 0
    pie.animate = true
    pie.tooltip = '#val# of #total#<br>#percent# of 100%'
    pie.colours = ["#d01f3c", "#356aa0", "#C79810"]
    abertos = Mmanuntencao.aberto_unidade(unidade)
    encerrados = Mmanuntencao.encerrado_unidade(unidade)
    pie.values  = [PieValue.new(aberto_geral.length,"Solicitações ABERTAS na unidade: " + (aberto_geral.length).to_s), PieValue.new(encerrado_geral.length,"Crianças Não Matriculadas: " + (nao_matriculada.length).to_s)]
    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)
    chart.x_axis = nil
    render :text => chart.to_s
  end


  def pie_chart poll
    @pie_chart ||= {
      :data => poll.choices.collect(&:votes_count),
      :colors => poll.choices.collect {|c| c.winner? ? "264409" : "8A1F11" }
    }
  end


protected

  def load_unidades
       @unidades = Unidade.find(:all, :order => 'nome ASC')
       @servicos = TiposManutencao.find(:all, :order => 'servico ASC')
  
    $uni=1
    $menu=0
  end
end
