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

@WebServlet("/excluirFormaDePagamento")
public class ExcluirFormaDePagamento extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cod_pagamento = Integer.parseInt(req.getParameter("cod_pagamento"));

		FormaDePagamento formadepagamento = new FormaDePagamento();

		formadepagamento.setCod_pagamento(cod_pagamento);

		FormaDePagamentoDao formadepagamentoDao = null;

		try {
			formadepagamentoDao = new FormaDePagamentoDao();
			formadepagamentoDao.excluirFormaDePagamento(formadepagamento);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = req.getRequestDispatcher("views/listarFormaPagamento.jsp");
		rd.forward(req, res);

	}
}
