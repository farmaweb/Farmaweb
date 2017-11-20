package br.com.farmaweb.servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.ProdutoDao;
import br.com.farmaweb.models.Produto;

public class ExibirImagem extends HttpServlet {

	private static final long serialVersionUID = -726513135710869258L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		try {
			ProdutoDao produtodao = new ProdutoDao();

			byte[] imagemStream = produtodao.recuperaImagem(1, Integer.parseInt(req.getParameter("imagem_id")));
	        res.setContentType( "image/jpeg" );
	        OutputStream out = res.getOutputStream();  
	        out.write( imagemStream );  
	        out.flush();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
