package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import br.com.farmaweb.models.FormaDePagamento;
import br.com.farmaweb.utils.ConexaoBanco;

public class EndCliDao {
	private Connection connection;

	public EndCliDao() throws ClassNotFoundException {
		new ConexaoBanco();
		this.connection = ConexaoBanco.getConnection();
	}
	
	public int incluirEndCli(int cod_endereco, int cod_login) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into end_cli(cod_endereco,cod_cliente)"
							+ "values ( ?, ?)");

			stmt.setInt(1, cod_endereco);
			stmt.setInt(2, cod_login);


			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
