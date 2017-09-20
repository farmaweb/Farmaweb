package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.FarmaciaDao;
import br.com.farmaweb.daos.FormaDePagamentoDao;
import br.com.farmaweb.models.Farmacia;
import br.com.farmaweb.models.FormaDePagamento;

@WebServlet("/alterarFormaDePagamento")
public class AlterarFormaDePagamento extends HttpServlet {

	private static final long serialVersionUID = 765744418267103845L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cod_pag = Integer.parseInt(req.getParameter("cod_pag"));
		String tipo_pag = req.getParameter("tipo_pag");

		FormaDePagamento formadepagamento = new FormaDePagamento();

		formadepagamento.setCod_pag(cod_pag);
		formadepagamento.setTipo_pag(tipo_pag);

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
