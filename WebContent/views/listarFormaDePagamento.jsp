<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Formas de pagamento</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.FormaDePagamentoDao"/>
	<table class="table table-striped">
		<tr>
			<th>Tipo De Pagamento</th>
			<th>Ação</th>
			<th></th>
		</tr>
		<c:forEach var="forma" items="${dao.pagamentos}">
			<tr>
				<td>${forma.tipo_pagamento}</td>
				<td><button type="button" class="btn btn-primary">Editar</button></td>
				<td><button type="button" class="btn btn-primary">Excluir</button></td>
			</tr>
		</c:forEach>



	</table>
	<button type="button" class="btn btn-primary">Incluir Forma De Pagamento</button>
</body>
</html>