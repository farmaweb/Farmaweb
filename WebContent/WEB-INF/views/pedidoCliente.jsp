<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<style>
.modal-dialog {
	position: absolute;
	right: 0px;
	width: 300px;
	padding: 10px;
}

.modal-header {
	background: #337ab7;
	color: white;
}

#numero {
	width: 70%;
}
th {
	width: 15%;
    text-align: center;
}
.bottom-left {
	position: fixed;
	bottom: 0;
	left: 25;
}
</style>

<title>Lista de Produtos</title>

</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.ProdutoDao" />

	<div class="row">
		<div class="col-xs-6">
			<table class="table table-bordered">
				<tr>
					<th>Foto</th>
					<th>Produto</th>
					<th>Preço</th>
					<th>Quantidade</th>
				</tr>
				<c:forEach var="produto"
					items="${dao.listaProdutoFarmacia(cod_farmacia)}">
					<tr>
						<td></td>
						<td>${produto.nome_produto}<br>
							${produto.descricao_produto}
						</td>
						<td>${produto.preco_unitario}</td>
						<td><input id="numero" type="number"
							class="form-control text-center" value="1"></td>
						<td><a id="adicionar">Adicionar ao carrinho</a></td>
					</tr>
				</c:forEach>
			</table>
		</div>

		<div class="col-xs-6">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">
							<span class="glyphicon glyphicon-shopping-cart"></span> Carrinho
						</h4>
					</div>
					<div class="form-group"></div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="bottom-left">
		<form action="/FarmaWeb/voltar" method="POST">
			<button type="submit" class="btn btn-primary">Voltar</button>
		</form>
	</div>

</body>
</html>