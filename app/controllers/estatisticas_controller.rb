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


  def grafico_demanda_unidade

  end

  def search
    $uni=0
    $menu=1
    session[:input] = params[:contact][:grafico_id]
    @graph = open_flash_chart_object(600,300,"/estatistica/grafico_por_unidade?unidade=#{session[:input]}",false,'/')

    vencerrado= (Mmanutencao.encerrado_unidade(session[:input])).length
    vaberto = (Mmanutencao.aberto_unidade(session[:input])).length
    vtotal= Mmanutencao.geral.length
    pe = (vencerrado.to_f/vtotal.to_f)*100
    pa = (vaberto.to_f/vtotal.to_f)*100
    pr = (vtotal.to_f-vencerrado.to_f-vaberto.to_f)/vtotal.to_f * 100
    @static_graph = Gchart.pie_3d(
        :data => [vaberto,vencerrado, (vtotal-vencerrado-vaberto)/3],
        :title => "Manuntenção por Unidade: #{Mmanutencao.nome_unidade(session[:input])} - #{(Mmanutencao.por_unidade(session[:input]) ).length} - de um total #{vtotal} chamados " ,
        :size => '600x300',
        :format => 'image_tag',
        :labels => ["Abertas:  #{vaberto}", "Encerradas:  #{vencerrado}", "Total: #{(vtotal-vencerrado-vaberto)}",])
        

   @static_graph2 = Gchart.pie_3d(
        :data => [vaberto,vencerrado],
        :title => "Manuntenção por Unidade: #{Mmanutencao.nome_unidade(session[:input])} - #{(Mmanutencao.por_unidade(session[:input])).length}" ,
        :size => '600x300',
        :format => 'image_tag',
        :labels => ["Abertas:  #{vaberto}", "Encerradas:  #{vencerrado}", ])


      render :action => "estatistica_unidade"
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
  
    $uni=1
    $menu=0
  end
end
