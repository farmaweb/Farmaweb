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
</style>

<title>Lista de Produtos</title>
</head>

<body class="container">
	<strong>Procurar pelo produto:</strong> <input type="text" onkeyup="filtrar()" id="filtro" />
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.ProdutoDao" />
	<table class="table table-bordered" id="myTable">
		<tr>
			<th>Foto</th>
			<th>Produto</th>
			<th>Marca/Fabricante</th>
			<th>Característica</th>
			<th>Descrição</th>
			<th>Quantidade</th>
			<th>Receita</th>
			<th>Preço</th>
			<th>Desconto</th>
			<th>Ação</th>
		</tr>
		
		<c:forEach var="produto" items="${dao.getProdutos(usuarioLogado.cod_login)}">
			<tr>
				<td>
					<a href="#" class="thumbnail" data-toggle="modal" data-target="#lightbox">
						<img src="/FarmaWeb/recuperaImagem?cod_produto=${produto.cod_produto}" width="100" height="100"/>
					</a>
				</td>
				<td>${produto.nome_produto}</td>
				<td>${produto.marca_fabricante}</td>
				<td>${produto.caracteristica}</td>
				<td>${produto.descricao_produto}</td>
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
					<form action="/FarmaWeb/excluirProduto" method="POST">
						<input type="hidden" name="cod_produto"
							value="${produto.cod_produto}" />
						<button type="submit" class="btn btn-primary">Excluir</button>
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>
	<form action="/FarmaWeb/voltar" method="POST">
		<button type="submit" class="btn btn-primary">Voltar</button>
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#myModal">Incluir</button>
	</form>

	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Cadastro de Produto</h4>
			</div>
			<div class="modal-body">
				<form class="form-signin" action="/FarmaWeb/incluirProduto" method="POST"  enctype="multipart/form-data">
					<div class="form-group">
	
						<label for="Nome_Produto">Nome do Produto:</label>
						<input type="text" minlength="3" maxlength="20" name="nome_produto" style="border-radius: 5px;" required>
						</br>
						<label for="Marca_Fabricante">Marca/Fabricante:</label>
						<input type="text" minlength="3" maxlength="20" name="marca_fabricante" style="border-radius: 5px;" required>
						</br>
						<label for="Caracteristica">Caracteristica:</label>
						<input type="text" minlength="3" maxlength="20" name="caracteristica" style="border-radius: 5px;" required>
						</br>
						<label for="Descricao_Produto">Descrição do Produto:</label>
						<input type="text" minlength="6" maxlength="30" name="descricao_produto" style="border-radius: 5px;" required>
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
				<form class="form-signin" action="/FarmaWeb/AlterarProduto" method="POST">
					<div class="form-group">
	
						<label for="Nome_Produto">Nome do Produto:</label>
						<input type="text" class="editarNome" minlength="3" maxlength="20" name="nome_produto" style="border-radius: 5px;" required>
						</br>
						<label for="Marca_Fabricante">Marca/Fabricante:</label>
						<input type="text" class="editarMarca" minlength="3" maxlength="20" name="marca_fabricante" style="border-radius: 5px;" required>
						</br>
						<label for="Caracteristica">Caracteristica:</label>
						<input type="text" class="editarCaracteristica" minlength="3" maxlength="20" name="caracteristica" style="border-radius: 5px;" required>
						</br>
						<label for="Descricao_Produto">Descrição do Produto:</label>
						<input type="text" class="alterarDescricao" minlength="6" maxlength="30" name="descricao_produto" style="border-radius: 5px;" required>
						</br> 
						<label for="Receita">Receita:</label>
						<input type="radio" class="alterarReceitaSim" name="receita" value="1" required> Sim
  						<input type="radio" class="alterarReceitaNao" name="receita" value="0"required> Não
						</br>
						<label for="Quantidade_Produto">Quantidade:</label>
						<input type="text" class="alterarQuantidade" name="quantidade_produto" style="border-radius: 5px;" required> 
						</br> 
						<label for="preco_uniario">Preço Unitário:</label> 
						<input type="text" class="currency" data-thousands="." data-decimal="." name="preco_unitario" style="border-radius: 5px;" required>
						</br>
						<label for="desconto">Desconto:</label> 
						<input type="text" class="alterarDesconto" name="desconto" style="border-radius: 5px;" required>%
						</br>
						<input type="file" name="foto_produto"/>
						<input type="hidden" id="cod_produto" name="cod_produto"/>
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
		        	 $('#cod_produto').val(response.cod_produto);
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
			    td = tr[i].getElementsByTagName("td")[0];
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