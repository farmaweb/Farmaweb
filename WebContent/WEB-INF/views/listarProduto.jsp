<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-maskmoney/3.0.2/jquery.maskMoney.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<style>
#lightbox .modal-content {
   display: inline-block;
   text-align: center;   
}

#lightbox .close {
    opacity: 1;
    color: rgb(255, 255, 255);
    background-color: rgb(25, 25, 25);
    padding: 5px 8px;
    border-radius: 30px;
    border: 2px solid rgb(255, 255, 255);
    position: absolute;
    top: -15px;
    right: -55px;
    
    z-index:1032;
}

@import url(https://fonts.googleapis.com/css?family=Roboto:400,500,700,300,100);

body {
  font-family: "Roboto", helvetica, arial, sans-serif;
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
  height: 220px;
  margin: auto;
  max-width: 1000px;
  padding:5px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
  animation: float 5s infinite;
}
 
th {
  color:#fff;
  background:#337ab7;
  border-bottom:4px solid #9ea7af;
  border-right: 1px solid #343a45;
  font-size:16px;
  font-weight: 100;
  padding:14px;
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

<title>Lista de Produtos</title>
</head>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" >FarmaWeb</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <form class="navbar-form navbar-left">
	      <c:if test="${usuarioLogado.tipo == 2}">
	        <div class="form-group">
	          <input type="text" class="form-control"  onkeyup="filtrar()" id="filtro" placeholder="Procurar produto"/>	
	        </div>
	       </c:if>
      </form>

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
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.ProdutoDao" />
	<table class="table-fill" id="myTable">
		<thead>
			<tr>
				<th>Foto</th>
				<th>Produto</th>
				<th>Marca/Fabricante</th>
				<th>Descrição</th>
				<th>Característica</th>
				<th>Quantidade</th>
				<th>Receita</th>
				<th>Preço</th>
				<th>Desconto</th>
				<th colspan="2">Ação</th>
			</tr>
		</thead>
		<tbody class="table-hover">
			<c:forEach var="produto" items="${dao.getProdutos(usuarioLogado.cod_login)}">
				<tr>
					<td>
						<a href="#" data-toggle="modal" data-target="#lightbox">
							<img src="/FarmaWeb/recuperaImagem?cod_produto=${produto.cod_produto}" width="100" height="100"/>
						</a>
					</td>
					<td>${produto.nome_produto}</td>
					<td>${produto.marca_fabricante}</td>
					<td>${produto.descricao_produto}</td>
					<td>${produto.caracteristica}</td>
					<td>${produto.quantidade_produto}</td>
					<c:choose>
					    <c:when test="${produto.receita == 1}">
					      <td>Sim</td>
					    </c:when>    
					    <c:otherwise>
					      <td>Não</td> 
					    </c:otherwise>
					</c:choose>
					<td>${produto.preco_unitario}</td>
					<td>${produto.desconto}</td>
					<td><button type="button" onclick="editar(${produto.cod_produto})" data-toggle="modal"
					data-target="#editarProduto" class="btn btn-primary">Editar</button></td>
					<td>
						<form action="/FarmaWeb/desativarProduto" method="POST">
							<input type="hidden" name="cod_produto" value="${produto.cod_produto}" />
							<button type="submit" class="btn btn-primary">Excluir</button>
						</form>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">Incluir produto</button>


	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Cadastro de Produto</h4>
			</div>
			<div class="modal-body">
				<form class="form-signin" action="/FarmaWeb/incluirProduto" method="POST" enctype="multipart/form-data">
					<div class="form-group">
	
						<label for="Nome_Produto">Nome do Produto:</label>
						<input type="text" minlength="3" maxlength="45" name="nome_produto" style="border-radius: 5px;" required>
						</br>
						<label for="Marca_Fabricante">Marca/Fabricante:</label>
						<input type="text" minlength="3" maxlength="45" name="marca_fabricante" style="border-radius: 5px;" required>
						</br>
						<label for="Caracteristica">Caracteristica:</label>
						<input type="text" minlength="3" maxlength="45" name="caracteristica" style="border-radius: 5px;" required>
						</br>
						<label for="Descricao_Produto">Descrição do Produto:</label>
						<input type="text" minlength="6" maxlength="45" name="descricao_produto" style="border-radius: 5px;" required>
						</br> 
						<label for="Receita">Receita:</label>
						<input type="radio" name="receita" value="1" required> Sim
  						<input type="radio" name="receita" value="0"required> Não
						</br>
						<label for="Quantidade_Produto">Quantidade:</label>
						<input type="text" name="quantidade_produto" style="border-radius: 5px;" required> 
						</br> 
						<label for="preco_uniario">Preço Unitário:</label> 
						<input type="text" id="currency" data-thousands="." data-decimal="." name="preco_unitario" style="border-radius: 5px;" required>
						</br>
						<label for="desconto">Desconto:</label> 
						<input type="text" name="desconto" style="border-radius: 5px;" required>%
						</br>
						<input type="file" name="foto_produto"/>
					</div>
						<div class="modal-footer">
							<button class="btn btn-default" type="submit">Salvar</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div id="editarProduto" class="modal fade" role="dialog">
		<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Editar Produto</h4>
			</div>
			<div class="modal-body">
				<form class="form-signin" action="/FarmaWeb/AlterarProduto" method="POST" enctype="multipart/form-data">
					<div class="form-group">
	
						<label for="Nome_Produto">Nome do Produto:</label>
						<input type="text" class="editarNome" minlength="3" maxlength="45" name="nome_produto_alterar" style="border-radius: 5px;" required>
						</br>
						<label for="Marca_Fabricante">Marca/Fabricante:</label>
						<input type="text" class="editarMarca" minlength="3" maxlength="45" name="marca_fabricante_alterar" style="border-radius: 5px;" required>
						</br>
						<label for="Caracteristica">Caracteristica:</label>
						<input type="text" class="editarCaracteristica" minlength="3" maxlength="45" name="caracteristica_alterar" style="border-radius: 5px;" required>
						</br>
						<label for="Descricao_Produto">Descrição do Produto:</label>
						<input type="text" class="alterarDescricao" minlength="6" maxlength="45" name="descricao_produto_alterar" style="border-radius: 5px;" required>
						</br> 
						<label for="Receita">Receita:</label>
						<input type="radio" class="alterarReceitaSim" name="receita_alterar" value="1" required> Sim
  						<input type="radio" class="alterarReceitaNao" name="receita_alterar" value="0"required> Não
						</br>
						<label for="Quantidade_Produto">Quantidade:</label>
						<input type="text" class="alterarQuantidade" name="quantidade_produto_alterar" style="border-radius: 5px;" required> 
						</br> 
						<label for="preco_uniario">Preço Unitário:</label> 
						<input type="text" class="currency" data-thousands="." data-decimal="." name="preco_unitario_alterar" style="border-radius: 5px;" required>
						</br>
						<label for="desconto">Desconto:</label> 
						<input type="text" class="alterarDesconto" name="desconto_alterar" style="border-radius: 5px;" required>%
						</br>
						<input type="file" name="foto_produto_alterar"/>
						<input type="hidden" class="codProduto" id="cod_produto" name="cod_produto_alterar"/>
					</div>
						<div class="modal-footer">
							<button class="btn btn-default" type="submit">Salvar</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div id="lightbox" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <button type="button" class="close hidden" data-dismiss="modal" aria-hidden="true">×</button>
	        <div class="modal-content">
	            <div class="modal-body">
	                <img src="" alt="" />
	            </div>
	        </div>
	    </div>
	</div>
	
	<script>
	
		$(function() {
		    $('#currency').maskMoney();
		    $('.currency').maskMoney();
		})
		
		function editar(cod_produto) {		
			var data = {
					cod_produto: cod_produto
			}
			$.ajax({
		         type: 'POST',    
		         url:'/FarmaWeb/BuscarProduto',
		         data: data,
		         success: function (response) {
		        	 $('.editarNome').val(response.nome_produto).text(response.nome_produto);
		        	 $('.editarMarca').val(response.marca_fabricante).text(response.marca_fabricante);
		        	 $('.editarCaracteristica').val(response.caracteristica).text(response.caracteristica);
		        	 $('.alterarDescricao').val(response.descricao_produto).text(response.descricao_produto);
		        	 if(response.receita == 1){
			        	 $('.alterarReceitaSim').prop( "checked", true );
		        	 }else{
			        	 $('.alterarReceitaNao').prop( "checked", true );
		        	 }	
		        	 $('.alterarQuantidade').val(response.quantidade_produto).text(response.quantidade_produto);
		        	 $('.currency').val(response.preco_unitario).text(response.preco_unitario);
		        	 $('.alterarDesconto').val(response.desconto).text(response.desconto);
		        	 $('.codProduto').val(response.cod_produto).text(response.cod_produto);
	            },
	            error: function (e) {
		              console.log(e);
	            }
			});
		}
		
		function filtrar() {
			  // Declare variables 
			  var input, filter, table, tr, td, i;
			  input = document.getElementById("filtro");
			  filter = input.value.toUpperCase();
			  table = document.getElementById("myTable");
			  tr = table.getElementsByTagName("tr");

			  // Loop through all table rows, and hide those who don't match the search query
			  for (i = 0; i < tr.length; i++) {
			    td = tr[i].getElementsByTagName("td")[1];
			    if (td) {
			      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
			        tr[i].style.display = "";
			      } else {
			        tr[i].style.display = "none";
			      }
			    } 
			  }
		}
		
		$(document).ready(function() {
		    var $lightbox = $('#lightbox');
		    
		    $('[data-target="#lightbox"]').on('click', function(event) {
		        var $img = $(this).find('img'), 
		            src = $img.attr('src'),
		            alt = $img.attr('alt'),
		            css = {
		                'maxWidth': $(window).width() - 100,
		                'maxHeight': $(window).height() - 100
		            };
		    
		        $lightbox.find('.close').addClass('hidden');
		        $lightbox.find('img').attr('src', src);
		        $lightbox.find('img').attr('alt', alt);
		        $lightbox.find('img').css(css);
		    });
		    
		    $lightbox.on('shown.bs.modal', function (e) {
		        var $img = $lightbox.find('img');
		            
		        $lightbox.find('.modal-dialog').css({'width': $img.width()});
		        $lightbox.find('.close').removeClass('hidden');
		    });
		});
		
	</script>
</body>
</html>