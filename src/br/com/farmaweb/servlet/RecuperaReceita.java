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
import br.com.farmaweb.daos.PedidoDao;
import br.com.farmaweb.daos.ProdutoDao;
import br.com.farmaweb.models.Login;

@WebServlet("/recuperaReceita")
public class RecuperaReceita extends HttpServlet {
	
	private static final long serialVersionUID = -1336757859500453140L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		PedidoDao pedidoDao;
		
		byte[] imagemStream ;
		
		try {
			
			pedidoDao = new PedidoDao();

			imagemStream = pedidoDao.recuperaReceita(Integer.parseInt(req.getParameter("cod_pedido")));
			
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
