package br.com.farmaweb.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.EnderecoDao;
import br.com.farmaweb.models.Endereco;

@WebServlet("/listarEndereco")
public class ListarEndereco extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		EnderecoDao enderecoDao = null;
		try {
			enderecoDao = new EnderecoDao();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

	     ArrayList <Endereco> enderecos = enderecoDao.listarEndereco();
	        
	        req.setAttribute("enderecos", enderecos);
	            
	        RequestDispatcher rd = req.getRequestDispatcher("views/listarEnderecos.jsp");
	        rd.forward( req, res);
	}
	
}
