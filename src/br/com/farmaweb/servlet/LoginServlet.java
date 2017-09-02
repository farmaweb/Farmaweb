package br.com.farmaweb.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
		urlPatterns = { 
			"/login"
		})
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 412773056278474514L;
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
              throws ServletException, IOException {
		
		 RequestDispatcher rd = req.getRequestDispatcher("views/login.jsp");
	     rd.forward(req, res);
	     
    }
}
