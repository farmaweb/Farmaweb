<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

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
	<a href="/FarmaWeb/WEB-INF/views/home.jsp#"><button type="button"
			class="btn btn-primary">Voltar</button></a>

	<button type="button" class="btn btn-primary">Incluir
		Funcionario</button>
</body>
</html>