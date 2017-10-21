package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.FormaDePagamentoDao;
import br.com.farmaweb.models.FormaDePagamento;

@WebServlet("/incluirFormaDePagamento")
public class IncluirFormaDePagamento extends HttpServlet {

	private static final long serialVersionUID = -6798547943504796866L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cod_pagamento = Integer.parseInt(req.getParameter("cod_pagamento"));
		int cod_login = Integer.parseInt(req.getParameter("cod_login"));
		
		FormaDePagamentoDao formadepagamentoDao = null;

		try {
			formadepagamentoDao = new FormaDePagamentoDao();
			formadepagamentoDao.incluirFormaDePagamento(cod_pagamento,cod_login);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/listarFormaDePagamento.jsp");
		rd.forward(req, res);

	}
}
