package br.com.farmaweb.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.LoginDao;

@WebServlet("/login")
public class Login extends HttpServlet {

	private static final long serialVersionUID = 412773056278474514L;

	@Override
    protected void service(HttpServletRequest req, HttpServletResponse res)
              throws ServletException, IOException {
		
   	    String login = req.getParameter("usuario");
	    String senha = req.getParameter("senha");
	    
	    LoginDao loginDao = null;
	    
		try {
			loginDao = new LoginDao();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	    
	    Boolean resultadoDaBusca = loginDao.buscaUsuario(login, senha);
	    
	    if(resultadoDaBusca == true) {
	    	res.sendRedirect("views/home.jsp");
	    }else {
	    	res.sendRedirect("views/acessonegado.jsp");
	    }
    }
	
}
