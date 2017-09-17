<%@page import="br.com.farmaweb.models.Farmacia"%>
<%@page import="java.util.ArrayList"%>
<%
	ArrayList<Farmacia> farmacias = (ArrayList<Farmacia>) request.getAttribute("farmacias");
%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Incluir Farm�cia</title>
</head>

<body class="container">
	<form action="/FarmaWeb/listarFarmacia" method="GET">
		<table class="table table-striped">

			<tr>
				<th>C�digo</th>
				<th>Nome Fantasia</th>
				<th>Raz�o Social</th>
				<th>CNPJ</th>
				<th>Telefone</th>
				<th>Observa��o</th>
			</tr>

			<%
				for (Farmacia farmacia : farmacias) {
			%>
			<tr>
				<td><%=farmacia.getCod_farm()%></td>
				<td><%=farmacia.getNome_fantasia()%></td>
				<td><%=farmacia.getRazao_social()%></td>
				<td><%=farmacia.getCnpj_farm()%></td>
				<td><%=farmacia.getTel_farm()%></td>
				<td><%=farmacia.getObservacao()%></td>
			</tr>
			<%
				}
			%>
		</table>
	</form>
</body>
</html>