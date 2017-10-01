<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Funcionarios</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.FuncionarioDao" />
	<table class="table table-striped">
		<tr>
			<th>Matrícula</th>
			<th>Nome</th>
			<th>Telefone</th>
			<th>Função</th>
			<th>Ação</th>
			<th></th>

		</tr>
		<c:forEach var="funcionario" items="${dao.funcionarios}">
			<tr>
				<td>${funcionario.matricula_funcionario}</td>
				<td>${funcionario.nome_funcionario}</td>
				<td>${funcionario.tel_funcionario}</td>
				<td>${funcionario.funcao}</td>
				<td><button type="button" class="btn btn-primary">Editar</button></td>
				<td><form action="/FarmaWeb/excluirFuncionario"
						method="POST">
						<input type="hidden" name="cod_funcionario"
							value="${funcionario.cod_funcionario}" />
						<button type="submit" class="btn btn-primary">Excluir</button>
					</form></td>
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