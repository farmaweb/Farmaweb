<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.12/jquery.mask.min.js"></script>
<title>Funcionarios</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.FuncionarioDao" />
	<strong>Procurar o funcionario:</strong> <input type="text" onkeyup="filtrar()" id="filtro"/>
	<table class="table table-bordered" id="myTable">
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
				<td><button type="button" onclick="teste(${funcionario.cod_funcionario})" data-toggle="modal"
				data-target="#editarFuncionario" class="btn btn-primary">Editar</button></td>
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
						<input type="text" id="telefone" name="tel_funcionario" style="border-radius: 5px;" required>
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
	
	<div id="editarFuncionario" role="dialog" class="modal fade">
		<div class="modal-dialog">
	
			<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Editar funcionário</h4>
			</div>
			<div class="modal-body">
				<form class="form-signin" action="/FarmaWeb/AlterarFuncionario"
					method="POST">
					<div class="form-group">
						<label for="Nome">Nome do funcionario:</label>
						<input type="text" id="editarNome" name="nome_funcionario" style="border-radius: 5px;" required> 
						</br> 
						<label for="Matricula">Matricula:</label> 
						<input type="text" id="editarMatricula" name="matricula_funcionario" style="border-radius: 5px;" required>
						</br>
						<label for="Telefone">Telefone:</label> 
						<input type="text" id="editarTelefone" name="tel_funcionario" style="border-radius: 5px;" required>
						</br> 
						<label for="Função">Função:</label> 
						<input type="text" id="editarFuncao" name="funcao" style="border-radius: 5px;" required> 
						<input type="hidden" id="editarCodFuncionario" name="cod_funcionario" />
					</div>
						<div class="modal-footer">
							<button class="btn btn-default" type="submit">Salvar</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		$('#editarTelefone').mask('0000-0000');
		$('#telefone').mask('0000-0000');
		
		function teste(cod_funcionario) {		
			var data = {
					cod_funcionario: cod_funcionario
			}
			$.ajax({
		         type: 'POST',    
		         url:'/FarmaWeb/BuscarFuncionario',
		         data: data,
		         success: function (response) {
		        	 $('#editarNome').val(response.nome_funcionario).text(response.nome_funcionario);
		        	 $('#editarMatricula').val(response.matricula_funcionario).text(response.matricula_funcionario);
		        	 $('#editarTelefone').val(response.tel_funcionario).text(response.tel_funcionario);
		        	 $('#editarFuncao').val(response.funcao).text(response.funcao);
		        	 $('#editarCodFuncionario').val(response.cod_funcionario);
	            },
	            error: function (e) {
		              console.log(e);
	            }
			});
		}
		
		function filtrar() {
		
			  var input, filter, table, tr, td, i;
			  input = document.getElementById("filtro");
			  filter = input.value.toUpperCase();
			  table = document.getElementById("myTable");
			  tr = table.getElementsByTagName("tr");
	
			  for (i = 0; i < tr.length; i++) {
			    td = tr[i].getElementsByTagName("td")[1];
			    if (td) {
			      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
			        tr[i].style.display = "";
			      } else {
			        tr[i].style.display = "none";
			      }
			    } 
			  }
		}
	</script>
</body>
</html>