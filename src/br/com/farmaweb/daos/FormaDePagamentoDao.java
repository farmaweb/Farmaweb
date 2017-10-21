package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.farmaweb.models.FormaDePagamento;
import br.com.farmaweb.utils.ConexaoBanco;

public class FormaDePagamentoDao {
	private Connection connection;

	public FormaDePagamentoDao() throws ClassNotFoundException {
		new ConexaoBanco();
		this.connection = ConexaoBanco.getConnection();
	}

	public ArrayList<FormaDePagamento> getPagamentos(int cod_login) {
		try {
			
			FarmaciaDao farmaciaDao = new FarmaciaDao();
			int cod_farm_pag = farmaciaDao.retornaCodFarm(cod_login);

			PreparedStatement stmt = this.connection.prepareStatement("select p.cod_pagamento, p.tipo_pagamento from forma_pagamento as p inner join farm_pag as fp on p.cod_pagamento = fp.cod_pagamento inner join farmacia as f on f.cod_farmacia = fp.cod_farmacia and f.cod_farmacia = ?");
			stmt.setInt(1, cod_farm_pag);
			
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
		} catch (SQLException | ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}
	
	public ArrayList<FormaDePagamento> getAllPagamentos() {
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

	public int incluirFormaDePagamento(int cod_pagamento, int cod_login) throws SQLException {
		try {
			FarmaciaDao farmaciaDao = new FarmaciaDao();
			int cod_farmacia = farmaciaDao.retornaCodFarm(cod_login);

			PreparedStatement stmt = this.connection.prepareStatement("insert into farm_pag(cod_pagamento, cod_farmacia) values ( ?,? )");

			stmt.setInt(1, cod_pagamento);
			stmt.setInt(2, cod_farmacia);
			
			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException | ClassNotFoundException e) {
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
