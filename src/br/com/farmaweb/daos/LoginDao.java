package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import br.com.farmaweb.models.Login;
import br.com.farmaweb.utils.ConexaoBanco;

public class LoginDao {
	
	private Connection connection;

	public LoginDao() throws ClassNotFoundException {
		this.connection = new ConexaoBanco().getConnection();
	}
	
	
	
	public boolean buscaUsuario(String loginUsuario,String senhaUsuario) {
	     try {
	    	 
	         PreparedStatement stmt = this.connection.prepareStatement("select * from login where login='"+
	    	 loginUsuario+"' and "+ "senha='"+ senhaUsuario+"'");
	         ResultSet rs = stmt.executeQuery();
	 		 
	         Login login = new Login();	
	 		 
	 		 while (rs.next()) {
	             login.setLogin(rs.getString("login"));
	             login.setSenha(rs.getString("senha"));	 
	         }
	         
	         rs.close();
	         stmt.close();
	         
	         if(login.getLogin() != null && login.getSenha() != null) {
	        	 return true;
	         }else {
	        	 return false;
	         }
	        
	     } catch (SQLException e) {
	    	 throw new RuntimeException(e);
	     }
	     
	 } 
}
