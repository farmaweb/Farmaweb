package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import br.com.farmaweb.models.Farmacia;
import br.com.farmaweb.utils.ConexaoBanco;

public class FarmaciaDao {

	private Connection connection;

	public FarmaciaDao() throws ClassNotFoundException {
		new ConexaoBanco();
		this.connection = ConexaoBanco.getConnection();
	}

	public int retornaCodFarm(int codLogin) {
		int cod_farmacia = 0;

		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"select far.cod_farmacia from farmacia as far inner join funcionario as fun on fun.cod_farm_func = far.cod_farmacia inner join login as log on fun.cod_funcionario = ?");
			stmt.setInt(1, codLogin);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				cod_farmacia = rs.getInt("cod_farmacia");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

		return cod_farmacia;
	}
	
	public String retornaNomeFarm(int cod_pedido) {
		String nome_farmacia = "";
		try {			
			PreparedStatement stmt = this.connection.prepareStatement(
					"select far.nome_fantasia, nome_produto, cod_pedido from farmacia as far inner join produto as prod on prod.cod_farm_prod = far.cod_farmacia inner join ped_prod as ped on ped.cod_produto = prod.cod_produto and ped.cod_pedido = ?");
			stmt.setInt(1, cod_pedido);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				nome_farmacia = rs.getString("nome_fantasia");
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

		return nome_farmacia;
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
				farmacia.setTaxaEntrega(rs.getFloat("taxa_entrega"));
				farmacia.setTempo_entrega(rs.getString("tempo_entrega"));
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

	public int incluirFarmacia(Farmacia farmacia, int cod_endereco) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into farmacia(nome_fantasia,razao_social,cnpj,tel_farmacia,observacao,cod_end_farm,taxa_entrega,tempo_entrega)"
							+ "values ( ?,?,?,?,?,?,?,?)",
					Statement.RETURN_GENERATED_KEYS);

			stmt.setString(1, farmacia.getNome_fantasia());
			stmt.setString(2, farmacia.getRazao_social());
			stmt.setLong(3, farmacia.getCnpj());
			stmt.setLong(4, farmacia.getTel_farmacia());
			stmt.setString(5, farmacia.getObservacao());
			stmt.setInt(6, cod_endereco);
			stmt.setFloat(7, farmacia.getTaxaEntrega());
			stmt.setString(8, farmacia.getTempo_entrega());

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

	public int excluirFarmacia(Farmacia farmacia) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("delete from farmacia where cod_farmacia = ?");

			stmt.setInt(1, farmacia.getCod_farmacia());

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
