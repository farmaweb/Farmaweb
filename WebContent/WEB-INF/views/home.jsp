<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
#map {
	width: 100%;
	height: 100%;	
	text-align: center;

}

body {
	overflow-x: hidden;
}

.table {
	border-radius: 10px;
	width: 70%;
	margin: 0px auto;
	float: none;
}

.navbar	{
	margin-bottom: 0px;
}

</style>
</head>
<body>
		
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" >FarmaWeb</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <c:if test="${usuarioLogado.tipo == 2}"> 
			<li><a href="/FarmaWeb/listaFormaDePagamento"> 
			Forma de pagamento
			</a></li> 
		</c:if>
		<c:if test="${usuarioLogado.tipo == 1}">
			<li><a href="/FarmaWeb/listarEndereco"> 
				Endereço
				</a></li> 
		</c:if>
		<c:if test="${usuarioLogado.tipo == 2}">
 			<li><a href="/FarmaWeb/listaFuncionario"> Funcionários</a></li>
		</c:if>
		<c:if test="${usuarioLogado.tipo == 2}">
			<li><a href="/FarmaWeb/listaPedido"> Pedidos</a></li> 
		</c:if>
		<c:if test="${usuarioLogado.tipo == 1}">
			<li><a href="/FarmaWeb/listaPedido"> Meus Pedidos</a></li> 
		</c:if>
		<c:if test="${usuarioLogado.tipo == 2}">
			<li><a href="/FarmaWeb/listaProduto"> Produto</a></li> 
		</c:if>
      </ul>
      <form class="navbar-form navbar-left">
	      <c:if test="${usuarioLogado.tipo == 2}">
	        <div class="form-group">
	          <input type="text" class="form-control" onkeyup="filtrar()" id="filtro" placeholder="Procurar pedido"/>
	        </div>
	       </c:if>
      </form>
      <ul class="nav navbar-nav navbar-right">
		<p class="navbar-btn">
          	<c:if test="${usuarioLogado.tipo == 1}">
 				<button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalEnderecos">Selecione o seu endereço</button> 
			</c:if>	
              <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">Sair</button>
         </p>
      </ul>
    </div>
  </div>
</nav>	
	
	<c:if test="${usuarioLogado.tipo == 2}">
		<jsp:useBean id="dao" class="br.com.farmaweb.daos.PedidoDao" />
		<div class="container-fluid">
			<table class="table table-hover text-centered" id="myTable">
				<tr>
					<th>Número do Pedido</th>
					<th>Valor</th>
					<th>Data Pedido</th>
					<th>Status</th>
				</tr>
				<c:forEach var="pedido" items="${dao.getPedidosFarmacia(usuarioLogado.cod_login)}">
					<c:if test="${pedido.status ne 'Cancelado'}">
						<c:if test="${pedido.status ne 'Concluído'}">
							<tr>
								<td id="cod_pedido">${pedido.cod_pedido}</td>
								<td>${pedido.valor_total}</td>
								<td>${pedido.data_pedido}</td>
								<td>
									<c:if test="${pedido.status == 'Aberto'}">
										<span  class="btn btn-success btn-circle btn-xl"></span>
									</c:if>
									<c:if test="${pedido.status == 'Enviado'}">
										<span  class="btn btn-info btn-circle btn-xl"></span>
									</c:if>
									<c:if test="${pedido.status == 'Separação'}">
										<span  class="btn btn-warning btn-circle btn-xl"></span>
									</c:if>
									${pedido.status}
								</td>
								<td>
									<button type="button" id="botaoDetalhes" onclick="getDetalhes(${pedido.cod_pedido})" class="btn btn-primary" data-toggle="modal" data-target="#modalDetalhes">Detalhes do Pedido</button>
								</td>
								<td>
									<button type="button" id="botaoAlterarStatus" onclick="enviarCodPedido(${pedido.cod_pedido})"  class="btn btn-primary" data-toggle="modal" data-target="#modalStatus">Alterar Status</button>
								</td>
							</tr>
						</c:if>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</c:if>

	<div id="modalStatus" class="modal fade"    role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Alterar Status do Pedido</h4>
				</div>
				<div class="modal-body">
					<div class="form-group" id="status">
						<label for="tipo_pagamento">Tipo De Pagamento:</label>
						<select id="status" name="status" class="selectpicker" >
						    <option  value="Separação">Separação</option>
						    <option  value="Enviado">Enviado</option>
						    <option  value="Concluído">Concluído</option>
						    <option  value="Cancelado">Cancelado</option>
						</select>
					</div>
					<div class="modal-footer">
						<button type="button" id="teste" data-dismiss="modal" class="btn btn-primary" >Salvar</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="modalDetalhes" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Detalhes do Pedido</h4>
				</div>
				<div class="modal-body">
					<div class="form-group" id="detalhes">
					</div>
					<div class="modal-footer">
					
					</div>
				</div>
			</div>
		</div>
	</div>

	<c:if test="${usuarioLogado.tipo == 1}">
		<div id="map"></div>
	</c:if>

	<div class="modal fade" id="myModal" role="dialog">
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

	<div id="modalEnderecos" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Endereços Cadastrados</h4>
				</div>
				<div class="modal-body">
					<jsp:useBean id="daoEnderecos" class="br.com.farmaweb.daos.EnderecoDao" />
					<form id="endereco">
						<c:forEach var="endereco" items="${daoEnderecos.getEnderecos(usuarioLogado.cod_login)}">
								<div class="card" style="width: 20rem;">
				  					<div class="card-block">
				    					<h4 class="card-title">Tipo de Endereço</h4>
				    						<p class="card-text">
													<input id="rua"  type="hidden" value="${endereco.rua}">${endereco.rua}, <input id="numero"  type="hidden" value="${endereco.numero}">${endereco.numero} - <input id="complemento"  type="hidden" value="${endereco.complemento}">${endereco.complemento}
													<br>
													<input id="cep"  type="hidden" value="${endereco.cep}">${endereco.cep} - <input id="bairro"  type="hidden" value="${endereco.bairro}">${endereco.bairro}
													<br>
													<input id="cidade"  type="hidden" value="${endereco.cidade}">${endereco.cidade}/<input id="estado"  type="hidden" value="${endereco.estado}">${endereco.estado}
													<br>
													<input type="radio" id="cod_endereco" name="enderecoSelecionado" value="${endereco.cod_endereco}">Selecionar endereço<br>
													<input id="latitude"  type="hidden" value="${endereco.latitude}">
													<input id="longitude" type="hidden" value="${endereco.longitude}">
											</p>
				    				</div>
			    				</div>
		    			</c:forEach>
	    			</form>
				</div>
				<div class="modal-footer">
						<button id="selecionar" class="btn btn-primary" data-dismiss="modal" type="submit">Selecionar</button>
				</div>
			</div>
		</div>
	</div>

	<script>
	
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
	
	var cod_pedidoFarmacia;
	function enviarCodPedido(cod_pedido){
		cod_pedidoFarmacia = cod_pedido;
	}
	
	$('#teste').click(function (event){
		var data = {
				status:$('#status option:selected').val(),
				cod_pedido: cod_pedidoFarmacia
		}
		$.ajax({
	         type: 'POST',    
	         url:'/FarmaWeb/AlterarStatus',
	         data: data,
	         success: function (response) {
	        	 location.reload();
            },
            error: function (e) {
	              console.log(e);
            }
		});
		
	});
	
	$('#selecionar').click(function (){
		
		getData(); 
		
		$('.fade in').removeClass('fade in');
	});
	
	$(window).on('load',function() {
	    getData();
	});
	
	function getData() {
		$.ajax({
		         type: 'GET',    
		         url:'/FarmaWeb/listaLatLong',
		         success: function(data){
		        	 var lista = [];
		        	 $.each(data, function(key, value) {
		        		 if(value.latitude != undefined && value.longitude != undefined){
		        			 lista.push({bairro: value.bairro,cep: value.cep,cidade: value.cidade,complemento: value.complemento,estado: value.estado,numero: value.numero,rua: value.rua, lat: parseFloat(value.latitude), lng: parseFloat(value.longitude),cod_farmacia: data[key+1].cod_farmacia});
		        		 }
		        	 })
		        	 initMap(lista); 
		         }
		});
	}
	
	function initMap(lista) {
		
		var listaLatLongCodFarmacia = lista;
		var listaFarmacias = [];
		var contentString = '';
		
		if($("#endereco input[type='radio']:checked").siblings("#latitude").val() != null && $("#endereco input[type='radio']:checked").siblings("#longitude").val() != null){
			var latitude = $("#endereco input[type='radio']:checked").siblings("#latitude").val();
			var longitude = $("#endereco input[type='radio']:checked").siblings("#longitude").val();
			var rua_cliente = $("#endereco input[type='radio']:checked").siblings("#rua").val();
			var numero_cliente = $("#endereco input[type='radio']:checked").siblings("#numero").val();
			var complemento_cliente = $("#endereco input[type='radio']:checked").siblings("#complemento").val();
			var cep_cliente = $("#endereco input[type='radio']:checked").siblings("#cep").val();
			var bairro_cliente = $("#endereco input[type='radio']:checked").siblings("#bairro").val();
			var cidade_cliente = $("#endereco input[type='radio']:checked").siblings("#cidade").val();
			var estado_cliente = $("#endereco input[type='radio']:checked").siblings("#estado").val();
			var cod_endereco = $("#endereco input[type='radio']:checked").val();
		}else{
			var latitude = $('#latitude').val();
			var longitude = $('#longitude').val();
			var rua_cliente = $("#rua").val();
			var numero_cliente = $("#numero").val();
			var complemento_cliente = $("#complemento").val();
			var cep_cliente = $("#cep").val();
			var bairro_cliente = $("#bairro").val();
			var cidade_cliente = $("#cidade").val();
			var estado_cliente = $("#estado").val();
			var cod_endereco = $("#cod_endereco").val();
		}
		
		var map = new google.maps.Map(document.getElementById('map'), {
	          zoom: 16,
	          center: {lat: parseFloat(latitude), lng: parseFloat(longitude)},
	          gestureHandling: 'greedy'
        });
		    
		var markers = lista.map(function(location) {
	          return new google.maps.Marker({
	              position: location,
	              title: location.cod_farmacia.toString()
	          });      
       	});
				
		 markers.forEach(function (marker){
			$.ajax({
			         type: 'GET',    
			         url:'/FarmaWeb/listarFarmaciasMapa',
			         success: function(data){
			        	 listaFarmacias = data;
			         }
			 });
			
			marker.addListener('mouseover', function() {		
				 listaFarmacias.forEach(function (farmacia){
				 	listaLatLongCodFarmacia.forEach(function (endereco){
				 	  if(farmacia.cod_farmacia == endereco.cod_farmacia){	
					 	if(parseInt(marker.title) == endereco.cod_farmacia){
					 		contentString = '<div id="content">'+
						      '<div id="siteNotice">'+
						      '</div>'+
						      '<h1 id="firstHeading" class="firstHeading">'+ farmacia.nome_fantasia +'</h1>'+
						      '<div id="bodyContent">'+
						      '<p>' + endereco.rua + ', ' + endereco.numero + ' ' + endereco.complemento +'</p>'+
						      '<p>' + endereco.bairro +'</p>'+
						      '<p>' + endereco.cidade + ' - ' + endereco.estado +'</p>'+
						      '<p>' + endereco.cep +'</p>'+
						      '<p> Telefone: '+ farmacia.tel_farmacia +'</p>'+
						      '<form class="form-signin" action="/FarmaWeb/pedidoCliente" method="POST">'+
						      '<input type="hidden" name="taxa_entrega" value="'+farmacia.taxa_entrega+'" />'+
						      '<input type="hidden" name="tempo_entrega" value="'+farmacia.tempo_entrega+'" />'+
						      '<input type="hidden" name="rua_cliente" value="'+rua_cliente+'" />'+
						      '<input type="hidden" name="numero_cliente" value="'+numero_cliente+'" />'+
						      '<input type="hidden" name="complemento_cliente" value="'+complemento_cliente+'" />'+
						      '<input type="hidden" name="cep_cliente" value="'+cep_cliente+'" />'+
						      '<input type="hidden" name="bairro_cliente" value="'+bairro_cliente+'" />'+
						      '<input type="hidden" name="cidade_cliente" value="'+cidade_cliente+'" />'+
						      '<input type="hidden" name="estado_cliente" value="'+estado_cliente+'" />'+
						      '<input type="hidden" name="cod_farmacia" value="'+marker.title+'" />'+
						      '<input type="hidden" name="cod_endereco" value="'+cod_endereco+'" />'+
						      '<input type="hidden" name="cod_cliente" value="'+${usuarioLogado.cod_login}+'" />'+
						      '<button class="btn btn-default" type="submit">Entre na Farmácia</button>'+
						      '</form>'+		  
						      '</div>'+
						      '</div>';
					 		}
				 		}
					 });
				 });
				 
			      var infowindow = new google.maps.InfoWindow({
			    	    content: contentString
			   	  });
				 
				 infowindow.open(map, marker);
				 
				 var closeInfoWindowWithTimeout;
				 marker.addListener('mouseout', function() {
					  closeInfoWindowWithTimeout = setTimeout(() => infowindow.close(map, marker), 1500);
				 },false);
			
				 
			  });
			 
		
		 });
		
	
		var markerCluster = new MarkerClusterer(map, markers,{imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
    }
	
	$('.close').click( function (){
		$('#detalhes').empty();
	});
		
	function getDetalhes(cod_pedido) {
		$.ajax({
		         type: 'GET',    
		         url:'/FarmaWeb/buscarDetalhes?cod_pedido=' + cod_pedido,
		         success: function(data){
		        		 detalhaPedidoFarmacia(data);
		         }
		     });
	 }
		
	function detalhaPedidoFarmacia(data){
		$('#detalhes').append(
				'<div>Número do Pedido: ' + data[0].cod_pedido + '</div>' +
				'<div>Status do Pedido: ' + data[0].status + '</div>' +
				'<div>Cliente: ' + data[0].nome_cliente + '</div>' +
				'<div>Telefone: ' + data[0].tel_cliente + '</div>' +
				'<div>CPF: ' + data[0].cpf_cliente + '</div>' +
				'<div>Data: ' + data[0].data_pedido + '</div>' +
				'<div>---------------------------------------------------------</div>' +
				'<div>Lista de Produtos</div>'
		);
		
		data.forEach( function (e){
				$('#detalhes').append('<div>'+ e.quant_prod_ped +' '+ e.nome_produto +' R$'+ e.preco_unitario + '</div>');
		});
		
		$('#detalhes').append(
				'<div>Desconto Total: ' + data[0].valor_desconto + '</div>' +
				'<div>Taxa de Entrega: ' + data[0].taxa_entrega + '</div>' +
				'<div>Valor Total: ' + data[0].valor_total + '</div>' +
				'<div>Forma de Pagamento: ' + data[0].tipo_pagamento + '</div>' +
				'<div>---------------------------------------------------------</div>' +
				'<div>Endereço de Entrega</div>' +
				'<div>' + data[0].rua + ', ' + data[0].numero + ' - ' + data[0].complemento +
				'<div>' + data[0].cep + ' - ' + data[0].bairro +
				'<div>' + data[0].cidade + '/' + data[0].estado +
				'<div>Tempo Estimado de Entrega: ' + data[0].tempo_entrega + '</div>'
		);
	}
	
	 setTimeout(function(){ 
		 location.reload(); 
	}, 40000);

	
</script>
<script
	src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
</script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDIOUquPXPAq0yXYC8JYcNjUCrCz1OGukc&callback=initMap">
</script>
</body>
</html>




