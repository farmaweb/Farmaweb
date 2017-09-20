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

@WebServlet("/listaFormaDePagamento")
public class ListarFormaDePagamento extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		FormaDePagamentoDao formadepagamentoDao = null;

		try {
			formadepagamentoDao = new FormaDePagamentoDao();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		ArrayList<FormaDePagamento> formasDePagamentos = formadepagamentoDao.getFormaDePagamentos();

		req.setAttribute("formasDePagamentos", formasDePagamentos);

		RequestDispatcher rd = req.getRequestDispatcher("views/listarFormaPagamento.jsp");
		rd.forward(req, res);
	}
}
