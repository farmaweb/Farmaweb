package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.farmaweb.daos.FarmaciaDao;
import br.com.farmaweb.daos.ProdutoDao;
import br.com.farmaweb.models.Login;
import br.com.farmaweb.models.Produto;

@WebServlet("/incluirProduto")
public class IncluirProduto extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String nome_produto = req.getParameter("nome_produto");
		String descricao_produto = req.getParameter("descricao_produto");
		int quantidade_produto = Integer.parseInt(req.getParameter("quantidade_produto"));
		Double preco_unitario = Double.parseDouble(req.getParameter("preco_unitario"));

		Integer cod_farm_prod = 0;

		try {
			FarmaciaDao farmaciadao = new FarmaciaDao();
			HttpSession session = req.getSession();
			Login usuarioLogado = (Login) session.getAttribute("usuarioLogado");
			cod_farm_prod = farmaciadao.retornaCodFarm(usuarioLogado.getCod_login());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		Produto produto = new Produto();
		produto.setNome_produto(nome_produto);
		produto.setDescricao_produto(descricao_produto);
		produto.setQuantidade_produto(quantidade_produto);
		produto.setPreco_unitario(preco_unitario);
		produto.setCod_farm_prod(cod_farm_prod);

		try {
			ProdutoDao produtoDao = new ProdutoDao();
			produtoDao.incluirProduto(produto);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = req.getRequestDispatcher("/listaProduto");
		rd.forward(req, resp);
	}
}
