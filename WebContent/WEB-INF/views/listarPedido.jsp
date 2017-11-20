<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<style>
	.lightbox-target {
		position: fixed;
		top: -100%;
		width: 100%;
		background: rgba(0,0,0,.7);
		width: 100%;
		opacity: 0;
		-webkit-transition: opacity .5s ease-in-out;
		-moz-transition: opacity .5s ease-in-out;
		-o-transition: opacity .5s ease-in-out;
		transition: opacity .5s ease-in-out;
		overflow: hidden;
	}
	
	.lightbox-target img {
		margin: auto;
		position: absolute;
		top: 0;
		left:0;
		right:0;
		bottom: 0;
		max-height: 0%;
		max-width: 0%;
		border: 3px solid white;
		box-shadow: 0px 0px 8px rgba(0,0,0,.3);
		box-sizing: border-box;
		-webkit-transition: .5s ease-in-out;
		-moz-transition: .5s ease-in-out;
		-o-transition: .5s ease-in-out;
		transition: .5s ease-in-out;
	}
	
	a.lightbox-close {
		display: block;
		width:50px;
		height:50px;
		box-sizing: border-box;
		background: white;
		color: black;
		text-decoration: none;
		position: absolute;
		top: -80px;
		right: 0;
		-webkit-transition: .5s ease-in-out;
		-moz-transition: .5s ease-in-out;
		-o-transition: .5s ease-in-out;
		transition: .5s ease-in-out;
	}
	
	a.lightbox-close:before {
		content: "";
		display: block;
		height: 30px;
		width: 1px;
		background: black;
		position: absolute;
		left: 26px;
		top:10px;
		-webkit-transform:rotate(45deg);
		-moz-transform:rotate(45deg);
		-o-transform:rotate(45deg);
		transform:rotate(45deg);
	}
		
	a.lightbox-close:after {
		content: "";
		display: block;
		height: 30px;
		width: 1px;
		background: black;
		position: absolute;
		left: 26px;
		top:10px;
		-webkit-transform:rotate(-45deg);
		-moz-transform:rotate(-45deg);
		-o-transform:rotate(-45deg);
		transform:rotate(-45deg);
	}

	.lightbox-target:target {
		opacity: 1;
		top: 0;
		bottom: 0;
	}
	
	.lightbox-target:target img {
		max-height: 100%;
		max-width: 100%;
	}
	
	.lightbox-target:target a.lightbox-close {
		top: 0px;
	}
</style>

<title>Pedidos</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.PedidoDao" />
	<jsp:useBean id="daoNomeFarm" class="br.com.farmaweb.daos.FarmaciaDao" />
	<strong>Procurar pelo número do pedido:</strong> <input type="text" onkeyup="filtrar()" id="filtro" />
	<table class="table table-bordered" id="myTable">
		<tr>
			<th>Número do Pedido</th>
			<c:if test="${usuarioLogado.tipo == 1}"><th>Farmácia</th></c:if>
			<th>Valor Total</th>
			<th>Valor Desconto</th>
			<th>Data Pedido</th>
			<th>Status</th>
		</tr>
		
		<c:if test="${usuarioLogado.tipo == 1}">
			<c:forEach var="pedido" items="${dao.getPedidos(usuarioLogado.cod_login)}">
				<tr>
					<td>${pedido.cod_pedido}</td>
					<c:forEach var="nomeFarm" items="${daoNomeFarm.retornaNomeFarm(pedido.cod_pedido)}">
						<c:if test="${not empty nomeFarm}">
							 <td>${nomeFarm}</td>
						</c:if>
					</c:forEach>
					<td>${pedido.valor_total}</td>
					<td>${pedido.valor_desconto}</td>
					<td>${pedido.data_pedido}</td>
					<td>
					   <c:if test="${pedido.status == 'Aberto'}">
							<span  class="btn btn-success btn-circle btn-xl"></span>
						</c:if>
						<c:if test="${pedido.status == 'Enviado'}">
							<span  class="btn btn-info btn-circle btn-xl"></span>
						</c:if>
						<c:if test="${pedido.status == 'Separação'}">
							<span  class="btn btn-warning btn-circle btn-xl"></span>
						</c:if>
						<c:if test="${pedido.status == 'Cancelado'}">
							<span  class="btn btn-danger btn-circle btn-xl"></span>
						</c:if>
						<c:if test="${pedido.status == 'Concluído'}">
							<span class="glyphicon glyphicon-ok"></span>
						</c:if>
						${pedido.status}
					</td>
					<td>
						<button type="button" id="botaoDetalhes" value="1" onclick="getDetalhes(${pedido.cod_pedido})" class="btn btn-primary" data-toggle="modal" data-target="#modalDetalhes">Detalhes do Pedido</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		
			<c:if test="${usuarioLogado.tipo == 2}">
			<c:forEach var="pedido" items="${dao.getPedidosFarmacia(usuarioLogado.cod_login)}">
				<tr>
					<td>${pedido.cod_pedido}</td>
					<td>${pedido.valor_total}</td>
					<td>${pedido.valor_desconto}</td>
					<td>${pedido.data_pedido}</td>
					<td>
						<c:if test="${pedido.status == 'Aberto'}">
							<span  class="btn btn-success btn-circle btn-xl"></span>
						</c:if>
						<c:if test="${pedido.status == 'Enviado'}">
							<span  class="btn btn-info btn-circle btn-xl"></span>
						</c:if>
						<c:if test="${pedido.status == 'Separação'}">
							<span  class="btn btn-warning btn-circle btn-xl"></span>
						</c:if>
						<c:if test="${pedido.status == 'Cancelado'}">
							<span  class="btn btn-danger btn-circle btn-xl"></span>
						</c:if>
						<c:if test="${pedido.status == 'Concluído'}">
							<span class="glyphicon glyphicon-ok"></span>
						</c:if>
						${pedido.status}
					</td>
					<td>
						<button type="button" id="botaoDetalhes"  onclick="getDetalhes(${pedido.cod_pedido})" class="btn btn-primary" data-toggle="modal" data-target="#modalDetalhes">Detalhes do Pedido</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		
	</table>
	
	<form action="/FarmaWeb/voltar" method="POST">
		<button type="submit" class="btn btn-primary">Voltar</button>
	</form>
	

	<div id="modalDetalhes" class="modal fade"    role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Detalhes do Pedido</h4>
				</div>
				<div class="modal-body">
					<div class="form-group" id="detalhes">
					</div>
					<div class="modal-footer">
					
					</div>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
	
	$('.close').click( function (){
		$('#detalhes').empty();
	});
		
	function getDetalhes(cod_pedido) {
		$.ajax({
		         type: 'GET',    
		         url:'/FarmaWeb/buscarDetalhes?cod_pedido=' + cod_pedido,
		         success: function(data){
		        	 if($('#botaoDetalhes').val() == 1){
		        		 detalhaPedido(data);  
		        	 }else{
		        		 detalhaPedidoFarmacia(data);
		        	 }
		        	 
		         }
		     });
	 }
		
		function detalhaPedido(data){
				$('#detalhes').append(
						'<div>Número do Pedido: ' + data[0].cod_pedido + '</div>' +
						'<div>' + data[0].nome_fantasia + '</div>' +
						'<div>Status do Pedido: ' + data[0].status + '</div>' +
						'<div>Data: ' + data[0].data_pedido + '</div>' +
						'<div>---------------------------------------------------------</div>' +
						'<div>Lista de Produtos</div>'
				);
				
				data.forEach( function (e){
						$('#detalhes').append('<div>'+ e.quant_prod_ped +' '+ e.nome_produto +' R$'+ e.preco_unitario + '</div>');
				});
				
				$('#detalhes').append(
						'<div>Desconto Total: ' + data[0].valor_desconto + '</div>' +
						'<div>Taxa de Entrega: ' + data[0].taxa_entrega + '</div>' +
						'<div>Valor Total: ' + data[0].valor_total + '</div>' +
						'<div>Forma de Pagamento: ' + data[0].tipo_pagamento + '</div>' +
						'<a class="lightbox" href="#receita">'+
							'<img src="/FarmaWeb/recuperaReceita?cod_pedido=' + data[0].cod_pedido + '" width="100" height="100"/>' +
						'</a>'+
						'<div class="lightbox-target" id="receita">'+
					   		'<img src="/FarmaWeb/recuperaReceita?cod_pedido=' + data[0].cod_pedido + '"/>'+
					   		'<a class="lightbox-close" href="#"></a>'+
						'</div>'+
						'<div>---------------------------------------------------------</div>' +
						'<div>Endereço de Entrega</div>' +
						'<div>' + data[0].rua + ', ' + data[0].numero + ' - ' + data[0].complemento +
						'<div>' + data[0].cep + ' - ' + data[0].bairro +
						'<div>' + data[0].cidade + '/' + data[0].estado +
						'<div>Tempo Estimado de Entrega: ' + data[0].tempo_entrega + '</div>'
				);
		}
		
		function detalhaPedidoFarmacia(data){
			$('#detalhes').append(
					'<div>Número do Pedido: ' + data[0].cod_pedido + '</div>' +
					'<div>Status do Pedido: ' + data[0].status + '</div>' +
					'<div>Cliente: ' + data[0].nome_cliente + '</div>' +
					'<div>Telefone: ' + data[0].tel_cliente + '</div>' +
					'<div>CPF: ' + data[0].cpf_cliente + '</div>' +
					'<div>Data: ' + data[0].data_pedido + '</div>' +
					'<div>---------------------------------------------------------</div>' +
					'<div>Lista de Produtos</div>'
			);
			
			data.forEach( function (e){
					$('#detalhes').append('<div>'+ e.quant_prod_ped +' '+ e.nome_produto +' R$'+ e.preco_unitario + '</div>');
			});
			
			$('#detalhes').append(
					'<div>Desconto Total: ' + data[0].valor_desconto + '</div>' +
					'<div>Taxa de Entrega: ' + data[0].taxa_entrega + '</div>' +
					'<div>Valor Total: ' + data[0].valor_total + '</div>' +
					'<div>Forma de Pagamento: ' + data[0].tipo_pagamento + '</div>' +
					'<a class="lightbox" href="#receita">'+
						'<img src="/FarmaWeb/recuperaReceita?cod_pedido=' + data[0].cod_pedido + '" width="100" height="100"/>' +
					'</a>'+
					'<div class="lightbox-target" id="receita">'+
					   '<img src="/FarmaWeb/recuperaReceita?cod_pedido=' + data[0].cod_pedido + '"/>'+
					   '<a class="lightbox-close" href="#"></a>'+
					'</div>'+
					'<div>---------------------------------------------------------</div>' +
					'<div>Endereço de Entrega</div>' +
					'<div>' + data[0].rua + ', ' + data[0].numero + ' - ' + data[0].complemento +
					'<div>' + data[0].cep + ' - ' + data[0].bairro +
					'<div>' + data[0].cidade + '/' + data[0].estado +
					'<div>Tempo Estimado de Entrega: ' + data[0].tempo_entrega + '</div>'
			);
			
			
		}
		
		
		
		function filtrar() {
			  // Declare variables 
			  var input, filter, table, tr, td, i;
			  input = document.getElementById("filtro");
			  filter = input.value.toUpperCase();
			  table = document.getElementById("myTable");
			  tr = table.getElementsByTagName("tr");

			  // Loop through all table rows, and hide those who don't match the search query
			  for (i = 0; i < tr.length; i++) {
			    td = tr[i].getElementsByTagName("td")[0];
			    if (td) {
			      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
			        tr[i].style.display = "";
			      } else {
			        tr[i].style.display = "none";
			      }
			    } 
			  }
		}
		
		 setTimeout(function(){ 
			 location.reload(); 
		}, 20000);

	</script>	
</body>
</html>