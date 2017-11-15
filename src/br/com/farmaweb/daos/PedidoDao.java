package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import br.com.farmaweb.models.Pedido;
import br.com.farmaweb.utils.ConexaoBanco;

public class PedidoDao {
	private Connection connection;

	public PedidoDao() throws ClassNotFoundException {
		new ConexaoBanco();
		this.connection = ConexaoBanco.getConnection();
	}

	public ArrayList<Pedido> getPedidos() {
		try {

			PreparedStatement stmt = this.connection.prepareStatement("select * from pedido");
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
			PreparedStatement stmt = this.connection.prepareStatement("insert into pedido (status, valor_total, valor_desconto, data_pedido, cod_pag_ped, cod_cliente)"
					+ "values ( ?,?,?,?,?,? )",
					Statement.RETURN_GENERATED_KEYS);
			
			stmt.setString(1, pedido.getStatus());
			stmt.setDouble(2, pedido.getValor_total());
			stmt.setDouble(3, pedido.getValor_desconto());
			stmt.setString(4, pedido.getData_pedido());
			stmt.setInt(5, pedido.getCod_pag_ped());
			stmt.setInt(6, pedido.getCod_cli_ped());

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
			PreparedStatement stmt = this.connection.prepareStatement("insert into ped_prod (cod_pedido, cod_produto, quant_prod_ped)"
					+ "values ( ?,?,? )",
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
}
