package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.EnderecoDao;
import br.com.farmaweb.daos.FarmaciaDao;
import br.com.farmaweb.daos.FormaDePagamentoDao;
import br.com.farmaweb.models.Endereco;
import br.com.farmaweb.models.FormaDePagamento;

@WebServlet("/incluirFormaDePagamento")
public class IncluirFormaDePagamento extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		String tipo_pagamento = req.getParameter("tipo_pagamento");

		FormaDePagamento formadepagamento = new FormaDePagamento();

		formadepagamento.setTipo_pagamento(tipo_pagamento);

		FormaDePagamentoDao formadepagamentoDao = null;

		try {
			formadepagamentoDao = new FormaDePagamentoDao();
			formadepagamentoDao.incluirFormaDePagamento(formadepagamento);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = req.getRequestDispatcher("views/listarFormaPagamento.jsp");
		rd.forward(req, res);

	}
}
