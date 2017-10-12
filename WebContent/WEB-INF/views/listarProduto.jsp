<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Lista de Produtos</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.ProdutoDao" />
	<table class="table table-bordered">
		<tr>
			<th>Produto</th>
			<th>Descri��o</th>
			<th>Quantidade</th>
			<th>Pre�o</th>
			<th>A��o</th>
			<th></th>
		</tr>
		<c:forEach var="produto" items="${dao.getProdutos(usuarioLogado.cod_login)}">
			<tr>
				<td>${produto.nome_produto}</td>
				<td>${produto.descricao_produto}</td>
				<td>${produto.quantidade_produto}</td>
				<td>${produto.preco_unitario}</td>
				<td><button type="button" class="btn btn-primary">Editar</button></td>
				<td><form action="/FarmaWeb/excluirProduto" method="POST">
						<input type="hidden" name="cod_produto"
							value="${produto.cod_produto}" />
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
				<h4 class="modal-title">Cadastro de Produto</h4>
			</div>
			<div class="modal-body">
				<form class="form-signin" action="/FarmaWeb/incluirProduto"
					method="POST">
					<div class="form-group">
	
						<label for="Nome_Produto">Nome do Produto:</label>
						<input type="text" minlength="3" maxlength="20" name="nome_produto" style="border-radius: 5px;" required>
						</br>
						<label for="Descricao_Produto">Descri��o do Produto:</label>
						<input type="text" minlength="6" maxlength="30" name="descricao_produto" style="border-radius: 5px;" required>
						</br> 
						<label for="Quantidade_Produto">Quantidade:</label>
						<input type="text" name="quantidade_produto" style="border-radius: 5px;" required> 
						</br> 
						<label for="preco_uniario">Pre�o Unit�rio:</label> 
						<input type="text" name="preco_unitario" style="border-radius: 5px;" required>
						</br>
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