<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Lista Endereços</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.EnderecoDao" />
	<table class="table table-striped">
		<tr>
			<th>Cep</th>
			<th>Rua</th>
			<th>Número</th>
			<th>Bairro</th>
			<th>Cidade</th>
			<th>Estado</th>
			<th>Complemento</th>
			<th>Ação</th>
			<th></th>
		</tr>
		<c:forEach var="endereco" items="${dao.enderecos}">
			<tr>
				<td>${endereco.cep}</td>
				<td>${endereco.rua}</td>
				<td>${endereco.numero}</td>
				<td>${endereco.bairro}</td>
				<td>${endereco.cidade}</td>
				<td>${endereco.estado}</td>
				<td>${endereco.complemento}</td>
				<td><button type="button" class="btn btn-primary">Editar</button></td>
				<td><form action="/FarmaWeb/excluirEndereco" method="POST">
					<input type="hidden" name="cod_endereco"
							value="${endereco.cod_endereco}" />
						<button type="submit" class="btn btn-primary">Excluir</button>
					</form>
				</td>
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