<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	
<style>
.modal-carrinho {
	position: fixed;
    right: 0px;
    width: 400px;
    padding: 10px;
}
.modal-header {
	background: #337ab7;
	color: white;
}
#ModalTeste .modal-body{
    height: 200px;
    overflow-y: auto;
}
input[type=number] {
	width: 60px;
}
input[type=number]::-webkit-inner-spin-button {
    opacity: 1;
    width: 60px;
}
footer {
    position: fixed;
    bottom: 0;
    width: 80%;
    text-align: center;
}

.div-carrinho > input, li {
  display: inline;  
  list-style-type: none;
  margin: 10px;
}

.div-carrinho > .glyphicon-trash {
	float: right;
	top: 20px;
}
.div-carrinho {
	margin-bottom: 5px;
	margin-left: -40;
}

	#lightbox .modal-content {
	    display: inline-block;
	    text-align: center;   
	}
	
	#lightbox .close {
	    opacity: 1;
	    color: rgb(255, 255, 255);
	    background-color: rgb(25, 25, 25);
	    padding: 5px 8px;
	    border-radius: 30px;
	    border: 2px solid rgb(255, 255, 255);
	    position: absolute;
	    top: -15px;
	    right: -55px;
	    
	    z-index:1032;
	}
	
	
	div.table-title {
   display: block;
  margin: auto;
  max-width: 600px;
  padding:5px;
  width: 100%;
}

.table-fill {
  background: white;
  border-radius:3px;
  border-collapse: collapse;
  height: 220px;
  margin: auto;
  max-width: 1000px;
  padding:5px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
  animation: float 5s infinite;
}
 
th {
  color:#fff;
  background:#337ab7;
  border-bottom:4px solid #9ea7af;
  border-right: 1px solid #343a45;
  font-size:16px;
  font-weight: 100;
  padding:14px;
  text-align:left;
  text-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
  vertical-align:middle;
}

th:first-child {
  border-top-left-radius:3px;
}
 
th:last-child {
  border-top-right-radius:3px;
}
  
tr {
  border-top: 1px solid #C1C3D1;
  border-bottom-: 1px solid #C1C3D1;
  color:#666B85;
  font-size:16px;
  font-weight:normal;
  text-shadow: 0 1px 1px rgba(256, 256, 256, 0.1);
}
 
tr:hover td {
  background:#4E5066;
  color:#FFFFFF;
  border-top: 1px solid #22262e;
}
 
tr:first-child {
  border-top:none;
}

tr:last-child {
  border-bottom:none;
}
 
tr:nth-child(odd):hover td {
  background:#4E5066;
}

tr:last-child td:first-child {
  border-bottom-left-radius:3px;
}
 
tr:last-child td:last-child {
  border-bottom-right-radius:3px;
}
 
td {
  background:#FFFFFF;
  padding:20px;
  text-align:left;
  vertical-align:middle;
  font-weight:300;
  font-size:18px;
  text-shadow: -1px -1px 1px rgba(0, 0, 0, 0.1);
  border-right: 1px solid #C1C3D1;
}

td:last-child {
  border-right: 0px;
}

th.text-left {
  text-align: left;
}

th.text-center {
  text-align: center;
}

th.text-right {
  text-align: right;
}

td.text-left {
  text-align: left;
}

td.text-center {
  text-align: center;
}

td.text-right {
  text-align: right;
}

table {
  width:500px;
  margin: 10px auto;
}
	
	
</style>	

<title>Lista de Produtos</title>

</head>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" >FarmaWeb</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
       <form class="navbar-form navbar-left">
	   	    <div class="form-group">
	          <input type="text" class="form-control"  onkeyup="filtrar()" id="filtro" placeholder="Procurar produto"/>	
	        </div>
      </form>
    
	 <ul class="nav navbar-nav navbar-right">
   	  	<form class="form-signin navbar-form" action="/FarmaWeb/voltar" method="POST">
  		   <button type="submit" class="btn btn-default">Voltar</button>	
           <button type="button" class="btn btn-default" data-toggle="modal" data-target="#sair">Sair</button>
        </form>
     </ul>
    </div>
  </div>
</nav>

<div class="modal fade" id="sair" role="dialog">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Deseja realmente sair ?</h4>
			</div>
			<div class="modal-footer">
				<form class="bottom-left" action="/FarmaWeb/logout" method="POST">
					<button class="btn btn-lg btn-primary btn-block" type="submit">Sim</button>
				</form>
			</div>
		</div>
	</div>
</div>


<body>
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.ProdutoDao" />
	<jsp:useBean id="daoFormaDePagamento" class="br.com.farmaweb.daos.FormaDePagamentoDao" />
	<div class="row">
		<div class="col-xs-6">
			<table class="table-fill" id="myTable">
			<thead>
				<tr>
					<th>Foto</th>
					<th>Produto</th>
					<th>Informações</th>
					<th>Preço</th>
					<th>Desconto</th>
					<th>Receita</th>
					<th></th>
				</thead>
				</tr>
				<c:forEach var="produto" items="${dao.listaProdutoFarmacia(cod_farmacia)}">
					<tr>
						<td>
							<a href="#" data-toggle="modal" data-target="#lightbox">
								<img src="/FarmaWeb/recuperaImagem?cod_produto=${produto.cod_produto}&cod_farmacia=${cod_farmacia}" width="100" height="100"/>
							</a>
						</td>
						<td id="nome_produto${produto.cod_produto}">${produto.nome_produto}</td>
						<td>${produto.marca_fabricante}<br>${produto.descricao_produto}<br>${produto.caracteristica}</td>
						<td id="preco_unitario${produto.cod_produto}">${produto.preco_unitario}</td>
						<td id="desconto${produto.cod_produto}">${produto.desconto}</td>
						<c:choose>
					   		<c:when test="${produto.receita == 1}">
					      		<td>Sim</td>
					    	</c:when>    
					    	<c:otherwise>
					      		<td>Não</td> 
					    	</c:otherwise>
						</c:choose>
						<td><a class="btn btn-primary adicionar" data-toggle="modal" data-id="${produto.cod_produto}">Adicionar</a></td>
						<input type="hidden" id="cod_produto${produto.cod_produto}">
					</tr>
				</c:forEach>
			</table>
		</div>
		
		
		<footer>
			<div class="alert  alert-danger" style="display:none;">
	  			<strong>Atenção!</strong> Produto já adicionado no carrinho.
			</div>
		</footer>
		
		<footer>
			<div id="alerta-quantidade" class="alert  alert-danger" style="display:none;">
	  			<strong>Atenção!</strong> 
			</div>
		</footer>

		<div id="ModalTeste" class="col-xs-6">
			<div class="modal-carrinho">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title"><span class="glyphicon glyphicon-shopping-cart"></span> Carrinho </h4>
					</div>
					 <div class="modal-body">	 	
	       				<ul class="lista">
						</ul>
      				</div>
	      				<div class="modal-footer">
	      				
	      					<label>Desconto Total: R$<strong class="descontoTotal">0</strong></label>
	      					<p>
	      					<label>Taxa de Entrega: R$<strong class="taxaEntrega">${taxa_entrega}</strong></label>
	      					<p>				
	      					<label>Valor Total: R$<strong class="valorTotal">${taxa_entrega}</strong></label>
	      					<p>
	      					<label>Tempo Estimado de Entrega: <strong class="tempoEntrega">${tempo_entrega}</strong></label>
	      					<input type="hidden" name="cod_farmacia" class=codFarmacia value="${cod_farmacia}" />
							<div><button type="button" id="enviar-pedido" class="btn btn-primary" data-toggle="modal" data-target="#modalPagamento">Enviar Pedido</button></div>
						
						</div>
				</div>
			</div>
		</div>
		
		<div id="lightbox" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <button type="button" class="close hidden" data-dismiss="modal" aria-hidden="true">×</button>
	        <div class="modal-content">
	            <div class="modal-body">
	                <img src="" alt="" />
	            </div>
	        </div>
	    </div>
		</div>
		
	</div>


	<div id="modalPagamento" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Selecione a forma de pagamento</h4>
				</div>
				<div class="modal-body">
						<div class="form-group">

							<label for="tipo_pagamento">Tipo De Pagamento:</label>
								
							<select id="cod_pagamento" class="selectpicker" >
							    <c:forEach var="forma" items="${daoFormaDePagamento.getPagamentosPedido(cod_farmacia)}">
							        <option  value="${forma.cod_pagamento}">
							            ${forma.tipo_pagamento}
							        </option>
							    </c:forEach> 
							</select>
							
							<input type="hidden" name="cod_login" value="${usuarioLogado.cod_login}" />
						</div>
						<div class="modal-footer">
							<div><button type="button" id="botaoSelecionar" class="btn btn-primary" data-toggle="modal" data-target="#modalResumo">Selecionar</button></div>
						</div>
				</div>
			</div>
		</div>
	</div>

	<div id="modalResumo" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Resumo do Pedido</h4>
				</div>
				<div class="modal-body">
					<form class="form-signin" action="/FarmaWeb/incluirPedido" method="POST" enctype="multipart/form-data">
						<div class="form-group" id="resumo">
						
						</div>
						<div class="modal-footer">
							<button class="btn btn-default" type="submit">Concluir</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		
		var cod_pagamento = 0;
		var forma_pagamento = '';
		var valorMap = new Map();
		var valorDesconto = new Map();
		
		$(".adicionar").on('click', function(){

			var id = $(this).data('id');
			var nome = $('#nome_produto' + id).text();
			var preco = $('#preco_unitario' + id).text();
			var desconto = $('#desconto' + id).text();
				
			valorMap.set(nome, parseFloat(preco));
			valorDesconto.set(nome, parseFloat(preco * desconto/100));
			
			somaDesconto(valorDesconto);
			somaValores(valorMap);
			
			if(document.getElementById(id) != null){
				if(id === parseInt(document.getElementById(id).getAttribute("id"))){
					$('.alert').fadeIn();
					$('.alert').fadeOut(5000);
					return;
				}
			}
			

			$( ".lista" ).append(
				'<div class="div-carrinho" id='+ id +'><input type="number" name="quantidadeCarrinho" id="quantidade" class="form-control text-center" onKeyPress="if(this.value.length==2) return false;" value="1" min="1" max="99">'
				+ '<li class="nome" name=nome value=' + nome + '>' + nome + '</li>' 
				+ '<input type=hidden name=produtoCarrinho value=' + nome + '>'
				+ '<li class="valor" value='+ preco +'>'+ preco +'</li>' 
				+ '<li class="hidden" name="id" value='+ id +'>'+ id +'</li>'
				+ '<input type=hidden name="cod_produto_carrinho" value='+ id +'>'
				+ '<span class="glyphicon glyphicon-trash"></span> <input type="hidden" class="valorUnitario" value='+preco+' > <input type="hidden" class="valorDesconto" value='+desconto+' ></div>');
			
			$('input[type="number"]').bind('click keyup', function (e){
				var quantidade = $(this).val();
				var valorUnitario = $(this).siblings(".valorUnitario").val();
				var subTotal = (parseFloat(valorUnitario) * quantidade);
				var nome = $(this).siblings(".nome").text();
				$(this).siblings('.valor').text(subTotal).val(subTotal);
				
				var desconto_total =  subTotal * parseFloat($(this).siblings(".valorDesconto").val())/100;
				
				if(valorMap.has(nome)){
					valorMap.set(nome, subTotal)
				}
				
				if(valorDesconto.has(nome)){
					valorDesconto.set(nome, desconto_total)
				}
				
				somaDesconto(valorDesconto);
				somaValores(valorMap);
			});

			
			$('.glyphicon-trash').unbind("click").click(function (){
				var nome = $(this).siblings(".nome").text();
				valorMap.delete(nome);
				var valor = parseFloat(parseFloat($('.valorTotal').text()) + valorDesconto.get(nome)) - parseFloat($(this).siblings(".valor").text());
				valorDesconto.delete(nome);
				somaDesconto(valorDesconto);
				$('.valorTotal').text(valor.toFixed(2));
				$(this).parent().remove();
			});		
		});	
		
		function somaValores(valorTotal){
			var valorCalculado = 0.0;
			valorTotal.forEach(function (e) { 
				valorCalculado += e; 
			});
			$('.valorTotal').text((valorCalculado - parseFloat($('.descontoTotal').text()) + parseFloat($('.taxaEntrega').text())).toFixed(2));
		}
		
		function somaDesconto(valorTotal){
			var valorCalculado = 0.0;
			valorTotal.forEach(function (e) { 
				valorCalculado += e; 
			});
			$('.descontoTotal').text(valorCalculado.toFixed(2)).val(valorCalculado.toFixed(2));
		}
	
		$('#botaoSelecionar').click(function (){
			cod_pagamento = $("#cod_pagamento option:selected").val();
			forma_pagamento = $("#cod_pagamento option:selected").text().trim();
			
			var resumo = [];
			$('.lista div').each(function(){
			   resumo.push({
				   quantidade: $(this).children('#quantidade').val(),
				   nome: $(this).children('.nome').text(),
				   valor: $(this).children('.valor').text(),
				   id_produto: $(this).children('.hidden').text()
				});
			});
			
			$( "#resumo" ).append(
				'<div>Lista de Produtos</div>'
			);
			
			resumo.forEach(function(produtos){
			    $('#resumo').append('<div>'+ produtos.quantidade +' '+ produtos.nome +' '+ produtos.valor + '</div>' +
			    		'<input type=hidden value = '+ produtos.quantidade +' name=quantidade_produto>' +
			    		'<input type=hidden value = '+ produtos.id_produto +' name=id_produto>'
			    );
			});
			
			$( "#resumo" ).append(
				'<div>---------------------------------------------------------</div>' +
				'<div>Endereço de Entrega</div>' +
				'<input type=hidden value = ${cod_endereco} name=cod_endereco>'+
				'<input type=hidden value = ${cod_cliente} name=cod_cliente>' +
				'<input type=hidden value = ${rua_cliente}>${rua_cliente}, <input type=hidden value = ${numero_cliente}>${numero_cliente} - <input type=hidden value = ${complemento_cliente}>${complemento_cliente}' +
				'<br>' +
				'<input type=hidden value = ${cep_cliente}>${cep_cliente} - <input type=hidden value = ${bairro_cliente}>${bairro_cliente}' +
				'<br>' +
				'<input type=hidden value = ${cidade_cliente}>${cidade_cliente}/<input type=hidden value = ${estado_cliente}>${estado_cliente}' +
				'<div>---------------------------------------------------------</div>' +
				'<div>Informações Adicionais</div>' +
				'<input type=hidden value=' + cod_pagamento + ' name=cod_pagamento>'+
				'<div value = ' + forma_pagamento + '>Forma de Pagamento: ' + forma_pagamento + '</div>' +
				'<input type=hidden name=descontoTotal value = ' + $('.descontoTotal').text() + '>' +
				'<div name=descontoTotal value = ' + $('.descontoTotal').text() + '>Desconto Total: ' + $('.descontoTotal').text() + '</div>' +
				'<div value = ' + $('.taxaEntrega').text() + '>Taxa de Entrega: ' + $('.taxaEntrega').text() + '</div>' +
				'<input type=hidden name=valorTotal value = ' + $('.valorTotal').text() + '>' +
				'<input type=hidden name=cod_farmacia value = ' + $('.codFarmacia').val() + '>' +
				'<div name=valorTotal value = ' + $('.valorTotal').text() + '>Valor Total: ' + $('.valorTotal').text() + '</div>' +
				'<div value = ' + $('.tempoEntrega').text() + '>Tempo Estimado de Entrega: ' + $('.tempoEntrega').text() + '</div>' +
				'Adicionar Receita: <input type="file" name="foto_receita"/>'
			);
					
			
			$('.fade in').removeClass('modal-backdrop fade in');
			
		});
		

		function filtrar() {
			  // Declare variables 
			  var input, filter, table, tr, td, i;
			  input = document.getElementById("filtro");
			  filter = input.value.toUpperCase();
			  table = document.getElementById("myTable");
			  tr = table.getElementsByTagName("tr");

			  // Loop through all table rows, and hide those who don't match the search query
			  for (i = 0; i < tr.length; i++) {
			    td = tr[i].getElementsByTagName("td")[1];
			    if (td) {
			      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
			        tr[i].style.display = "";
			      } else {
			        tr[i].style.display = "none";
			      }
			    } 
			  }
		}
		
		$(document).ready(function() {
		    var $lightbox = $('#lightbox');
		    
		    $('[data-target="#lightbox"]').on('click', function(event) {
		        var $img = $(this).find('img'), 
		            src = $img.attr('src'),
		            alt = $img.attr('alt'),
		            css = {
		                'maxWidth': $(window).width() - 100,
		                'maxHeight': $(window).height() - 100
		            };
		    
		        $lightbox.find('.close').addClass('hidden');
		        $lightbox.find('img').attr('src', src);
		        $lightbox.find('img').attr('alt', alt);
		        $lightbox.find('img').css(css);
		    });
		    
		    $lightbox.on('shown.bs.modal', function (e) {
		        var $img = $lightbox.find('img');
		            
		        $lightbox.find('.modal-dialog').css({'width': $img.width()});
		        $lightbox.find('.close').removeClass('hidden');
		    });
		});
		
	</script>

</body>
</html>