<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Pedidos</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.PedidoDao" />
	<jsp:useBean id="daoNomeFarm" class="br.com.farmaweb.daos.FarmaciaDao" />
	<strong>Procurar pelo número do pedido:</strong> <input type="text" onkeyup="filtrar()" id="filtro" />
	<table class="table table-bordered" id="myTable">
		<tr>
			<th>Número do Pedido</th>
			<th>Farmácia</th>
			<th>Valor Total</th>
			<th>Valor Desconto</th>
			<th>Data Pedido</th>
			<th>Status</th>
		</tr>
		
		<c:forEach var="pedido" items="${dao.pedidos}">
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
				<td>${pedido.status}</td>
				<td>
					<button type="button" id="botaoDetalhes" class="btn btn-primary" data-toggle="modal" data-target="#modalDetalhes">Detalhes do Pedido</button>
				</td>
			</tr>
		</c:forEach>
	</table>
	
	<form action="/FarmaWeb/voltar" method="POST">
		<button type="submit" class="btn btn-primary">Voltar</button>
	</form>
	
	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Forma de pagamento</h4>
				</div>
				<div class="modal-body">
					<form class="form-signin"
						action="/FarmaWeb/incluirFormaDePagamento" method="POST">
						<div class="form-group">

							<label for="tipo_pagamento">Tipo De Pagamento:</label> <input
								type="text" name="tipo_pagamento" style="border-radius: 5px;">
						</div>
						<div class="modal-footer">
							<button class="btn btn-default" type="submit">Salvar</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div id="modalDetalhes" class="modal fade" role="dialog">
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
	
		$('#botaoDetalhes').click(function (){
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
			
			$( "#detalhes" ).append(
				'<div>Lista de Produtos</div>'
			);
			
			resumo.forEach(function(produtos){
			    $('#detalhes').append('<div>'+ produtos.quantidade +' '+ produtos.nome +' '+ produtos.valor + '</div>' +
			    		'<input type=hidden value = '+ produtos.quantidade +' name=quantidade_produto>' +
			    		'<input type=hidden value = '+ produtos.id_produto +' name=id_produto>'
			    );
			});
			
			$( "#detalhes" ).append(
				'<div>---------------------------------------------------------</div>' +
				'<div>Endereço de Entrega</div>' +
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
				'<div name=valorTotal value = ' + $('.valorTotal').text() + '>Valor Total: ' + $('.valorTotal').text() + '</div>' +
				'<div value = ' + $('.tempoEntrega').text() + '>Tempo Estimado de Entrega: ' + $('.tempoEntrega').text() + '</div>'
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
	</script>
	
</body>
</html>