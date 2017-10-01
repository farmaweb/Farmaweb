<html>
<head>
<title>FarmaWeb</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

</head>
<body class="panel panel-info">
	<div class="container">
		<div class="row">
			<div class="col-sm-6 col-md-4 col-md-offset-4">
				<h1 class="text-center login-title" style="color: DodgerBlue  ; font-size: 80px;">FarmaWeb</h1>
				<div class="account-wall">
					<form class="form-signin" action="/FarmaWeb/login" method="POST">
						<input type="text" class="form-control" placeholder="Usuario"
							name="usuario" required autofocus> <input type="password"
							class="form-control" placeholder="Senha" name="senha" required>
						<button class="btn btn-lg btn-primary btn-block" type="submit">
							Entrar</button>
					</form>
				</div>

				<button type="button" class="btn btn-default" data-toggle="modal"
					data-target="#myModal">Ainda não é cadastrado ?</button>
			</div>
		</div>
	</div>
</body>

<div id="myModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Cadastro</h4>
			</div>
			<div class="modal-body">
				<form class="form-signin" action="/FarmaWeb/cadastrarUsuario" method="POST">
					<div class="form-group">

						<label for="Usuario">Usuario:</label> 
						<input type="text" minlength="3" maxlength="20" name="usuario" style="border-radius: 5px;" required> 
						<label for="Senha">Senha:</label> 
						<input type="password"  minlength="6" maxlength="30" name="senha" style="border-radius: 5px;" required>
						<label for="Nome">Nome:</label> 
						<input type="text" name="nome_cliente" style="border-radius: 5px;" required>
						<label for="Cpf">Cpf:</label> 
						<input type="text" name="cpf_cliente" style="border-radius: 5px;" required>
						<label for="Email">Email:</label> 
						<input type="text" name="email_cliente" style="border-radius: 5px;" required>
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


</html>