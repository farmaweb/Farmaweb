package br.com.farmaweb.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/pedidoCliente")
public class PedidoCliente extends HttpServlet{

	private static final long serialVersionUID = -3634820535266390079L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String cod_farmacia = req.getParameter("cod_farmacia");
		Float taxa_entrega = Float.parseFloat(req.getParameter("taxa_entrega"));
		String tempo_entrega = req.getParameter("tempo_entrega");
		
		req.setAttribute("cod_farmacia", cod_farmacia);
		req.setAttribute("taxa_entrega", taxa_entrega);	
		req.setAttribute("tempo_entrega", tempo_entrega);
		
		
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/pedidoCliente.jsp");
		rd.forward(req, res);
	}
}
