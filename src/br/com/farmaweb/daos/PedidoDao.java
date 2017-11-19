package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import br.com.farmaweb.models.Pedido;
import br.com.farmaweb.utils.ConexaoBanco;

public class PedidoDao {
	private Connection connection;

	public PedidoDao() throws ClassNotFoundException {
		new ConexaoBanco();
		this.connection = ConexaoBanco.getConnection();
	}

	public ArrayList<Pedido> getPedidos(int cod_cliente) {
		try {

			PreparedStatement stmt = this.connection.prepareStatement("select * from pedido where cod_cliente = ?");

			stmt.setInt(1, cod_cliente);

			ResultSet rs = stmt.executeQuery();

			ArrayList<Pedido> pedidos = new ArrayList<Pedido>();

			while (rs.next()) {
				Pedido pedido = new Pedido();

				pedido.setCod_pedido(rs.getInt("cod_pedido"));
				pedido.setStatus(rs.getString("status"));
				pedido.setValor_total(rs.getDouble("valor_total"));
				pedido.setValor_desconto(rs.getDouble("valor_desconto"));
				pedido.setData_pedido(rs.getString("data_pedido"));
				pedido.setCod_pag_ped(rs.getInt("cod_pag_ped"));
				pedido.setCod_cli_ped(rs.getInt("cod_cliente"));
				pedido.setCod_func(rs.getInt("cod_funcionario"));

				pedidos.add(pedido);
			}

			rs.close();
			stmt.close();

			return pedidos;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public ArrayList<Pedido> getPedidosFarmacia(int cod_login) throws ClassNotFoundException {
		try {
			
			FarmaciaDao farmaciaDao = new FarmaciaDao();
			int cod_farmacia = farmaciaDao.retornaCodFarm(cod_login);

			PreparedStatement stmt = this.connection.prepareStatement("select * from pedido as ped inner join ped_prod as pp on pp.cod_pedido = ped.cod_pedido inner join produto as prod on prod.cod_produto = pp.cod_produto inner join farmacia as far on far.cod_farmacia = prod.cod_farm_prod where far.cod_farmacia = ?");

			stmt.setInt(1, cod_farmacia);

			ResultSet rs = stmt.executeQuery();

			ArrayList<Pedido> pedidos = new ArrayList<Pedido>();

			while (rs.next()) {
				Pedido pedido = new Pedido();

				pedido.setCod_pedido(rs.getInt("cod_pedido"));
				pedido.setStatus(rs.getString("status"));
				pedido.setValor_total(rs.getDouble("valor_total"));
				pedido.setValor_desconto(rs.getDouble("valor_desconto"));
				pedido.setData_pedido(rs.getString("data_pedido"));
				pedido.setCod_pag_ped(rs.getInt("cod_pag_ped"));
				pedido.setCod_cli_ped(rs.getInt("cod_cliente"));
				pedido.setCod_func(rs.getInt("cod_funcionario"));

				pedidos.add(pedido);
			}

			rs.close();
			stmt.close();

			return pedidos;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int incluirPedido(Pedido pedido) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into pedido (status, valor_total, valor_desconto, data_pedido, cod_pag_ped, cod_cliente, cod_endereco)"
							+ "values ( ?,?,?,?,?,?,? )",
					Statement.RETURN_GENERATED_KEYS);

			stmt.setString(1, pedido.getStatus());
			stmt.setDouble(2, pedido.getValor_total());
			stmt.setDouble(3, pedido.getValor_desconto());
			stmt.setString(4, pedido.getData_pedido());
			stmt.setInt(5, pedido.getCod_pag_ped());
			stmt.setInt(6, pedido.getCod_cli_ped());
			stmt.setInt(7, 4);

			stmt.executeUpdate();
			int ret = 0;

			ResultSet rs = stmt.getGeneratedKeys();
			if (rs.next()) {
				ret = rs.getInt(1);
			}

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public void incluirPedProd(int cod_pedido, int cod_produto, int quantidade_produto) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into ped_prod (cod_pedido, cod_produto, quant_prod_ped)" + "values ( ?,?,? )",
					Statement.RETURN_GENERATED_KEYS);

			stmt.setInt(1, cod_pedido);
			stmt.setInt(2, cod_produto);
			stmt.setInt(3, quantidade_produto);

			stmt.executeUpdate();

			stmt.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public ArrayList<HashMap<String, String>> buscaDetalhes(int cod_pedido) {
		try {

			PreparedStatement stmt = this.connection.prepareStatement("select ped.cod_pedido, ped.status, ped.data_pedido,ped.valor_desconto, ped.valor_total, prod.nome_produto, prod.preco_unitario, fp.tipo_pagamento, pp.quant_prod_ped, far.nome_fantasia, far.taxa_entrega, far.tempo_entrega, ende.rua, ende.bairro, ende.numero, ende.cidade, ende.estado, ende.complemento, ende.cep, cli.nome_cliente, cli.tel_cliente, cli.cpf_cliente from pedido as ped inner join ped_prod as pp on pp.cod_pedido = ped.cod_pedido inner join produto as prod on prod.cod_produto = pp.cod_produto inner join forma_pagamento as fp on fp.cod_pagamento = ped.cod_pag_ped inner join farmacia as far on far.cod_farmacia = prod.cod_farm_prod inner join cliente as cli on cli.cod_cliente = ped.cod_cliente inner join end_cli as ec on ec.cod_cliente = cli.cod_cliente inner join endereco as ende on ende.cod_endereco = ec.cod_endereco and ende.cod_endereco = ped.cod_endereco where ped.cod_pedido = ?");
			
			stmt.setInt(1, cod_pedido);
			
			ResultSet rs = stmt.executeQuery();
			
			ArrayList<HashMap<String, String>> listaDetalhes = new ArrayList<HashMap<String, String>>();
			HashMap<String,String> detalhes = new HashMap<String,String>();

			while (rs.next()) {
				detalhes.put("cod_pedido", rs.getString("cod_pedido"));
				detalhes.put("status", rs.getString("status"));
				detalhes.put("data_pedido", rs.getString("data_pedido"));
				detalhes.put("valor_desconto", rs.getString("valor_desconto"));
				detalhes.put("valor_total", rs.getString("valor_total"));
				detalhes.put("data_pedido", rs.getString("data_pedido"));
				detalhes.put("nome_produto", rs.getString("nome_produto"));
				detalhes.put("preco_unitario", rs.getString("preco_unitario"));
				detalhes.put("tipo_pagamento", rs.getString("tipo_pagamento"));
				detalhes.put("quant_prod_ped", rs.getString("quant_prod_ped"));
				detalhes.put("nome_fantasia", rs.getString("nome_fantasia"));
				detalhes.put("taxa_entrega", rs.getString("taxa_entrega"));
				detalhes.put("tempo_entrega", rs.getString("tempo_entrega"));
				detalhes.put("rua", rs.getString("rua"));
				detalhes.put("bairro", rs.getString("bairro"));
				detalhes.put("numero", rs.getString("numero"));
				detalhes.put("cidade", rs.getString("cidade"));
				detalhes.put("estado", rs.getString("estado"));
				detalhes.put("complemento", rs.getString("complemento"));
				detalhes.put("cep", rs.getString("cep"));
				detalhes.put("nome_cliente", rs.getString("nome_cliente"));
				detalhes.put("tel_cliente", rs.getString("tel_cliente"));
				detalhes.put("cpf_cliente", rs.getString("cpf_cliente"));
				
				listaDetalhes.add((HashMap<String, String>) detalhes.clone());
				detalhes.clear();
			}

			rs.close();
			stmt.close();
			
			return listaDetalhes;
			
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public void alterarStatus(int cod_pedido, String status) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("update pedido set status = ? where cod_pedido = ? ");
			stmt.setString(1, status);
			stmt.setInt(2, cod_pedido);
			
			stmt.executeUpdate();
			stmt.close();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
