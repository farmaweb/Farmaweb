package br.com.farmaweb.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.farmaweb.daos.EnderecoDao;
import br.com.farmaweb.models.Login;

@WebServlet("/listarEndereco")
public class ListarEndereco extends HttpServlet {

	private static final long serialVersionUID = -8281046571361510390L;
	static int cod_login;
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/listarEndereco.jsp");
		rd.forward(req, res);
	}

}
