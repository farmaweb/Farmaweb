<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
<title>Formas de pagamento</title>

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

.table-fill {
  background: white;
  border-radius:3px;
  border-collapse: collapse;
  height: 420px;
  margin: auto;
  max-width: 1600px;
  padding:5px;
  width: 100%;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
  animation: float 5s infinite;
}
 
th {
  background:#337ab7;
  font-weight: bold;
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
  color:#fff;
  font-weight: bold;
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
 
tr:nth-child(odd) td {
  background:#EBEBEB;
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
	
<body>
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.FormaDePagamentoDao" />
	<table class="table-fill">
		<thead>
			<tr>
				<th>Tipo De Pagamento</th>
			</tr>
		</thead>
		<tbody class="table-hover">
			<c:forEach var="forma" items="${dao.getPagamentosFarmacia(usuarioLogado.cod_login)}">
				<tr>
					<td>${forma.tipo_pagamento}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">Incluir forma de pagamento</button>			
	



	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Forma de pagamento</h4>
				</div>
				<div class="modal-body">
					<form class="form-signin"
						action="/FarmaWeb/incluirFormaDePagamento" method="POST">
						<div class="form-group">

							<label for="tipo_pagamento">Tipo De Pagamento:</label>
								
							<select name="cod_pagamento" class="selectpicker" >
							    <c:forEach var="forma" items="${dao.getAllPagamentos()}">
							        <option  value="${forma.cod_pagamento}">
							            ${forma.tipo_pagamento}
							        </option>
							     </c:forEach> 
							</select>
							<input type="hidden" name="cod_login" value="${usuarioLogado.cod_login}" />							
						</div>
						<div class="modal-footer">
							<button class="btn btn-default" type="submit">Salvar</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>