<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Lista de Produtos</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.ProdutoDao"/>
	<table class="table table-striped">
		<tr>
			<th>Produto</th>
			<th>Descrição</th>
			<th>Quantidade</th>
			<th>Preço</th>
			<th>Ação</th>
			<th></th>
		</tr>
		<c:forEach var="produto" items="${dao.produtos}">
			<tr>
				<td>${produto.nome_produto}</td>
				<td>${produto.decricao_produto}</td>
				<td>${produto.quantidade_produto}</td>
				<td>${produto.preco_unitario}</td>
				<td><button type="button" class="btn btn-primary">Editar</button></td>
				<td><button type="button" class="btn btn-primary">Excluir</button></td>
			</tr>
		</c:forEach>



	</table>
	<button type="button" class="btn btn-primary">Incluir Produto</button>
</body>
</html>