package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.farmaweb.daos.FuncionarioDao;
import br.com.farmaweb.daos.LoginDao;
import br.com.farmaweb.models.Funcionario;

@WebServlet("/desativarLogin")
public class DesativarLogin extends HttpServlet {

	private static final long serialVersionUID = 38607483694338978L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cod_login = Integer.parseInt(req.getParameter("cod_login"));
		int cod_login_sessao = Integer.parseInt(req.getParameter("cod_login_sessao"));

		LoginDao loginDao = null;

		try {
			loginDao = new LoginDao();
			
			loginDao.desativarLogin(cod_login);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		if (cod_login == cod_login_sessao) {
			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/login.jsp");
			rd.forward(req, res);
		}else {
			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/listarFuncionario.jsp");
			rd.forward(req, res);
		}
	}

}