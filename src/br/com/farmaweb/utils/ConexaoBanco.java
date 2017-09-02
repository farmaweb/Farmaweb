package br.com.farmaweb.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoBanco {
	public Connection getConnection() {
        try {
            return DriverManager.getConnection("jdbc:mysql://farmaweb.ddns.net/farmaweb", "matheus", "123456");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
