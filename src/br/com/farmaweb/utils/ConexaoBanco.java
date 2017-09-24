package br.com.farmaweb.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoBanco {
	public static Connection getConnection() throws ClassNotFoundException {
        try {	
        	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
            return DriverManager.getConnection("jdbc:sqlserver://farmaweb.ddns.net\\sqlexpress;databaseName=FarmaWeb; user=sa; password=739700");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
