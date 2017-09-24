package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.farmaweb.models.FormaDePagamento;
import br.com.farmaweb.models.Pedido;
import br.com.farmaweb.utils.ConexaoBanco;

public class PedidoDao {
	private Connection connection;

	public PedidoDao() throws ClassNotFoundException {
		this.connection = new ConexaoBanco().getConnection();
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
				pedido.setValorTotal(rs.getDouble("valor_total"));
				pedido.setValorDesconto(rs.getDouble("valor_desconto"));
				pedido.setDataPedido(rs.getString("data_pedido"));
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

//	public int incluirFormaDePagamento(Pedido pedido) throws SQLException {
//		try {
//			PreparedStatement stmt = this.connection
//					.prepareStatement("insert into pedido(tipo_pagamento)" + "values ( ? )");
//
//			stmt.setString(1, formadepagamento.getTipo_pagamento());
//
//			int ret = stmt.executeUpdate();
//
//			stmt.close();
//
//			return ret;
//		} catch (SQLException e) {
//			throw new RuntimeException(e);
//		}
//	}
//
//	public int excluirFormaDePagamento(Pedido pedido) throws SQLException {
//		try {
//			PreparedStatement stmt = this.connection
//					.prepareStatement("delete from pedido where cod_pagamento = ?");
//
//			stmt.setInt(1, formadepagamento.getCod_pagamento());
//
//			int ret = stmt.executeUpdate();
//
//			stmt.close();
//
//			return ret;
//		} catch (SQLException e) {
//			throw new RuntimeException(e);
//		}
//	}
//
//	public int alterarFormaDePagamento(Pedido pedido) throws SQLException {
//		try {
//			PreparedStatement stmt = this.connection
//					.prepareStatement("update pedido set tipo_pagamento = ? where cod_pagamento = ?");
//
//			stmt.setInt(2, formadepagamento.getCod_pagamento());
//			stmt.setString(1, formadepagamento.getTipo_pagamento());
//
//			int ret = stmt.executeUpdate();
//
//			stmt.close();
//
//			return ret;
//		} catch (SQLException e) {
//			throw new RuntimeException(e);
//		}
//	}
}
