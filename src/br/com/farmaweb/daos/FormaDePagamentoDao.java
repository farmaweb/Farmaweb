package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.farmaweb.models.Farmacia;
import br.com.farmaweb.models.FormaDePagamento;
import br.com.farmaweb.utils.ConexaoBanco;

public class FormaDePagamentoDao {
	private Connection connection;

	public FormaDePagamentoDao() throws ClassNotFoundException {
		this.connection = new ConexaoBanco().getConnection();
	}

	public ArrayList<FormaDePagamento> getPagamentos() {
		try {

			PreparedStatement stmt = this.connection.prepareStatement("select * from forma_pagamento");
			ResultSet rs = stmt.executeQuery();

			ArrayList<FormaDePagamento> formadepagamentos = new ArrayList<FormaDePagamento>();

			while (rs.next()) {
				FormaDePagamento formadepagamento = new FormaDePagamento();

				formadepagamento.setCod_pagamento(rs.getInt("cod_pagamento"));
				formadepagamento.setTipo_pagamento(rs.getString("tipo_pagamento"));

				formadepagamentos.add(formadepagamento);
			}

			rs.close();
			stmt.close();

			return formadepagamentos;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int incluirFormaDePagamento(FormaDePagamento formadepagamento) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into forma_pagamento(tipo_pagamento)"
							+ "values ( ? )");

			stmt.setString(1, formadepagamento.getTipo_pagamento());

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int excluirFormaDePagamento(FormaDePagamento formadepagamento) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("delete from forma_pagamento where cod_pagamento = ?");

			stmt.setInt(1, formadepagamento.getCod_pagamento());
			
			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int alterarFormaDePagamento(FormaDePagamento formadepagamento) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"update forma_pagamento set tipo_pagamento = ? where cod_pagamento = ?");

			stmt.setInt(2, formadepagamento.getCod_pagamento());
			stmt.setString(1, formadepagamento.getTipo_pagamento());

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
