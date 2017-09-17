package br.com.farmaweb.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoBanco {
	public static Connection getConnection() throws ClassNotFoundException {
        try {
        	Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://farmaweb.ddns.net/farmaweb?useSSL=false", "farmaweb", "123456");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
