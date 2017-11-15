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
	<table class="table table-bordered">
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

</body>
</html>