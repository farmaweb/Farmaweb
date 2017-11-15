package br.com.farmaweb.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import br.com.farmaweb.daos.ProdutoDao;

@WebServlet("/verificarQuantidade")
public class VerificarQuantidade extends HttpServlet {

	private static final long serialVersionUID = -318958681672575036L;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		String[] quantidade_produtos = req.getParameterValues("quantidadeCarrinho");
		String[] cod_produtos = req.getParameterValues("cod_produto_carrinho");
		String[] nome_produtos = req.getParameterValues("produtoCarrinho");

		ProdutoDao produtoDao = null;
		try {
			produtoDao = new ProdutoDao();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		for (int a = 0; a < cod_produtos.length; a++) {
			int quantidade_estoque = produtoDao.getQuantidadeProduto(Integer.parseInt(cod_produtos[a]));
			
			if(quantidade_estoque < Integer.parseInt(quantidade_produtos[a])) {
				String frase = "Lamentamos, possuimos somente " + quantidade_estoque +" unidade(s) do produto " +  nome_produtos[a] + " em nossos estoques!";
				String json = new Gson().toJson(frase);
				res.setContentType("application/json"); 
				res.setCharacterEncoding("UTF-8"); 
				res.getWriter().write(json);
	
			}
		}
	}
}
