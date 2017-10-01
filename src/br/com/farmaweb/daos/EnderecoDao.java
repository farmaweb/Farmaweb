package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import br.com.farmaweb.models.Endereco;
import br.com.farmaweb.utils.ConexaoBanco;

public class EnderecoDao {
	private Connection connection;

	public EnderecoDao() throws ClassNotFoundException {
		new ConexaoBanco();
		this.connection = ConexaoBanco.getConnection();
	}

	public ArrayList<Endereco> getEnderecos(int cod_cliente) {
		try {

			PreparedStatement stmt = this.connection.prepareStatement(
					"select e.cod_endereco, e.cep, e.rua, e.numero, e.bairro, e.cidade, e.estado, e.complemento from cliente as c inner join end_cli as ec on c.cod_cliente = ec.cod_cliente inner join endereco as e on e.cod_endereco = ec.cod_endereco where c.cod_cliente = ?");
			
			stmt.setInt(1, cod_cliente);

			ResultSet rs = stmt.executeQuery();

			ArrayList<Endereco> enderecos = new ArrayList<Endereco>();

			while (rs.next()) {
				Endereco endereco = new Endereco();

				endereco.setCod_endereco(rs.getInt("cod_endereco"));
				endereco.setCep(rs.getInt("cep"));
				endereco.setRua(rs.getString("rua"));
				endereco.setNumero(rs.getString("numero"));
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
			PreparedStatement stmt = this.connection
					.prepareStatement("insert into endereco(cep,rua,numero,bairro,cidade,estado,complemento)"
							+ "values ( ?,?,?,?,?,?,? )", Statement.RETURN_GENERATED_KEYS);

			stmt.setInt(1, endereco.getCep());
			stmt.setString(2, endereco.getRua());
			stmt.setString(3, endereco.getNumero());
			stmt.setString(4, endereco.getBairro());
			stmt.setString(5, endereco.getCidade());
			stmt.setString(6, endereco.getEstado());
			stmt.setString(7, endereco.getComplemento());

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

	public int excluirEndereco(Endereco endereco) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("delete from endereco where cod_endereco = ?");

			stmt.setInt(1, endereco.getCod_endereco());
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
					"update endereco set cep = ?, rua = ?, numero = ?, bairro = ?, cidade = ?, estado = ?, complemento = ? where cod_endereco = ?");

			stmt.setInt(1, endereco.getCep());
			stmt.setString(2, endereco.getRua());
			stmt.setString(3, endereco.getNumero());
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
}
