package br.com.farmaweb.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import br.com.farmaweb.daos.PedidoDao;

@WebServlet("/buscarDetalhes")
public class BuscarDetalhes extends HttpServlet {


	/**
	 * 
	 */
	private static final long serialVersionUID = -6645508595858776016L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int cod_pedido = Integer.parseInt(req.getParameter("cod_pedido"));

		try {
			PedidoDao pedidoDao = new PedidoDao();
			ArrayList<HashMap<String, String>> detalhes = pedidoDao.buscaDetalhes(cod_pedido);

			String json = new Gson().toJson(detalhes);
			
			res.setContentType("application/json"); 
			res.setCharacterEncoding("UTF-8"); 
			res.getWriter().write(json); 
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
