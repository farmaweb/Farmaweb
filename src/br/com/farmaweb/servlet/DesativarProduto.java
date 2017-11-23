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
import br.com.farmaweb.daos.ProdutoDao;
import br.com.farmaweb.models.FormaDePagamento;
import br.com.farmaweb.models.Produto;

@WebServlet("/desativarProduto")
public class DesativarProduto extends HttpServlet {

	private static final long serialVersionUID = 4242586602541123601L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cod_produto = Integer.parseInt(req.getParameter("cod_produto"));

		try {
			ProdutoDao produtoDao = new ProdutoDao();
			produtoDao.desativarProduto(cod_produto);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = req.getRequestDispatcher("/listaProduto");
		rd.forward(req, res);

	}
}
