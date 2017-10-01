<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Lista de Clientes</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.ClienteDao"/>
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
	<button type="button" class="btn btn-primary">Incluir Cliente</button>
</body>
</html>