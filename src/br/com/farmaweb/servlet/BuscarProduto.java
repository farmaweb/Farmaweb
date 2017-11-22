package br.com.farmaweb.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import br.com.farmaweb.daos.ProdutoDao;
import br.com.farmaweb.models.Produto;

@WebServlet("/BuscarProduto")
public class BuscarProduto extends HttpServlet{


	private static final long serialVersionUID = 6614027709740340287L;

	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Integer cod_produto = Integer.parseInt(req.getParameter("cod_produto"));

		try {
			ProdutoDao produtaoDao = new ProdutoDao();
			Produto produto = produtaoDao.getProduto(cod_produto);

			String json = new Gson().toJson(produto);

			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().write(json);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
