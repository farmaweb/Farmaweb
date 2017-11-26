package br.com.farmaweb.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import br.com.farmaweb.daos.EnderecoDao;
import br.com.farmaweb.models.Endereco;

@WebServlet("/buscarEndereco")
public class BuscarEndereco extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		Integer cod_endereco = Integer.parseInt(req.getParameter("cod_endereco"));
		try {
			EnderecoDao enderecoDao = new EnderecoDao();
			Endereco endereco = enderecoDao.getEndereco(cod_endereco);
			
			String json = new Gson().toJson(endereco);

			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().write(json);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
