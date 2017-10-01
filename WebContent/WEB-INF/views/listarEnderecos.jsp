<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Lista Endereços</title>
</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.EnderecoDao"/>
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
		<c:forEach var="endereco" items="${dao.enderecos}">
			<tr>
				<td>${endereco.cep}</td>
				<td>${endereco.rua}</td>
				<td>${endereco.numero}</td>
				<td>${endereco.bairro}</td>
				<td>${endereco.cidade}</td>
				<td>${endereco.estado}</td>
				<td>${endereco.complemento}</td>
				<td><button type="button" class="btn btn-primary">Editar</button></td>
				<td><button type="button" class="btn btn-primary">Excluir</button></td>
			</tr>
		</c:forEach>



	</table>
		<a href="/WEB-INF/views/home.jsp#"><button type="button"  class="btn btn-primary"> Voltar</button></a>
	
	<button type="button" class="btn btn-primary">Incluir Endereço</button>
</body>
</html>