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
  body {
  	background: DarkTurquoise ;
  }
	
</style>
</head>

<nav class="navbar navbar-default navbar-fixed-top">
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
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.FormaDePagamentoDao" />
	<table class="table table-bordered">
		<tr>
			<th>Tipo De Pagamento</th>
		</tr>
		<c:forEach var="forma" items="${dao.getPagamentos(usuarioLogado.cod_login)}">
			<tr>
				<td>${forma.tipo_pagamento}</td>
			</tr>
		</c:forEach>



	</table>
	
	
	<button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">Incluir</button>



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