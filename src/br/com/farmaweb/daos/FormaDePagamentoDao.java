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

	public ArrayList<FormaDePagamento> getFormaDePagamentos() {
		try {

			PreparedStatement stmt = this.connection.prepareStatement("select * from farmacia");
			ResultSet rs = stmt.executeQuery();

			ArrayList<FormaDePagamento> formadepagamentos = new ArrayList<FormaDePagamento>();

			while (rs.next()) {
				FormaDePagamento formadepagamento = new FormaDePagamento();

				formadepagamento.setCod_pag(rs.getInt("cod_pag"));
				formadepagamento.setTipo_pag(rs.getString("tipo_pag"));

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
					"insert into farmacia(tipo_pag)"
							+ "values ( ? )");

			stmt.setString(1, formadepagamento.getTipo_pag());

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int excluirFormaDePagamento(FormaDePagamento formadepagamento) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("delete from farmacia where cod_pag = ?");

			stmt.setInt(1, formadepagamento.getCod_pag());
			
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
					"update farmacia set nome_fantasia = ? where cod_pag = ?");

			stmt.setInt(2, formadepagamento.getCod_pag());
			stmt.setString(1, formadepagamento.getTipo_pag());

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
