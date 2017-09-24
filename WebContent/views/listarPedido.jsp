<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Pedidos</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.PedidoDao" />
	<table class="table table-striped">
		<tr>
			<th>Status</th>
			<th>Valor Total</th>
			<th>Valor Desconto</th>
			<th>Data Pedido</th>
			<th></th>
		</tr>
		<c:forEach var="pedido" items="${dao.pedidos}">
			<tr>
				<td>${pedido.status}</td>
				<td>${pedido.valorTotal}</td>
				<td>${pedido.valorDesconto}</td>
				<td>${pedido.dataPedido}</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>