package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.FarmaciaDao;
import br.com.farmaweb.models.Farmacia;

@WebServlet("/excluirFarmacia")
public class ExcluirFarmacia extends HttpServlet {

	private static final long serialVersionUID = 5778343142547230571L;
	
	@Override
    protected void service(HttpServletRequest req, HttpServletResponse res)
              throws ServletException, IOException {
		
		int cod_farmacia = Integer.parseInt(req.getParameter("cod_farmacia"));
		
		Farmacia farmacia = new Farmacia();
		
		farmacia.setCod_farmacia(cod_farmacia);
		
		FarmaciaDao farmaciaDao = null;
		
		try {
			farmaciaDao = new FarmaciaDao();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			farmaciaDao.excluirFarmacia(farmacia);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		res.sendRedirect("/WEB-INF/views/sucesso.jsp");
		
	}

}
