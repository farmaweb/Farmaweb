package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.farmaweb.models.Login;
import br.com.farmaweb.utils.ConexaoBanco;

public class LoginDao {
	
	private Connection connection;

	public LoginDao() {
		this.connection = new ConexaoBanco().getConnection();
	}
	
	public List<Login> getLista() {
	     try {
	         
	    	 List<Login> logins = new ArrayList<Login>();
	         PreparedStatement stmt = this.connection.prepareStatement("select * from login");
	         ResultSet rs = stmt.executeQuery();
	 
	         while (rs.next()) {
	            
	             Login login = new Login();
	             login.setId(rs.getInt("cod_login"));
	             login.setLogin(rs.getString("login"));
	             login.setSenha(rs.getString("senha"));
	 
	             logins.add(login);
	         }
	         
	         rs.close();
	         stmt.close();
	         return logins;
	     } catch (SQLException e) {
	         throw new RuntimeException(e);
	     }
	 }

	   
}
