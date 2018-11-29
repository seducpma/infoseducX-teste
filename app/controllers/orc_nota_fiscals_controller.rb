class OrcNotaFiscalsController < ApplicationController
    # GET /orc_nota_fiscals
    # GET /orc_nota_fiscals.xml


    before_filter :load_iniciais

    def load_iniciais
        #@pedidos_compra = OrcPedidoCompra.all(:order => 'codigo ASC')
        @empenhos = OrcEmpenho.all(:conditions => ["date_format(data_chegou,'%Y') = ?", Time.now.year],:order => 'codigo DESC')
        @fichas_emp = OrcFicha.all(:conditions => ["ano = ?", Time.now.year], :order => 'ficha ASC')
        #@fichas = OrcEmpenho.find_by_sql("SELECT DISTINCT (fc.ficha) as ficha, emp.orc_pedido_compra_id, fc.id FROM orc_empenhos emp INNER JOIN orc_pedido_compras pc ON emp.orc_pedido_compra_id = pc.id INNER JOIN orc_fichas fc ON pc.orc_ficha_id = fc.id WHERE (fc.ano = "+(Time.now.year).to_s+" AND emp.id !=1 ) ORDER BY fc.ficha ASC")

        #@orcamentarias= OrcUniOrcamentaria.find(:all, :conditions => ["ano = ?", Time.now.year])
        #  @orc_pedido_ano= OrcPedidoCompra.find(:all, :select => 'distinct(ano)')
    end



    def index
        @orc_nota_fiscals = OrcNotaFiscal.all

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @orc_nota_fiscals }
        end
    end

    # GET /orc_nota_fiscals/1
    # GET /orc_nota_fiscals/1.xml
    def show
        @orc_nota_fiscal = OrcNotaFiscal.find(params[:id])
        id_ficha= @orc_nota_fiscal.orc_empenho.ficha_id
        @ficha = OrcFicha.find(:all, :conditions=> ['id = ?', id_ficha])
        @orc_nota_fiscal_itens= OrcNotaFiscalIten.find(:all, :conditions => ['orc_nota_fiscal_id=?', @orc_nota_fiscal.id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @orc_nota_fiscal }
        end
    end

    # GET /orc_nota_fiscals/new
    # GET /orc_nota_fiscals/new.xml
    def new
        @orc_nota_fiscal = OrcNotaFiscal.new


        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @orc_nota_fiscal }
        end
    end

    # GET /orc_nota_fiscals/1/edit
    def edit
        @orc_nota_fiscal = OrcNotaFiscal.find(params[:id])
    
        session[:empenho_id]=@orc_nota_fiscal.orc_empenho_id
        @orc_nota_fiscal_itens = OrcNotaFiscalIten.find(:all, :conditions => ['orc_nota_fiscal_id =? ',@orc_nota_fiscal.id ])
        session[:orc_nota_fiscal_itens] = OrcNotaFiscalIten.find_by_sql("SELECT *,quantidade as qtde_ant, 0 as alterado FROM orc_nota_fiscal_itens WHERE orc_nota_fiscal_id="+(@orc_nota_fiscal.id).to_s)

        session[:edita_item]=1

        session[:news_itens]= @orc_nota_fiscal.id
        #session[:edita_item]=0
    end

    def itens_na_nota_fiscal
        @orc_nota_fiscal = OrcNotaFiscal.find(params[:id])
        session[:empenho_id]=@orc_nota_fiscal.orc_empenho_id
        @orc_nota_fiscal_itens = OrcNotaFiscalIten.find(:all, :conditions => ['orc_nota_fiscal_id =? ',@orc_nota_fiscal.id ])
       
        session[:edita_item]=0
        

        #session[:news_itens]= @orc_nota_fiscal.id
        #session[:edita_item]=0
    end


    # POST /orc_nota_fiscals
    # POST /orc_nota_fiscals.xml
    def create
        session[:altera_saldo_edicao_nfitem]= 0
        session[:edita_item]=0
        session[:quantidade]=0
        @orc_nota_fiscal = OrcNotaFiscal.new(params[:orc_nota_fiscal])

        respond_to do |format|
            if @orc_nota_fiscal.save
                session[:news_itens]= @orc_nota_fiscal.id
                nota_fiscal=@orc_nota_fiscal.id
                @nota_fiscal = OrcNotaFiscal.find(:all, :conditions =>['id=?',nota_fiscal])
                if  session[:sem_emp]==1
                    @itens_empenho = OrcEmpenhoIten.find(:all, :conditions => ["orc_empenho_id =?" , session[:empenho_id]])
                    for item_nf in @itens_empenho
                        valor_item=item_nf.total
                        session[:create_new_itens]=1
                        @orc_nota_fiscal_item = OrcNotaFiscalIten.new(params[nota_fiscal])
                        @orc_nota_fiscal_item.orc_nota_fiscal_id = nota_fiscal
                        @orc_nota_fiscal_item.quantidade = nil
                        @orc_nota_fiscal_item.descricao = item_nf.descricao
                        @orc_nota_fiscal_item.unitario = item_nf.unitario
                        #@orc_nota_fiscal_item.total = item_nf.total
                        @orc_nota_fiscal_item.total = 0
                        #session[:valor_total]= @orc_nota_fiscal_item.total_geral = item_nf.total_geral
                        session[:valor_total]= 0
                        # item_nf.saldo = item_nf.quantidade - @orc_nota_fiscal_item.quantidade
                        # item_nf.saldo = item_nf.saldo - @orc_nota_fiscal_item.quantidade
                        @orc_nota_fiscal_item.save
                        # salva items nota_fiscal
                        @orc_nota_fiscal.valor= session[:valor_total]
                        @orc_nota_fiscal.save
                        item_nf.save
                    end

                    #session[:emp_id]= @empenho[0].id
                    session[:sem_emp]= 0
                end
                flash[:notice] = 'SALVO COM SUCESSO..'
                format.html { redirect_to( {:action => "itens_na_nota_fiscal", :id =>@nota_fiscal[0].id} ) }
                #format.xml  { render :xml => @nota_fiscal, :status => :created, :location => @nota_fiscal }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @orc_nota_fiscal.errors, :status => :unprocessable_entity }
            end
        end
    end

    # PUT /orc_nota_fiscals/1
    # PUT /orc_nota_fiscals/1.xml
    def update
        @orc_nota_fiscal = OrcNotaFiscal.find(params[:id])
        @orc_nota_fiscal.nf

        respond_to do |format|
            if @orc_nota_fiscal.update_attributes(params[:orc_nota_fiscal])
                @orc_nota_fiscal_item = OrcNotaFiscalIten.find(:all, :conditions => ['orc_nota_fiscal_id =?',@orc_nota_fiscal.id])
            end
            id_empenho=@orc_nota_fiscal.orc_empenho_id
            if  session[:sem_emp]==1
                # ALTERAR EMPENHO
                valor_total=0
                # @orc_nota_fiscal_item = OrcNotaFiscalIten.find(:all, :conditions => ['orc_nota_fiscal_id = ?',@orc_nota_fiscal.id])
                @itens_empenho = OrcEmpenhoIten.find(:all, :conditions => ["orc_empenho_id =? " , session[:empenho_id],])
                for item_nf in @orc_nota_fiscal_item
                    #valor_item= item_nf.total
                    #valor_total= item_nf.total + valor_total
                    if !item_nf.quantidade.nil?
                        for item_em in @itens_empenho
                            if item_em.descricao == item_nf.descricao
                                #item_em.saldo = item_em.saldo - item_nf.quantidade # + session[:quantidade]
                                item_em.saldo = item_em.saldo - item_nf.quantidade
                                item_nf.total = item_nf.quantidade * item_nf.unitario
                                valor_total = valor_total + item_nf.total
                                session[:quantidade]=0
                            end
                            item_em.save
                        end
                        item_nf.total_geral=valor_total
                        t0=0
                        #@orc_nota_fiscal_item[0].save
                        #end
                        # salva items nota_fiscal
                        item_nf.save
                    end
                end
                @orc_nota_fiscal.valor=valor_total
                @orc_nota_fiscal.save

                session[:sem_emp] =0
                #session[:emp_id]= @empenho[0].id

                #>>>>>>
                total_geral= 0
                for item in  @orc_nota_fiscal_item
                    if (item.quantidade.nil? or item.quantidade==0)
                        item.destroy
                    else
                        total_geral= total_geral + item.total
                        item.total_geral = total_geral
                        #@orc_nota_fiscal.valor=total_geral
                        item.save
                    end
                end
                @orc_nota_fiscal.valor=total_geral
                #              if params[:cancela].to_i == 1
                #                    @orc_pedido_compra.cancelado=1
                #              end
                #      <<<<<<<<<<<<<<<<<<<

                @empenho = OrcEmpenho.find(:all, :conditions=>['id =?',  @orc_nota_fiscal.orc_empenho_id])

                @orc_nota_fiscal_item = OrcNotaFiscalIten.find(:all, :conditions => ['orc_nota_fiscal_id = ?',@orc_nota_fiscal.id])

                #Inicio - ###Alex 05/11/2018 - Acho que as linhas abaixo não estão mais em uso pois não há nota fiscal sem empenho
                if !@orc_nota_fiscal.orc_empenho_id?
                    for item_nf in @orc_nota_fiscal_item
                        @itens_empenho = OrcEmpenhoIten.find(item_nf.orc_empenho_item_id)
                        saldo_anterior= @itens_empenho.saldo
                        quantidade= item_nf.quantidade
                        saldo_atualizado=saldo_anterior-quantidade
                        @itens_empenho.saldo=saldo_atualizado
                        #item_nf.saldo=saldo_atualizado ###Alex 05/11/18 - Não existe campo saldo no @orc_nota_fical_item???
                        @itens_empenho.save
                        item_nf.save
                    end
                end
                #Fim - ###Alex 05/11/2018 - Acho que as linhas acima não estão mais em uso pois não há nota fiscal sem empenho

            end
            flash[:notice] = 'SALVO COM SUCESSO..'
            format.html { redirect_to(@orc_nota_fiscal) }
            format.xml  { head :ok }

        end
    end


    # DELETE /orc_nota_fiscals/1
    # DELETE /orc_nota_fiscals/1.xml
    def destroy
        @orc_nota_fiscal = OrcNotaFiscal.find(params[:id])
        
        @orc_nota_fiscal_item = OrcNotaFiscalIten.find(:all, :conditions => ['orc_nota_fiscal_id = ?',@orc_nota_fiscal.id])
        @itens_empenho = OrcEmpenhoIten.find(:all, :conditions => ["orc_empenho_id =? " , @orc_nota_fiscal.orc_empenho_id,])
        for item_nf in @orc_nota_fiscal_item
            valor_item=item_nf.total
            session[:valor_total]= item_nf.total_geral = item_nf.total_geral



            for item_em in @itens_empenho
                if item_em.descricao == item_nf.descricao
                    if !item_nf.quantidade.nil?
                        nf_item=item_nf.quantidade
                    else
                        nf_item=0
                    end
                    item_em.saldo
                    item_em.saldo = item_em.saldo + nf_item

                end
                item_em.save
            end
            @orc_nota_fiscal_item[0].save
            @orc_nota_fiscal.destroy
        end


        respond_to do |format|
            format.html { redirect_to(home_path) }
            format.xml  { head :ok }
        end
    end

    def create_orc_nota_fiscal_item
        session[:create_new_itens]=1
        @orc_nota_fiscal_item = OrcNotaFiscalIten.new(params[:orc_nota_fiscal_item])
        valor_item= @orc_nota_fiscal_item.total
        @orc_nota_fiscal_item.orc_nota_fiscal_id = session[:news_itens]
        # salva items do empenho
        if @orc_nota_fiscal_item.save
            #altera saldo empenho_iten
            quantidade_acrescentar= @orc_nota_fiscal_item.quantidade.to_f
            #            @empenho = OrcEmpenho.find(:all, :joins => "INNER JOIN orc_nota_fiscals ON orc_empenhos.id = orc_nota_fiscals.orc_empenho_id INNER JOIN orc_nota_fiscal_itens ON orc_nota_fiscals.id = orc_nota_fiscal_itens.orc_nota_fiscal_id ", :conditions => ["orc_nota_fiscal_itens.id =?", @orc_nota_fiscal_item.id])
            #            empenho = empenho_id= @empenho[0].id
            #            @empenho_iten= OrcEmpenhoIten.find(:all, :conditions => ['descricao=? and orc_empenho_id=?',@orc_nota_fiscal_item.descricao , empenho])
            #            empenho_id= @empenho_iten[0].id
            #            saldo_atual= @empenho_iten[0].saldo.to_f
            #            @empenho_iten[0].saldo = saldo_atual.to_f - quantidade_acrescentar.to_f
            #            @empenho_iten[0].save
            @orc_nota_fiscal_itens=OrcNotaFiscalIten.find(:all, :conditions =>['orc_nota_fiscal_id =?', session[:news_itens]])
            for item in @orc_nota_fiscal_itens
                session[:soma]=session[:soma].to_f+item.total.to_f
                item.total_geral=session[:soma].to_f
                session[:valor_total] = item.total_geralitem_nota_fiscal_id = item.orc_nota_fiscal_id
                item.save
                item_nota_fiscal_id = item.orc_nota_fiscal_id
                item.save
            end
            # salva valor_total no empenho
            @orc_nota_fiscal= OrcNotaFiscal.find(item_nota_fiscal_id)
            @orc_nota_fiscal.valor= session[:valor_total]
            @orc_nota_fiscal.save
        end
        render :update do |page|
            page.replace_html 'dados', :partial => "orc_nota_fiscal_itens"
            page.replace_html 'new'
        end
       
    end

    def destroy_nf_itens
        @orc_nota_fiscal_iten = OrcNotaFiscalIten.find(params[:id])
        session[:id_nota_fiscal]= @orc_nota_fiscal_iten.orc_nota_fiscal_id
        if session[:altera_saldo_edicao_nfitem]==1
            #altera saldo empenho_iten
            quantidade_diminuir = @orc_nota_fiscal_iten.quantidade.to_f
            #            @empenho = OrcEmpenho.find(:all, :joins => "INNER JOIN orc_nota_fiscals ON orc_empenhos.id = orc_nota_fiscals.orc_empenho_id INNER JOIN orc_nota_fiscal_itens ON orc_nota_fiscals.id = orc_nota_fiscal_itens.orc_nota_fiscal_id ", :conditions => ["orc_nota_fiscal_itens.id =?", @orc_nota_fiscal_iten.id])
            #            empenho = empenho_id= @empenho[0].id
            #            @empenho_iten= OrcEmpenhoIten.find(:all, :conditions => ['descricao=? and orc_empenho_id=?',@orc_nota_fiscal_iten.descricao , empenho])
            #            empenho_id= @empenho_iten[0].id
            #            saldo_atual= @empenho_iten[0].saldo.to_f
            #            @empenho_iten[0].saldo = saldo_atual.to_f + quantidade_diminuir.to_f
            #            @empenho_iten[0].save
            #            session[:altera_saldo_edicao_nfitem]= 0
        end
        @orc_nota_fiscal_iten.destroy
        @orc_nota_fiscal_itens=OrcNotaFiscalIten.find(:all, :conditions =>['orc_nota_fiscal_id =?', session[:id_nota_fiscal] ])
        for item in @orc_nota_fiscal_itens
            session[:soma]=session[:soma].to_f+item.total.to_f
            item.total_geral=session[:soma].to_f
            item.save
        end
        @nota_fiscal = OrcNotaFiscal.find(:all, :conditions => ['id = ?', session[:id_nota_fiscal]])
        @nota_fiscal[0].valor = session[:soma].to_f
        @nota_fiscal[0].save
        respond_to do |format|

            flash[:notice] = 'ALTERADO COM SUCESSO.'
            if session[:edita_item] == 0
                format.html { redirect_to( {:action => "itens_na_nota_fiscal", :id => @nota_fiscal[0].id} ) }
            else
                format.html { redirect_to( {:action => "edit", :id => @nota_fiscal[0].id} ) }
            end
            format.html { redirect_to( @nota_fiscal) }
            format.xml  { render :xml =>  @nota_fiscal, :status => :created, :location =>  @nota_fiscal }
        end
    end




    def edit_orc_nota_fiscal_item

        @orc_nota_fiscal = OrcNotaFiscal.find(params[:id])
        @orc_nota_fiscal_itens = OrcNotaFiscalIten.find(:all, :conditions => ['orc_nota_fiscal_id =? ',@orc_nota_fiscal.id ])


    end


    def consulta_nf
        if params[:type_of].to_i == 1   #fornecedor
            @nota_fiscals = OrcNotaFiscal.find(:all, :joins => [:orc_empenho],:conditions => [' orc_empenhos.interessado like ?', "%" + params[:search_fornecedor_nf].to_s + "%"], :order => 'id DESC')
            render :update do |page|
                page.replace_html 'notafiscal', :partial => "notas_fiscais"
            end
        else  if params[:type_of].to_i == 2   #nf
                @nota_fiscals = OrcNotaFiscal.find(:all,:conditions => ['nf like ?', "%" + params[:search_nota_fiscal].to_s + "%"], :order => 'id DESC')
                render :update do |page|
                    page.replace_html 'notafiscal', :partial => "notas_fiscais"
                end
            else if params[:type_of].to_i == 3   #empenho

                    @nota_fiscals = OrcNotaFiscal.find(:all, :joins => 'INNER JOIN orc_empenhos ON orc_empenhos.id = orc_nota_fiscals.orc_empenho_id' ,:conditions => [' orc_empenhos.codigo like ?', "%" + params[:search_empenho_nf].to_s + "%"], :order => 'id DESC')
                    render :update do |page|
                        page.replace_html 'notafiscal', :partial => "notas_fiscais"
                    end
                else if params[:type_of].to_i == 4   #todas
                        @nota_fiscals = OrcNotaFiscal.find(:all,:conditions =>["date_format(created_at,'%Y') = ?", Time.now.year])
                        render :update do |page|
                            page.replace_html 'notafiscal', :partial => "notas_fiscais"
                        end
                    else if params[:type_of].to_i == 5   #dia
                            session[:dataI]=params[:nota_fiscal][:dataI][6,4]+'-'+params[:nota_fiscal][:dataI][3,2]+'-'+params[:nota_fiscal][:dataI][0,2]
                            session[:dataF]=params[:nota_fiscal][:dataF][6,4]+'-'+params[:nota_fiscal][:dataF][3,2]+'-'+params[:nota_fiscal][:dataF][0,2]
                            session[:mes]=params[:nota_fiscal][:dataF][3,2]
                            @nota_fiscals = OrcNotaFiscal.find_by_sql("SELECT * FROM orc_nota_fiscals WHERE (data_nf BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"') GROUP BY id ORDER BY data_nf DESC")
                            render :update do |page|
                                page.replace_html 'notafiscal', :partial => "notas_fiscais"
                            end
                        end
                    end
                end
            end
        end
    end

    def dados_empenho
        session[:empenho_id] = params[:orc_nota_fiscal_orc_empenho_id]
        @orc_empenho=  OrcEmpenho.find(:all, :conditions => ['id = ?',params[:orc_nota_fiscal_orc_empenho_id]])
        session[:sem_emp]=1
        render :partial => "empenho"
    end

    def ja_existe
        if OrcNotaFiscal.find_by_nf(params[:orc_nota_fiscal_nf]) then
            render :partial => "ja_existe"

        else
            render :nothing => true
        end
    end

end
