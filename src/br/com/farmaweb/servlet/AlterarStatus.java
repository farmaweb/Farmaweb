package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.PedidoDao;

@WebServlet("/AlterarStatus")
public class AlterarStatus extends HttpServlet{

	private static final long serialVersionUID = 2060792020173345678L;
    
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		Integer cod_pedido = Integer.parseInt(req.getParameter("cod_pedido"));
		String status = req.getParameter("status");
		
		try {
			PedidoDao pedidoDao = new PedidoDao();
			pedidoDao.alterarStatus(cod_pedido, status);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
}
