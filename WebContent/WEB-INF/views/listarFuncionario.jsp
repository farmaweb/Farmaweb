<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.12/jquery.mask.min.js"></script>
<title>Funcionarios</title>
<style type="text/css">
	@import url(https://fonts.googleapis.com/css?family=Roboto:400,500,700,300,100);

	body {
	  font-family: "Roboto", helvetica, arial, sans-serif;
	  font-size: 20px;
	  font-weight: 400;
	  text-rendering: optimizeLegibility;
	}
	
	div.table-title {
	   display: block;
	  margin: auto;
	  max-width: 600px;
	  padding:5px;
	  width: 100%;
	}
		
	/*** Table Styles **/
	
	.table-fill {
	  background: white;
	  border-radius:3px;
	  border-collapse: collapse;
	  height: 220px;
	  margin: auto;
	  max-width: 1600px;
	  padding:5px;
	  width: 100%;
	  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
	  animation: float 5s infinite;
	}
	 
	th {
	  color:#fff;
      background:#337ab7;
      font-weight: bold;
	  border-bottom:4px solid #9ea7af;
	  border-right: 1px solid #343a45;
	  font-size:16px;
	  padding:24px;
	  text-align:left;
	  text-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
	  vertical-align:middle;
	}
	
	th:first-child {
	  border-top-left-radius:3px;
	}
	 
	th:last-child {
	  border-top-right-radius:3px;
	  border-right:none;
	}
	  
	tr {
	  border-top: 1px solid #C1C3D1;
	  border-bottom-: 1px solid #C1C3D1;
	  color:#666B85;
	  font-size:16px;
	  font-weight:normal;
	  text-shadow: 0 1px 1px rgba(256, 256, 256, 0.1);
	}
	 
	tr:hover td {
	  background:#4E5066;
	  color:#FFFFFF;
	  border-top: 1px solid #22262e;
	}
	 
	tr:first-child {
	  border-top:none;
	}
	
	tr:last-child {
	  border-bottom:none;
	}
	 
	tr:nth-child(odd):hover td {
	  background:#4E5066;
	}
	
	tr:last-child td:first-child {
	  border-bottom-left-radius:3px;
	}
	 
	tr:last-child td:last-child {
	  border-bottom-right-radius:3px;
	}
	 
	td {
	  background:#FFFFFF;
	  padding:20px;
	  text-align:left;
	  vertical-align:middle;
	  font-weight:300;
	  font-size:18px;
	  text-shadow: -1px -1px 1px rgba(0, 0, 0, 0.1);
	  border-right: 1px solid #C1C3D1;
	}
	
	td:last-child {
	  border-right: 0px;
	}
	
	th.text-left {
	  text-align: left;
	}
	
	th.text-center {
	  text-align: center;
	}
	
	th.text-right {
	  text-align: right;
	}
	
	td.text-left {
	  text-align: left;
	}
	
	td.text-center {
	  text-align: center;
	}
	
	td.text-right {
	  text-align: right;
	}
	
	table {
	  width:500px;
	  margin: 10px auto;
	}
	
	#incluirFuncionario {
	  margin-top:20px;
	}
</style>
</head>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" >FarmaWeb</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <form class="navbar-form navbar-left">
	      <c:if test="${usuarioLogado.tipo == 2}">
	        <div class="form-group">
	          <input type="text" class="form-control"  onkeyup="filtrar()" id="filtro" placeholder="Procurar funcionário"/>	
	        </div>
	       </c:if>
      </form>

	 <ul class="nav navbar-nav navbar-right">
   	  	<form class="form-signin navbar-form" action="/FarmaWeb/voltar" method="POST">
  		   <button type="submit" class="btn btn-default">Voltar</button>	
           <button type="button" class="btn btn-default" data-toggle="modal" data-target="#sair">Sair</button>
        </form>
     </ul>
    </div>
  </div>
</nav>

<div class="modal fade" id="sair" role="dialog">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Deseja realmente sair ?</h4>
			</div>
			<div class="modal-footer">
				<form class="bottom-left" action="/FarmaWeb/logout" method="POST">
					<button class="btn btn-lg btn-primary btn-block" type="submit">Sim</button>
				</form>
			</div>
		</div>
	</div>
</div>	

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.FuncionarioDao" />

	<table class="table-fill" id="myTable">
		<thead>
			<tr>
				<th>Matrícula</th>
				<th>Nome</th>
				<th>Telefone</th>
				<th>Função</th>
				<th colspan="2"></th>
	
			</tr>
		</thead>
		<tbody class="table-hover">
			<c:forEach var="funcionario" items="${dao.getFuncionarios(usuarioLogado.cod_login)}">
				<tr>
					<td>${funcionario.matricula_funcionario}</td>
					<td>${funcionario.nome_funcionario}</td>
					<td>${funcionario.tel_funcionario}</td>
					<td>${funcionario.funcao}</td>
					<td><button type="button" onclick="editar(${funcionario.cod_funcionario})" data-toggle="modal"
					data-target="#editarFuncionario" class="btn btn-primary">Editar</button></td>
					<td><form action="/FarmaWeb/desativarLogin" method="POST">
							<input type="hidden" name="cod_login" value="${funcionario.cod_funcionario}" />
							<input type="hidden" name="cod_login_sessao" value="${usuarioLogado.cod_login}" />
							<button type="submit" class="btn btn-primary">Excluir</button>
						</form></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button type="button" id="incluirFuncionario" class="btn btn-primary" data-toggle="modal" data-target="#funcionario">Incluir funcionário</button>


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
		
		function editar(cod_funcionario) {		
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