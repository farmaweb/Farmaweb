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

<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Roboto:400,500,700,300,100);

body {
  font-family: "Roboto", helvetica, arial, sans-serif;
  font-size: 16px;
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
  max-width: 1000px;
  padding:5px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
  animation: float 5s infinite;
}
 
th {
  color:#D5DDE5;
  background:#1b1e24;
  border-bottom:4px solid #9ea7af;
  border-right: 1px solid #343a45;
  font-size:16px;
  font-weight: 100;
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
  background:gray;
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

.btn-primary {
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
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.EnderecoDao" />
	<table class="table-fill">
		<thead>
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
		</thead>
		<tbody class="table-hover">
			<c:forEach var="endereco" items="${dao.getEnderecos(usuarioLogado.cod_login)}">
				<tr>
					<td>${endereco.cep}</td>
					<td>${endereco.rua}</td>
					<td>${endereco.numero}</td>
					<td>${endereco.bairro}</td>
					<td>${endereco.cidade}</td>
					<td>${endereco.estado}</td>
					<td>${endereco.complemento}</td>
					<td><button type="button" onclick="editar(${endereco.cod_endereco})" data-toggle="modal"
					data-target="#editarEndereco" class="btn btn-primary">Editar</button></td>
					<td><form action="/FarmaWeb/excluirEndereco" method="POST">
							<input type="hidden" name="cod_endereco"
								value="${endereco.cod_endereco}" />
							<button type="submit" class="btn btn-primary">Excluir</button>
						</form></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">Incluir</button>


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
								type="text" name="cep" style="border-radius: 5px;" required></br>
							<label for="rua">Rua:</label> <input id="rua" 
							type="text" name="rua" style="border-radius: 5px;" readonly="true" required></br>
							<label for="numero">Número:</label> <input
								type="text" name="numero" style="border-radius: 5px;" required></br>
							<label for="bairro">Bairro:</label> <input id="bairro"
								type="text" name="bairro" style="border-radius: 5px;" readonly="true" required></br>
							<label for="cidade">Cidade:</label> <input id="cidade"
								type="text" name="cidade" style="border-radius: 5px;" readonly="true" required></br>
								<label for="estado">Estado:</label> <input id="estado"
								type="text" name="estado" style="border-radius: 5px;" readonly="true" required></br>
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
	
	<div id="editarEndereco" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Editar Endereço</h4>
				</div>
				<div class="modal-body">
					<form class="form-signin" action="/FarmaWeb/alterarEndereco"
						method="POST">
						<div class="form-group">

							<label for="cep">Cep:</label> <input id="editarCep"
								type="text" name="cep" style="border-radius: 5px;" required></br>
							<label for="rua">Rua:</label> <input id="editarRua" 
							type="text" name="rua" style="border-radius: 5px;" readonly="true" required></br>
							<label for="numero">Número:</label> <input
								type="text" id="editarNumero" name="numero" style="border-radius: 5px;" required></br>
							<label for="bairro">Bairro:</label> <input 
								type="text" id="editarBairro" name="bairro" style="border-radius: 5px;" readonly="true" required></br>
							<label for="cidade">Cidade:</label> <input id="editarCidade"
								type="text" name="cidade" style="border-radius: 5px;" readonly="true" required></br>
								<label for="estado">Estado:</label> <input id="editarEstado"
								type="text" name="estado" style="border-radius: 5px;" readonly="true" required></br>
								<label for="complemento">Complemento:</label> <input
								type="text" id="editarComplemento" name="complemento" style="border-radius: 5px;">
								<input id="editarCodEndereco" type="hidden" name="cod_endereco">	
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
	
		function editar(cod_endereco) {		
			var data = {
					cod_endereco: cod_endereco
			}
			$.ajax({
		         type: 'POST',    
		         url:'/FarmaWeb/buscarEndereco',
		         data: data,
		         success: function (response) {
		        	 $('#editarCep').val(response.cep).text(response.cep);
		        	 $('#editarRua').val(response.rua).text(response.rua);
		        	 $('#editarNumero').val(response.numero).text(response.numero);
		        	 $('#editarBairro').val(response.bairro).text(response.bairro);
		        	 $('#editarCidade').val(response.cidade).text(response.cidade);
		        	 $('#editarEstado').val(response.estado).text(response.estado);
		        	 $('#editarComplemento').val(response.complemento).text(response.complemento);
		        	 $('#editarCodEndereco').val(response.cod_endereco);
	            },
	            error: function (e) {
		              console.log(e);
	            }
			});
		}
	
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
		
		$("#editarCep").focusout(function(){
			$.ajax({
				url: 'https://viacep.com.br/ws/'+$(this).val()+'/json/unicode/',
				dataType: 'json',
				success: function(resposta){
					$("#editarRua").val(resposta.logradouro);
					$("#editarBairro").val(resposta.bairro);
					$("#editarCidade").val(resposta.localidade);
					$("#editarEstado").val(resposta.uf);
				}
			});
		});
	</script>
</body>
</html>

