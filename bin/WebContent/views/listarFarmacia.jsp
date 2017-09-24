<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Lista Farmácia</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.FarmaciaDao"/>
	<table class="table table-striped">

		<tr>

			<th>Nome Fantasia</th>
			<th>Razão Social</th>
			<th>CNPJ</th>
			<th>Telefone</th>
			<th>Observação</th>
			<th>Ação</th>
			<th></th>
		</tr>
		
		<c:forEach var="farmacia" items="${dao.farmacias}">
			<tr>
				<td>${farmacia.nome_fantasia}</td>
				<td>${farmacia.razao_social}</td>
				<td>${farmacia.cnpj_farm}</td>
				<td>${farmacia.tel_farm}</td>
				<td>${farmacia.observacao}</td>
				<td><button type="button" class="btn btn-primary">Editar</button></td>
				<td><button type="button" class="btn btn-primary">Excluir</button></td>
			</tr>
		</c:forEach>

	</table>
	<button type="button" class="btn btn-primary">Incluir Farmacia</button>
</body>
</html>