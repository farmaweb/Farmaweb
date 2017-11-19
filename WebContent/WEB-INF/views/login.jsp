<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>FarmaWeb</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<style>
img {
	background-repeat: no-repeat;
}

.bottom-left {
	position: fixed;
	bottom: 0;
	left: 0;
}

#menu {
    position: absolute;
    top: 15px;
    right: 10px;
}
</style>

</head>
<body>
	<div class="container">
		<div class="bottom-left">
			<img alt=""
				src="https://www.afterhourshomedoctorwa.com.au/wp-content/uploads/2017/04/Home_Doctor_Perth_Bunbury-228x300.png"></img>
		</div>
		<div class="row">
			<nav id="menu">
				<button type="button" class="btn btn-default" data-toggle="modal"
					data-target="#clienteModal">Cliente não cadastrado ?</button>
				<button type="button" class="btn btn-default" data-toggle="modal"
					data-target="#farmaciaModal">Farmácia não cadastrada  ?</button>
			</nav>
			<div class="col-sm-6 col-md-4 col-md-offset-4">
				<h1 class="text-center login-title"
					style="color: DodgerBlue; font-size: 80px;">FarmaWeb</h1>
				<div class="account-wall">
					<form class="form-signin" action="/FarmaWeb/login" method="POST">
						<input type="text" class="form-control" placeholder="Usuario"
							name="usuario" required autofocus> <input type="password"
							class="form-control" placeholder="Senha" name="senha" required>
						<button class="btn btn-lg btn-primary btn-block" type="submit">
							Entrar</button>
					</form>
					<c:if test="${verificaResultado == 0}">
						<div class="alert alert-danger">
							<strong>Atenção!</strong> Login ou Senha incorretos.
						</div>
					</c:if>

				</div>

			</div>
		</div>
	</div>
</body>

<div id="clienteModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Cadastro de cliente</h4>
			</div>
			<div class="modal-body">
				<form class="form-signin" action="/FarmaWeb/cadastrarUsuario"
					method="POST">
					<div class="form-group">

						<label for="Usuario">Usuario:</label> <input type="text" minlength="3" maxlength="20" name="usuario" style="border-radius: 5px;" required> </br><label for="Senha">Senha:</label>
						<input type="password" minlength="6" maxlength="30" name="senha" style="border-radius: 5px;" required>
						</br> 
						<label for="Nome">Nome:</label>
						<input type="text" name="nome_cliente" style="border-radius: 5px;" required> 
						</br> 
						<label for="Cpf">Cpf:</label> 
						<input type="text" name="cpf_cliente" style="border-radius: 5px;" required>
						</br> 
						<label for="Email">Email:</label> 
						<input type="text" name="email_cliente" style="border-radius: 5px;" required>
						</br> 
						<label for="Telefone">Telefone:</label> 
						<input type="text" name="tel_cliente" style="border-radius: 5px;" required> 
						<input type="hidden" name="tipo" value="1" />
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="submit">Salvar</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<c:if test="${incluirClienteFarmacia == 1}">
	<div id="adminModal" role="dialog" >
		<div class="modal-dialog">
	
			<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Cadastre um administrador</h4>
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
							<input type="hidden" name="cod_farm_func" value="${cod_farm_func}"/>
					</div>
						<div class="modal-footer">
							<button class="btn btn-default" type="submit">Salvar</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</c:if>

<div id="farmaciaModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Cadastro de Farmácia</h4>
			</div>
			<div class="modal-body">
				<form class="form-signin" action="/FarmaWeb/incluirFarmacia"
					method="POST">
					<div class="form-group">

						<label for="nome_fantasia">Nome Fantasia:</label> 
						<input type="text" minlength="6" maxlength="20" name="nome_fantasia" style="border-radius: 5px;" required> 
						</br>
						</br> 
						<label for="razao_social">Razão Social:</label>
						<input type="text" name="razao_social" style="border-radius: 5px;" required> 
						</br> 
						<label for="cnpj">CNPJ:</label> 
						<input type="text" name="cnpj" style="border-radius: 5px;" required>
						</br> 
						<label for="tel_farmacia">Telefone:</label> 
						<input type="text" name="tel_farmacia" style="border-radius: 5px;" required>
						</br> 		
						<label for="tel_farmacia">Taxa de entrega:</label> 
						<input type="text" name="taxa_entrega" style="border-radius: 5px;" required>
						</br> 	
						<label for="tel_farmacia">Tempo estimado:</label> 
						<input type="text" name="tempo_entrega" style="border-radius: 5px;" required>
						</br> 
						<label for="observacao">Observação:</label>
						</br>
						<textarea rows="3" cols="50" name="observacao" style="border-radius: 5px;" placeholder="Ex.: Horario de Funcionamento"></textarea> 
						</br>
						<h4 class="modal-title">Endereço</h4>
						</br>
						<label for="cep">Cep:</label> 
						<input id="cep" type="text" name="cep" style="border-radius: 5px;" required>
						</br>
						<label for="rua">Rua:</label> 
						<input id="rua" type="text" name="rua" style="border-radius: 5px;" readonly="true" required>
						</br>
						<label for="numero">Número:</label> 
						<input type="text" name="numero" style="border-radius: 5px;" required>
						</br>
						<label for="bairro">Bairro:</label> 
						<input id="bairro" type="text" name="bairro" style="border-radius: 5px;" readonly="true" required>
						</br>
						<label for="cidade">Cidade:</label> 
						<input id="cidade" type="text" name="cidade" style="border-radius: 5px;" readonly="true" required>
						</br>
						<label for="estado">Estado:</label> 
						<input id="estado" type="text" name="estado" style="border-radius: 5px;" readonly="true" required>
						</br>
						<label for="complemento">Complemento:</label> 
						<input type="text" name="complemento" style="border-radius: 5px;">	
						
						
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="submit" data-toggle="modal"
					data-target="usuario">Salvar</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>


</html>

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