package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import br.com.farmaweb.daos.FarmaciaDao;
import br.com.farmaweb.models.Farmacia;

@WebServlet("/listarFarmacia")
public class ListarFarmacia extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		FarmaciaDao farmaciaDao = null;
		try {
			farmaciaDao = new FarmaciaDao();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

	     ArrayList <Farmacia> farmacias = farmaciaDao.listarFarmacias();
	        
	        req.setAttribute("farmacias", farmacias);
	            
	        RequestDispatcher rd = req.getRequestDispatcher("views/listarFarmacia.jsp");
	        rd.forward( req, res);

	}

}
