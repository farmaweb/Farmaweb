<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Funcionarios</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.FuncionarioDao" />
	<table class="table table-bordered">
		<tr>
			<th>Matrícula</th>
			<th>Nome</th>
			<th>Telefone</th>
			<th>Função</th>
			<th>Ação</th>
			<th></th>

		</tr>
		<c:forEach var="funcionario" items="${dao.getFuncionarios(usuarioLogado.cod_login)}">
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
	<form action="/FarmaWeb/voltar" method="POST">
		<button type="submit" class="btn btn-primary">Voltar</button>
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#funcionario">Incluir</button>
	</form>

	<div id="funcionario" role="dialog" class="modal fade">
		<div class="modal-dialog">
	
			<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Cadastro de funcionário</h4>
			</div>
			<div class="modal-body">
				<form class="form-signin" action="/FarmaWeb/incluirFuncionario"
					method="POST">
					<div class="form-group">
	
						<label for="Usuario">Usuario:</label>
						<input type="text" minlength="3" maxlength="20" name="usuario" style="border-radius: 5px;" required>
						</br>
						<label for="Senha">Senha:</label>
						<input type="password" minlength="6" maxlength="30" name="senha" style="border-radius: 5px;" required>
						</br> 
						<label for="Nome">Nome do funcionario:</label>
						<input type="text" name="nome_funcionario" style="border-radius: 5px;" required> 
						</br> 
						<label for="Matricula">Matricula:</label> 
						<input type="text" name="matricula_funcionario" style="border-radius: 5px;" required>
						</br>
						<label for="Telefone">Telefone:</label> 
						<input type="text" name="tel_funcionario" style="border-radius: 5px;" required>
						</br> 
						<label for="Função">Função:</label> 
						<input type="text" name="funcao" style="border-radius: 5px;" required> 
							<input type="hidden" name="tipo" value="2" />
							<input type="hidden" name="cod_farm_func" value="0"/>
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