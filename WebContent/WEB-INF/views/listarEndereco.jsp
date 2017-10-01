<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Lista Endereços</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.EnderecoDao" />
	<table class="table table-striped">
		<tr>
			<th>Cep</th>
			<th>Rua</th>
			<th>Número</th>
			<th>Bairro</th>
			<th>Cidade</th>
			<th>Estado</th>
			<th>Complemento</th>
			<th>Ação</th>
			<th></th>
		</tr>
		<c:forEach var="endereco" items="${dao.getEnderecos(usuarioLogado.cod_login)}">
			<tr>
				<td>${endereco.cep}</td>
				<td>${endereco.rua}</td>
				<td>${endereco.numero}</td>
				<td>${endereco.bairro}</td>
				<td>${endereco.cidade}</td>
				<td>${endereco.estado}</td>
				<td>${endereco.complemento}</td>
				<td><button type="button" class="btn btn-primary">Editar</button></td>
				<td><form action="/FarmaWeb/excluirEndereco" method="POST">
						<input type="hidden" name="cod_endereco"
							value="${endereco.cod_endereco}" />
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
					<h4 class="modal-title">Incluir Endereço</h4>
				</div>
				<div class="modal-body">
					<form class="form-signin" action="/FarmaWeb/incluirEndereco"
						method="POST">
						<div class="form-group">

							<label for="cep">Cep:</label> <input id="cep"
								type="text" name="cep" style="border-radius: 5px;" required>
							<label for="rua">Rua:</label> <input id="rua" 
								type="text" name="rua" style="border-radius: 5px;" required>
							<label for="numero">Número:</label> <input
								type="text" name="numero" style="border-radius: 5px;" required>
							<label for="bairro">Bairro:</label> <input id="bairro"
								type="text" name="bairro" style="border-radius: 5px;" required>
							<label for="cidade">Cidade:</label> <input id="cidade"
								type="text" name="cidade" style="border-radius: 5px;" required>
								<label for="estado">Estado:</label> <input id="estado"
								type="text" name="estado" style="border-radius: 5px;" required>
								<label for="complemento">Complemento:</label> <input
								type="text" name="complemento" style="border-radius: 5px;">	
						</div>
						<div class="modal-footer">
							<button class="btn btn-default" type="submit">Salvar</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		$("#cep").focusout(function(){
			$.ajax({
				url: 'https://viacep.com.br/ws/'+$(this).val()+'/json/unicode/',
				dataType: 'json',
				success: function(resposta){
					$("#rua").val(resposta.logradouro);
					$("#bairro").val(resposta.bairro);
					$("#cidade").val(resposta.localidade);
					$("#estado").val(resposta.uf);
				}
			});
		});
	</script>
</body>
</html>

