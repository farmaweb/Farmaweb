package br.com.farmaweb.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import br.com.farmaweb.daos.EnderecoDao;
import br.com.farmaweb.models.Endereco;

@WebServlet("/listaLatLong")
public class ConsultaLatLong extends HttpServlet {

	private static final long serialVersionUID = -2769374226961053867L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Object> listaLatLong = null;
		 	
		try {
			EnderecoDao enderecoDao = new EnderecoDao();
			listaLatLong = enderecoDao.getLatLong();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		String json = new Gson().toJson(listaLatLong);
		
		resp.setContentType("application/json"); 
		resp.setCharacterEncoding("UTF-8"); 
		resp.getWriter().write(json); 

	}
}
