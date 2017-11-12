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
		
		String rua_cliente = req.getParameter("rua_cliente");
		String numero_cliente = req.getParameter("numero_cliente");
		String complemento_cliente = req.getParameter("complemento_cliente");
		int cep_cliente = Integer.parseInt(req.getParameter("cep_cliente"));
		String bairro_cliente = req.getParameter("bairro_cliente");
		String cidade_cliente = req.getParameter("cidade_cliente");
		String estado_cliente = req.getParameter("estado_cliente");
		
		req.setAttribute("cod_farmacia", cod_farmacia);
		req.setAttribute("taxa_entrega", taxa_entrega);	
		req.setAttribute("tempo_entrega", tempo_entrega);
		
		req.setAttribute("rua_cliente", rua_cliente);
		req.setAttribute("numero_cliente", numero_cliente);
		req.setAttribute("complemento_cliente", complemento_cliente);
		req.setAttribute("cep_cliente", cep_cliente);
		req.setAttribute("bairro_cliente", bairro_cliente);
		req.setAttribute("cidade_cliente", cidade_cliente);
		req.setAttribute("estado_cliente", estado_cliente);
		
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/pedidoCliente.jsp");
		rd.forward(req, res);
	}
}
