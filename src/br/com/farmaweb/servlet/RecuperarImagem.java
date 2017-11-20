package br.com.farmaweb.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.farmaweb.daos.FarmaciaDao;
import br.com.farmaweb.daos.ProdutoDao;
import br.com.farmaweb.models.Login;

@WebServlet("/recuperaImagem")
public class RecuperarImagem extends HttpServlet {
	
	private static final long serialVersionUID = 8454833425392667043L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		ProdutoDao produtoDao;
		FarmaciaDao farmaciadao;
		Login usuarioLogado;
		int cod_farmacia;
		Integer cod_farm_prod = 0;
		byte[] imagemStream ;
		
		try {
			cod_farmacia = req.getParameter("cod_farmacia") == null ? 0 : Integer.parseInt(req.getParameter("cod_farmacia"));
			farmaciadao = new FarmaciaDao();
			HttpSession session = req.getSession();
			usuarioLogado = (Login) session.getAttribute("usuarioLogado");
			cod_farm_prod = farmaciadao.retornaCodFarm(usuarioLogado.getCod_login());
			
			produtoDao = new ProdutoDao();
			
			if(cod_farmacia > 0) {
				imagemStream = produtoDao.recuperaImagem( cod_farmacia , Integer.parseInt(req.getParameter("cod_produto")) );
			}else {
				imagemStream = produtoDao.recuperaImagem( cod_farm_prod , Integer.parseInt(req.getParameter("cod_produto")) );
			}
			
			
			res.setHeader("Cache-Control", "no-store");
			res.setHeader("Pragma", "no-cache");
			res.setDateHeader("Expires", 0);
			res.setContentType( "image/jpeg" );  
		    ServletOutputStream out = res.getOutputStream();  
		    out.write( imagemStream );  
		    out.flush();
		    
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
