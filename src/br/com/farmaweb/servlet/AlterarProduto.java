package br.com.farmaweb.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import br.com.farmaweb.daos.FarmaciaDao;
import br.com.farmaweb.daos.ProdutoDao;
import br.com.farmaweb.models.Login;
import br.com.farmaweb.models.Produto;

@WebServlet("/AlterarProduto")
public class AlterarProduto extends HttpServlet {

	private static final long serialVersionUID = 1067151462180552850L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		String nome_produto = req.getParameter("nome_produto");
		String marca_fabricante = req.getParameter("marca_fabricante");
		String caracteristica = req.getParameter("caracteristica");
		String descricao_produto = req.getParameter("descricao_produto");
		int quantidade_produto = Integer.parseInt(req.getParameter("quantidade_produto"));
		int receita = Integer.parseInt(req.getParameter("receita"));
		Double preco_unitario = Double.parseDouble(req.getParameter("preco_unitario"));
		int desconto = Integer.parseInt(req.getParameter("desconto"));
		int cod_produto = Integer.parseInt(req.getParameter("cod_produto"));
		
		InputStream inputStream = null;

		Part filePart = req.getPart("foto_produto");
		if (filePart != null) {
			inputStream = filePart.getInputStream();
		}


		Produto produto = new Produto();
		produto.setNome_produto(nome_produto);
		produto.setMarca_fabricante(marca_fabricante);
		produto.setCaracteristica(caracteristica);
		produto.setDescricao_produto(descricao_produto);
		produto.setQuantidade_produto(quantidade_produto);
		produto.setReceita(receita);
		produto.setPreco_unitario(preco_unitario);
		produto.setDesconto(desconto);
		produto.setFoto_produto(inputStream);
		produto.setCod_produto(cod_produto);

		try {
			ProdutoDao produtoDao = new ProdutoDao();
			produtoDao.alterarProduto(produto);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = req.getRequestDispatcher("/listaProduto");
		rd.forward(req, res);
	}

}
