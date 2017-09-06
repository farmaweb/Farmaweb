package br.com.farmaweb.daos;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import br.com.farmaweb.models.Farmacia;
import br.com.farmaweb.utils.ConexaoBanco;

public class FarmaciaDao {
	
	private Connection connection;
	
	public FarmaciaDao() throws ClassNotFoundException {
		this.connection = new ConexaoBanco().getConnection();
	}
	
	public int incluirFarmacia(Farmacia farmacia) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into farmacia(nome_fantasia,razao_social,cnpj_farm,tel_farm,observacao,cod_end_farm)"
					+ "values ( ?,?,?,?,?,1 )");
			
			stmt.setString(1, farmacia.getNome_fantasia());
			stmt.setString(2, farmacia.getRazao_social());
			stmt.setInt(3, farmacia.getCnpj_farm());
		    stmt.setInt(4, farmacia.getTel_farm());
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
			PreparedStatement stmt = this.connection.prepareStatement(
					"delete from farmacia where cod_farm = ?");
			
			stmt.setInt(1, farmacia.getCod_farm());;
			
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
				"update farmacia set nome_fantasia = ?, razao_social = ?, cnpj_farm = ?, tel_farm = ?, observacao = ?, cod_end_farm = 1 where cod_farm = ?");
				
			stmt.setString(1, farmacia.getNome_fantasia());
			stmt.setString(2, farmacia.getRazao_social());
			stmt.setInt(3, farmacia.getCnpj_farm());
		    stmt.setInt(4, farmacia.getTel_farm());
		    stmt.setString(5, farmacia.getObservacao());
			stmt.setInt(6, farmacia.getCod_farm());
			
			int ret = stmt.executeUpdate();
		    
	        stmt.close();
		        
	        return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
	    }		
	}
}
