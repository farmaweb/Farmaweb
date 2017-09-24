package br.com.farmaweb.servlet;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/listarFarmacia")
public class ListarFarmacia extends HttpServlet {

	private static final long serialVersionUID = 5205179580315633881L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		RequestDispatcher rd = req.getRequestDispatcher("views/listarFarmacia.jsp");
		rd.forward(req, res);

	}

}
