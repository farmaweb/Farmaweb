package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import br.com.farmaweb.models.Login;
import br.com.farmaweb.utils.ConexaoBanco;

public class LoginDao {
	
	private Connection connection;

	public LoginDao() throws ClassNotFoundException {
		new ConexaoBanco();
		this.connection = ConexaoBanco.getConnection();
	}
	
	
	
	public Login buscaUsuario(String loginUsuario,String senhaUsuario) {
	     try {
	    	 
	         PreparedStatement stmt = this.connection.prepareStatement("select * from login where usuario='"+
	    	 loginUsuario+"' and "+ "senha='"+ senhaUsuario+"' ");
	         ResultSet rs = stmt.executeQuery();
	 		 
	         Login login = new Login();	
	 		 
	 		 while (rs.next()) {
	 			 login.setCod_login(rs.getInt("cod_login"));
	             login.setUsuario(rs.getString("usuario"));
	             login.setSenha(rs.getString("senha"));
	             login.setTipo(rs.getInt("tipo"));
	         }
	         
	         rs.close();
	         stmt.close();
	         
	         if(login.getUsuario() != null && login.getSenha() != null) {
	        	 return login;
	         }else {
	        	 return null;
	         }
	        
	     } catch (SQLException e) {
	    	 throw new RuntimeException(e);
	     }
	     
	 }



	public int incluirUsuario(Login login) {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into login(usuario,senha,tipo)"
							+ "values ( ?, ?, ?)",Statement.RETURN_GENERATED_KEYS);

			stmt.setString(1, login.getUsuario());
			stmt.setString(2, login.getSenha());
			stmt.setInt(3, login.getTipo());
			
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
}
