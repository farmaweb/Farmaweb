<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	
<style>
.modal-carrinho {
	position: absolute;
    right: 0px;
    width: 350px;
    padding: 10px;
}
.modal-header {
	background: #337ab7;
	color: white;
}
input[type=number] {
	width: 60px;
}
input[type=number]::-webkit-inner-spin-button {
    opacity: 1;
    width: 60px;
}
footer {
    position: fixed;
    bottom: 0;
    width: 80%;
    text-align: center;
}

.div-carrinho > input, li {
  display: inline;  
  list-style-type: none;
  margin: 10px;
}

.div-carrinho > .glyphicon-trash {
	float: right;
	top: 20px;
}
.div-carrinho {
	margin-bottom: 5px;
	margin-left: -40;
}
</style>	

<title>Lista de Produtos</title>

</head>

<body class="container">
	<jsp:useBean id="dao" class="br.com.farmaweb.daos.ProdutoDao" />
	
	<div class="row">
		<div class="col-xs-6">
			<table class="table table-bordered">
				<tr>
					<th>Foto</th>
					<th>Produto</th>
					<th>Preço</th>
				</tr>
				<c:forEach var="produto" items="${dao.listaProdutoFarmacia(cod_farmacia)}">
					<tr>
						<td id="cod_produto${produto.cod_produto}"></td>
						<td id="nome_produto${produto.cod_produto}">${produto.nome_produto}</td>
						<td id="preco_unitario${produto.cod_produto}">${produto.preco_unitario}</td>
						<td><a class="btn btn-xs btn-info adicionar" data-toggle="modal" data-id="${produto.cod_produto}">Adicionar</a></td>
						
					</tr>
				</c:forEach>
			</table>
		</div>
		
		
		<footer>
			<div class="alert  alert-danger" style="display:none;">
	  			<strong>Atenção!</strong> Produto já adicionado no carrinho.
			</div>
		</footer>

		<div id="ModalTeste" class="col-xs-6">
			<div class="modal-carrinho">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title"><span class="glyphicon glyphicon-shopping-cart"></span> Carrinho </h4>
					</div>
					 <div class="modal-body">
	       				<ul class="lista">
						</ul>
      				</div>
      				<div class="modal-footer">
      					<label>Valor Total: R$<strong class="valorTotal">0</strong></label>
						<div><button class="btn btn-default" type="submit">Finalizar Pedido</button></div>
					</div>
				</div>
			</div>
		</div>
		

			
	</div>

	<script type="text/javascript">
		
		var valorMap = new Map();
		$(".adicionar").on('click', function(){
			
			var id = $(this).data('id');
			var nome = $('#nome_produto' + id).text();
			var preco = $('#preco_unitario' + id).text();
			
			valorMap.set(nome, parseFloat(preco));
			
			somaValores(valorMap);
			if(document.getElementById(id) != null){
				if(id === parseInt(document.getElementById(id).getAttribute("id"))){
					$('.alert').fadeIn();
					$('.alert').fadeOut(5000);
					return;
				}
			}
			
			$( ".lista" ).append(
				'<div class="div-carrinho" id='+ id +'><input type="number" class="form-control text-center" onKeyPress="if(this.value.length==2) return false;" value="1" min="1" max="99">'
				+ '<li class="nome" name=' + nome + ' >' + nome + '</li>'
				+ '<li class="valor" value='+ preco +'>'+ preco +'</li>' 
				+ '<span class="glyphicon glyphicon-trash"></span> <input type="hidden" class="valorUnitario" value='+preco+' > </div>');
			
			$('input[type="number"]').bind('click keyup', function (e){
				var quantidade = $(this).val();
				var valorUnitario = $(this).siblings(".valorUnitario").val();
				var subTotal = (parseFloat(valorUnitario) * quantidade);
				var nome = $(this).siblings(".nome").text();
				$(this).siblings('.valor').text(subTotal).val(subTotal);
				

				if(valorMap.has(nome)){
					valorMap.set(nome, subTotal)
				}
				
				somaValores(valorMap);
			});
			
			$('.glyphicon-trash').unbind("click").click(function (){
				var nome = $(this).siblings(".nome").text();
				valorMap.delete(nome);
				var valor = parseFloat($('.valorTotal').text()) -  parseFloat($(this).siblings(".valor").text());
				$('.valorTotal').text(valor.toFixed(2));
				$(this).parent().remove();
			});		
		});	
		
		function somaValores(valorTotal){
			var valorCalculado = 0.0;
			valorTotal.forEach(function (e) { 
				valorCalculado += e; 
			});
			$('.valorTotal').text(valorCalculado).val(valorCalculado);
		}
		
		
	</script>

	<form action="/FarmaWeb/voltar" method="POST">
		<button type="submit" class="btn btn-primary">Voltar</button>
	</form>

</body>
</html>