package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.farmaweb.models.Funcionario;
import br.com.farmaweb.utils.ConexaoBanco;

public class FuncionarioDao {
	private Connection connection;

	public FuncionarioDao() throws ClassNotFoundException {
		new ConexaoBanco();
		this.connection = ConexaoBanco.getConnection();
	}
	

	public ArrayList<Funcionario> getFuncionarios(int cod_login) {
		try {
			
			FarmaciaDao farmaciaDao = new FarmaciaDao();
			int cod_farm = farmaciaDao.retornaCodFarm(cod_login);
			
			PreparedStatement stmt = this.connection.prepareStatement("select * from funcionario where cod_farm_func = ?");
			stmt.setInt(1, cod_farm);
			
			ResultSet rs = stmt.executeQuery();
			
			ArrayList<Funcionario> funcionarios = new ArrayList<Funcionario>();

			while (rs.next()) {
				Funcionario funcionario = new Funcionario();

				funcionario.setCod_funcionario(rs.getInt("cod_funcionario"));
				funcionario.setMatricula_funcionario(rs.getLong("matricula_funcionario"));
				funcionario.setNome_funcionario(rs.getString("nome_funcionario"));
				funcionario.setTel_funcionario(rs.getLong("tel_funcionario"));
				funcionario.setFuncao(rs.getString("funcao"));
				funcionario.setCod_farm_func(rs.getInt("cod_farm_func"));

				funcionarios.add(funcionario);
			}

			rs.close();
			stmt.close();

			return funcionarios;
		} catch (SQLException | ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}
	
	public Funcionario getFuncionario(int cod_funcionario) {
		try {
			
			PreparedStatement stmt = this.connection.prepareStatement("select * from funcionario where cod_funcionario = ?");
			stmt.setInt(1, cod_funcionario);
			
			ResultSet rs = stmt.executeQuery();
			
			Funcionario funcionario =  new Funcionario();

			while (rs.next()) {
				funcionario.setCod_funcionario(rs.getInt("cod_funcionario"));
				funcionario.setMatricula_funcionario(rs.getLong("matricula_funcionario"));
				funcionario.setNome_funcionario(rs.getString("nome_funcionario"));
				funcionario.setTel_funcionario(rs.getLong("tel_funcionario"));
				funcionario.setFuncao(rs.getString("funcao"));
			}

			rs.close();
			stmt.close();

			return funcionario;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int incluirFuncionario(Funcionario funcionario) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into funcionario(cod_funcionario,matricula_funcionario,nome_funcionario,tel_funcionario,funcao,cod_farm_func)"
							+ "values ( ?,?,?,?,?,? )");

			stmt.setInt(1, funcionario.getCod_funcionario());
			stmt.setLong(2, funcionario.getMatricula_funcionario());
			stmt.setString(3, funcionario.getNome_funcionario());
			stmt.setLong(4, funcionario.getTel_funcionario());
			stmt.setString(5, funcionario.getFuncao());
			stmt.setInt(6, funcionario.getCod_farm_func());

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int excluirFuncionario(Funcionario funcionario) throws SQLException {
		try {
			PreparedStatement stmt = this.connection
					.prepareStatement("delete from funcionario where cod_funcionario = ?");

			stmt.setInt(1, funcionario.getCod_funcionario());
			;

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int alterarFuncionario(Funcionario funcionario) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"update funcionario set nome_funcionario = ?, tel_funcionario = ?, funcao = ? where cod_funcionario = ?");

			stmt.setString(1, funcionario.getNome_funcionario());
			stmt.setLong(2, funcionario.getTel_funcionario());
			stmt.setString(3, funcionario.getFuncao());
			stmt.setLong(4, funcionario.getCod_funcionario());

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
