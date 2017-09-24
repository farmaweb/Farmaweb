<html>
	<head>
		<title>Alterar Farmácia</title>
	</head>
	
	<body>
		<form action="/FarmaWeb/alterarFarmacia" method="post">
			<label for="cod_farm">Código da Farmácia</label>
			<input type="text" name="cod_farm">
			<label for="nome_fantasia">Nome Fantasia</label>
			<input type="text" name="nome_fantasia">	
			<label for="razao_social">Razão Social</label>
			<input type="text" name="razao_social">		
			<label for="cnpj_farm">CNPJ</label>
			<input type="text" name="cnpj_farm">
			<label for="tel_farm">Telefone</label>
			<input type="text" name="tel_farm">
			<label for="observacao">Observação</label>
			<input type="text" name="observacao">
			<input type="submit" value="Alterar">
		</form>
	</body>
</html>