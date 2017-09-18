package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.farmaweb.models.Endereco;
import br.com.farmaweb.utils.ConexaoBanco;

public class EnderecoDao {
	private Connection connection;

	public EnderecoDao() throws ClassNotFoundException {
		this.connection = new ConexaoBanco().getConnection();
	}

	public ArrayList<Endereco> getEnderecos() {
		try {

			PreparedStatement stmt = this.connection.prepareStatement("select * from endereco");
			ResultSet rs = stmt.executeQuery();

			ArrayList<Endereco> enderecos = new ArrayList<Endereco>();

			while (rs.next()) {
				Endereco endereco = new Endereco();

				endereco.setCod_end(rs.getInt("cod_end"));
				endereco.setCep(rs.getInt("cep"));
				endereco.setRua(rs.getString("rua"));
				endereco.setNum_end(rs.getString("num_end"));
				endereco.setBairro(rs.getString("bairro"));
				endereco.setCidade(rs.getString("cidade"));
				endereco.setEstado(rs.getString("estado"));
				endereco.setComplemento(rs.getString("complemento"));

				enderecos.add(endereco);
			}

			rs.close();
			stmt.close();

			return enderecos;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int incluirEndereco(Endereco endereco) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into endereco(cep,rua,num_end,bairro,cidade,estado,complemento)"
							+ "values ( ?,?,?,?,?,?,? )");

			stmt.setInt(1, endereco.getCep());
			stmt.setString(2, endereco.getRua());
			stmt.setString(3, endereco.getNum_end());
			stmt.setString(4, endereco.getBairro());
			stmt.setString(5, endereco.getCidade());
			stmt.setString(6, endereco.getEstado());
			stmt.setString(7, endereco.getComplemento());

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int excluirEndereco(Endereco endereco) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("delete from endereco where cod_end = ?");

			stmt.setInt(1, endereco.getCod_end());
			;

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public int alterarEndereco(Endereco endereco) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"update endereco set cep = ?, rua = ?, num_end = ?, bairro = ?, cidade = ?, estado = ?, complemento = ? where cod_end = ?");

			stmt.setInt(1, endereco.getCep());
			stmt.setString(2, endereco.getRua());
			stmt.setString(3, endereco.getNum_end());
			stmt.setString(4, endereco.getBairro());
			stmt.setString(5, endereco.getCidade());
			stmt.setString(6, endereco.getEstado());
			stmt.setString(7, endereco.getComplemento());
			stmt.setString(8, endereco.getNum_end());
			
			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
