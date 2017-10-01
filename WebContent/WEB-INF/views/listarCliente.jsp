<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Lista de Clientes</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.ClienteDao" />
	<table class="table table-striped">
		<tr>
			<th>Clientes</th>
			<th>CPF</th>
			<th>E-mail</th>
			<th>Telefone</th>
			<th>Ação</th>
			<th></th>
		</tr>
		<c:forEach var="cliente" items="${dao.clientes}">
			<tr>
				<td>${cliente.nome_cliente}</td>
				<td>${cliente.cpf_cliente}</td>
				<td>${cliente.email_cliente}</td>
				<td>${cliente.tel_cliente}</td>
				<td><button type="button" class="btn btn-primary">Editar</button></td>
				<td><button type="button" class="btn btn-primary">Excluir</button></td>
			</tr>
		</c:forEach>



	</table>
	<form action="/FarmaWeb/voltar" method="POST">
		<button type="submit" class="btn btn-primary">Voltar</button>
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#myModal">Incluir</button>
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