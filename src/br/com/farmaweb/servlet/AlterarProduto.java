package br.com.farmaweb.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
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
@MultipartConfig(maxFileSize = 5242880,maxRequestSize=5242880)
public class AlterarProduto extends HttpServlet {

	private static final long serialVersionUID = 1067151462180552850L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		String nome_produto = req.getParameter("nome_produto_alterar");
		String marca_fabricante = req.getParameter("marca_fabricante_alterar");
		String caracteristica = req.getParameter("caracteristica_alterar");
		String descricao_produto = req.getParameter("descricao_produto_alterar");
		String quantidade_produto = req.getParameter("quantidade_produto_alterar");
		String receita = req.getParameter("receita_alterar");
		String preco_unitario = req.getParameter("preco_unitario_alterar");
		String desconto = req.getParameter("desconto_alterar");
		String cod_produto = req.getParameter("cod_produto_alterar");
		
		InputStream inputStream = null;

		Part filePart = req.getPart("foto_produto_alterar");
		if (filePart != null) {
			inputStream = filePart.getInputStream();
		}


		Produto produto = new Produto();
		produto.setNome_produto(nome_produto);
		produto.setMarca_fabricante(marca_fabricante);
		produto.setCaracteristica(caracteristica);
		produto.setDescricao_produto(descricao_produto);
		produto.setQuantidade_produto(Integer.parseInt(quantidade_produto));
		produto.setReceita(Integer.parseInt(receita));
		produto.setPreco_unitario(Double.parseDouble(preco_unitario));
		produto.setDesconto(Integer.parseInt(desconto));
		produto.setFoto_produto(inputStream);
		produto.setCod_produto(Integer.parseInt(cod_produto));

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
