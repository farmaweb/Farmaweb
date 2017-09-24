package br.com.farmaweb.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.FormaDePagamentoDao;
import br.com.farmaweb.models.FormaDePagamento;

@WebServlet("/listaPedido")
public class ListarPedido extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		RequestDispatcher rd = req.getRequestDispatcher("views/listarPedido.jsp");
		rd.forward(req, res);
	}
}
