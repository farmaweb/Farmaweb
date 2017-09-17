<%@page import="br.com.farmaweb.models.Endereco"%>
<%@page import="java.util.ArrayList"%>
<%
	ArrayList<Endereco> enderecos = (ArrayList<Endereco>) request.getAttribute("enderecos");
%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<title>Lista Endereços</title>
</head>

<body class="container">
		<table class="table table-striped">

			<tr>
				<th>Cep</th>
				<th>Rua</th>
				<th>Número</th>
				<th>Bairro</th>
				<th>Cidade</th>
				<th>Estado</th>
				<th>Complemento</th>
			</tr>

			<%
				for (Endereco endereco : enderecos) {
			%>
			<tr>
				<td><%=endereco.getCep()%></td>
				<td><%=endereco.getRua()%></td>
				<td><%=endereco.getNum_end()%></td>
				<td><%=endereco.getBairro()%></td>
				<td><%=endereco.getCidade()%></td>
				<td><%=endereco.getEstado()%></td>
				<td><%=endereco.getComplemento()%></td>
			</tr>
			<%
				}
			%>
		</table>
</body>
</html>