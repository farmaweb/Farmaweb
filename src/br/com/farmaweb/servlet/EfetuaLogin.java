package br.com.farmaweb.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.farmaweb.daos.FuncionarioDao;
import br.com.farmaweb.daos.LoginDao;
import br.com.farmaweb.models.Login;

@WebServlet("/login")
public class EfetuaLogin extends HttpServlet {

	private static final long serialVersionUID = 412773056278474514L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		String login = req.getParameter("usuario");
		String senha = req.getParameter("senha");

		LoginDao loginDao = null;

		try {
			loginDao = new LoginDao();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		Login usuario = loginDao.buscaUsuario(login, senha);
		
		if (usuario != null) {		
			HttpSession session = req.getSession();
			session.setAttribute("usuarioLogado", usuario);

			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/home.jsp");
			rd.forward(req, res);
		} else {
			req.setAttribute("verificaResultado",0);
			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/login.jsp");
			rd.forward(req, res);
		}
	}

}
