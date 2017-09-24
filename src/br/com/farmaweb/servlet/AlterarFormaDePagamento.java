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

@WebServlet("/alterarFormaDePagamento")
public class AlterarFormaDePagamento extends HttpServlet {

	private static final long serialVersionUID = 765744418267103845L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cod_pagamento = Integer.parseInt(req.getParameter("cod_pagamento"));
		String tipo_pagamento = req.getParameter("tipo_pagamento");

		FormaDePagamento formadepagamento = new FormaDePagamento();

		formadepagamento.setCod_pagamento(cod_pagamento);
		formadepagamento.setTipo_pagamento(tipo_pagamento);

		FormaDePagamentoDao formadepagamentoDao = null;

		try {
			formadepagamentoDao = new FormaDePagamentoDao();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			formadepagamentoDao.alterarFormaDePagamento(formadepagamento);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = req.getRequestDispatcher("views/listarFormaPagamento.jsp");
		rd.forward(req, res);

	}

}
