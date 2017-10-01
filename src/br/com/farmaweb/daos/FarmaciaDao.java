package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.farmaweb.models.Farmacia;
import br.com.farmaweb.utils.ConexaoBanco;

public class FarmaciaDao {

	private Connection connection;

	public FarmaciaDao() throws ClassNotFoundException {
		new ConexaoBanco();
		this.connection = ConexaoBanco.getConnection();
	}

	public ArrayList<Farmacia> getFarmacias() {
		try {

			PreparedStatement stmt = this.connection.prepareStatement("select * from farmacia");
			ResultSet rs = stmt.executeQuery();

			ArrayList<Farmacia> farmacias = new ArrayList<Farmacia>();

			while (rs.next()) {
				Farmacia farmacia = new Farmacia();

				farmacia.setCod_farmacia(rs.getInt("cod_farmacia"));
				farmacia.setNome_fantasia(rs.getString("nome_fantasia"));
				farmacia.setRazao_social(rs.getString("razao_social"));
				farmacia.setCnpj(rs.getLong("cnpj"));
				farmacia.setTel_farmacia(rs.getLong("tel_farmacia"));
				farmacia.setObservacao(rs.getString("observacao"));
				farmacia.setCod_end_farm(rs.getInt("cod_end_farm"));

				farmacias.add(farmacia);
			}

			rs.close();
			stmt.close();

			return farmacias;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int incluirFarmacia(Farmacia farmacia) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into farmacia(nome_fantasia,razao_social,cnpj,tel_farmacia,observacao,cod_end_farm)"
							+ "values ( ?,?,?,?,?,1 )");

			stmt.setString(1, farmacia.getNome_fantasia());
			stmt.setString(2, farmacia.getRazao_social());
			stmt.setLong(3, farmacia.getCnpj());
			stmt.setLong(4, farmacia.getTel_farmacia());
			stmt.setString(5, farmacia.getObservacao());

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int excluirFarmacia(Farmacia farmacia) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("delete from farmacia where cod_farmacia = ?");

			stmt.setInt(1, farmacia.getCod_farmacia());
			;

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int alterarFarmacia(Farmacia farmacia) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"update farmacia set nome_fantasia = ?, razao_social = ?, cnpj = ?, tel_farmacia = ?, observacao = ?, cod_end_farm = 1 where cod_farmacia = ?");

			stmt.setString(1, farmacia.getNome_fantasia());
			stmt.setString(2, farmacia.getRazao_social());
			stmt.setLong(3, farmacia.getCnpj());
			stmt.setLong(4, farmacia.getTel_farmacia());
			stmt.setString(5, farmacia.getObservacao());
			stmt.setInt(6, farmacia.getCod_farmacia());

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
