<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

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
					<th>Informa��es</th>
					<th>Pre�o</th>
					<th>Desconto</th>
					<th>Receita</th>
				</tr>
				<c:forEach var="produto" items="${dao.listaProdutoFarmacia(cod_farmacia)}">
					<tr>
						<td id="cod_produto${produto.cod_produto}"></td>
						<td id="nome_produto${produto.cod_produto}">${produto.nome_produto}</td>
						<td>${produto.marca_fabricante}<br>${produto.descricao_produto}<br>${produto.caracteristica}</td>
						<td id="preco_unitario${produto.cod_produto}">${produto.preco_unitario}</td>
						<td id="desconto${produto.cod_produto}">${produto.desconto}</td>
						<c:choose>
					   		<c:when test="${produto.receita == 1}">
					      		<td>Sim</td>
					    	</c:when>    
					    	<c:otherwise>
					      		<td>N�o</td> 
					    	</c:otherwise>
						</c:choose>
						<td><a class="btn btn-xs btn-info adicionar" data-toggle="modal" data-id="${produto.cod_produto}">Adicionar</a></td>
						
					</tr>
				</c:forEach>
			</table>
		</div>
		
		
		<footer>
			<div class="alert  alert-danger" style="display:none;">
	  			<strong>Aten��o!</strong> Produto j� adicionado no carrinho.
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
      					<label>Desconto Total: R$<strong class="descontoTotal">0</strong></label>
      					<p>
      					<label>Taxa de Entrega: R$<strong class="taxaEntrega">${taxa_entrega}</strong></label>
      					<p>				
      					<label>Valor Total: R$<strong class="valorTotal">0</strong></label>
      					<p>
      					<label>Tempo Estimado: <strong class="tempoEntrega">${tempo_entrega}</strong></label>
						<div><button class="btn btn-default" type="submit">Finalizar Pedido</button></div>
					</div>
				</div>
			</div>
		</div>
		

			
	</div>

	<script type="text/javascript">
		
		var valorMap = new Map();
		var valorDesconto = new Map();
		$(".adicionar").on('click', function(){
			
			var id = $(this).data('id');
			var nome = $('#nome_produto' + id).text();
			var preco = $('#preco_unitario' + id).text();
			var desconto = $('#desconto' + id).text();
				
			valorMap.set(nome, parseFloat(preco));
			valorDesconto.set(nome, parseFloat(preco * desconto/100));
			
			somaDesconto(valorDesconto);
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
				+ '<span class="glyphicon glyphicon-trash"></span> <input type="hidden" class="valorUnitario" value='+preco+' > <input type="hidden" class="valorDesconto" value='+desconto+' ></div>');
			
			$('input[type="number"]').bind('click keyup', function (e){
				var quantidade = $(this).val();
				var valorUnitario = $(this).siblings(".valorUnitario").val();
				var subTotal = (parseFloat(valorUnitario) * quantidade);
				var nome = $(this).siblings(".nome").text();
				$(this).siblings('.valor').text(subTotal).val(subTotal);
				
				var desconto_total =  subTotal * parseFloat($(this).siblings(".valorDesconto").val())/100;
				
				if(valorMap.has(nome)){
					valorMap.set(nome, subTotal)
				}
				
				if(valorDesconto.has(nome)){
					valorDesconto.set(nome, desconto_total)
				}
				
				somaDesconto(valorDesconto);
				somaValores(valorMap);
			});
			
			$('.glyphicon-trash').unbind("click").click(function (){
				var nome = $(this).siblings(".nome").text();
				valorMap.delete(nome);
				
				var valor = parseFloat(parseFloat($('.valorTotal').text()) + valorDesconto.get(nome)) - parseFloat($(this).siblings(".valor").text());
				valorDesconto.delete(nome);
				somaDesconto(valorDesconto);
				$('.valorTotal').text(valor.toFixed(2));
				$(this).parent().remove();
			});		
		});	
		
		function somaValores(valorTotal){
			var valorCalculado = 0.0;
			valorTotal.forEach(function (e) { 
				valorCalculado += e; 
			});
			$('.valorTotal').text((valorCalculado - parseFloat($('.descontoTotal').text()) + parseFloat($('.taxaEntrega').text())).toFixed(2));
		}
		
		function somaDesconto(valorTotal){
			var valorCalculado = 0.0;
			valorTotal.forEach(function (e) { 
				valorCalculado += e; 
			});
			$('.descontoTotal').text(valorCalculado.toFixed(2)).val(valorCalculado.toFixed(2));
		}
		
	</script>

	<form action="/FarmaWeb/voltar" method="POST">
		<button type="submit" class="btn btn-primary">Voltar</button>
	</form>

</body>
</html>