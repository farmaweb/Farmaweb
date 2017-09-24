package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.farmaweb.models.Cliente;
import br.com.farmaweb.utils.ConexaoBanco;

public class ClienteDao {
	private Connection connection;

	public ClienteDao() throws ClassNotFoundException {
		
		new ConexaoBanco();
		this.connection = ConexaoBanco.getConnection();
	}

	public ArrayList<Cliente> getClientes() {
		try {

			PreparedStatement stmt = this.connection.prepareStatement("select * from cliente");
			ResultSet rs = stmt.executeQuery();

			ArrayList<Cliente> clientes = new ArrayList<Cliente>();

			while (rs.next()) {
				Cliente cliente = new Cliente();

				cliente.setCod_cliente(rs.getInt("cod_cliente"));
				cliente.setNome_cliente(rs.getString("nome_cliente"));
				cliente.setCpf_cliente(rs.getLong("cpf_cliente"));
				cliente.setEmail_cliente(rs.getString("email_cliente"));
				cliente.setTel_cliente(rs.getLong("tel_cliente"));

				clientes.add(cliente);
			}

			rs.close();
			stmt.close();

			return clientes;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int incluirCliente(Cliente cliente) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into cliente(cod_cliente,nome_cliente,cpf_cliente,email_cliente,tel_cliente)"
							+ "values ( ?,?,?,?,? )");

			stmt.setInt(1, cliente.getCod_cliente());
			stmt.setString(2, cliente.getNome_cliente());
			stmt.setLong(3, cliente.getCpf_cliente());
			stmt.setString(4, cliente.getEmail_cliente());
			stmt.setLong(5, cliente.getTel_cliente());

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int excluirEndereco(Cliente cliente) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("delete from cliente where cod_cliente = ?");

			stmt.setInt(1, cliente.getCod_cliente());
			;

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public int alterarCliente(Cliente cliente) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"update cliente set cod_cliente = ?, nome_cliente = ?, cpf_cliente = ?, email_cliente = ?, tel_cliente = ?");

			stmt.setInt(1, cliente.getCod_cliente());
			stmt.setString(2, cliente.getNome_cliente());
			stmt.setLong(3, cliente.getCpf_cliente());
			stmt.setString(4, cliente.getEmail_cliente());
			stmt.setLong(5, cliente.getTel_cliente());
			
			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
