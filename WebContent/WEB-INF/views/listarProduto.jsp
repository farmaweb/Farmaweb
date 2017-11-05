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
			<th>Foto</th>
			<th>Produto</th>
			<th>Marca/Fabricante</th>
			<th>Característica</th>
			<th>Descrição</th>
			<th>Quantidade</th>
			<th>Receita</th>
			<th>Preço</th>
			<th>Desconto</th>
			<th>Ação</th>
		</tr>
		
		<c:forEach var="produto" items="${dao.getProdutos(usuarioLogado.cod_login)}">
			<tr>
				<td>${produto.nome_produto}</td>
				<td>${produto.marca_fabricante}</td>
				<td>${produto.caracteristica}</td>
				<td>${produto.descricao_produto}</td>
				<td>${produto.quantidade_produto}</td>
				<c:choose>
				    <c:when test="${produto.receita == 1}">
				      <td>Sim</td>
				    </c:when>    
				    <c:otherwise>
				      <td>Não</td> 
				    </c:otherwise>
				</c:choose>
				<td>${produto.preco_unitario}</td>
				<td>${produto.desconto}</td>
				
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
				<form class="form-signin" action="/FarmaWeb/incluirProduto" method="POST"  enctype="multipart/form-data">
					<div class="form-group">
	
						<label for="Nome_Produto">Nome do Produto:</label>
						<input type="text" minlength="3" maxlength="20" name="nome_produto" style="border-radius: 5px;" required>
						</br>
						<label for="Marca_Fabricante">Marca/Fabricante:</label>
						<input type="text" minlength="3" maxlength="20" name="marca_fabricante" style="border-radius: 5px;" required>
						</br>
						<label for="Caracteristica">Caracteristica:</label>
						<input type="text" minlength="3" maxlength="20" name="caracteristica" style="border-radius: 5px;" required>
						</br>
						<label for="Descricao_Produto">Descrição do Produto:</label>
						<input type="text" minlength="6" maxlength="30" name="descricao_produto" style="border-radius: 5px;" required>
						</br> 
						<label for="Receita">Receita:</label>
						<input type="radio" name="receita" value="1" required> Sim
  						<input type="radio" name="receita" value="0"required> Não
						</br>
						<label for="Quantidade_Produto">Quantidade:</label>
						<input type="text" name="quantidade_produto" style="border-radius: 5px;" required> 
						</br> 
						<label for="preco_uniario">Preço Unitário:</label> 
						<input type="text" name="preco_unitario" style="border-radius: 5px;" required>
						</br>
						<label for="desconto">Desconto:</label> 
						<input type="text" name="desconto" style="border-radius: 5px;" required>
						</br>
						<input type="file" name="foto_produto"/>
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