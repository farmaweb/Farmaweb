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

<title>Lista Farmácia</title>
</head>

<body class="container">
		<table class="table table-striped">

			<tr>
				<th>Código</th>
				<th>Nome Fantasia</th>
				<th>Razão Social</th>
				<th>CNPJ</th>
				<th>Telefone</th>
				<th>Observação</th>
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
</body>
</html>