package br.com.farmaweb.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import br.com.farmaweb.daos.FarmaciaDao;
import br.com.farmaweb.models.Farmacia;

@WebServlet("/listarFarmaciasMapa")
public class ListarFarmaciasMapa extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		List<Farmacia> farmacias = null;
		try {
			FarmaciaDao farmaciaDao = new FarmaciaDao();
			farmacias = farmaciaDao.getFarmacias();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		
		String json = new Gson().toJson(farmacias);
		
		res.setContentType("application/json"); 
		res.setCharacterEncoding("UTF-8"); 
		res.getWriter().write(json); 	
	}
}
