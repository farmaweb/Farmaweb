package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import br.com.farmaweb.daos.FuncionarioDao;
import br.com.farmaweb.models.Funcionario;

@WebServlet("/BuscarFuncionario")
public class BuscarFuncionario extends HttpServlet {

	private static final long serialVersionUID = -5992505428216769311L;

	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Integer cod_funcionario = Integer.parseInt(req.getParameter("cod_funcionario"));

		try {
			FuncionarioDao funcionarioDao = new FuncionarioDao();
			Funcionario funcionario = funcionarioDao.getFuncionario(cod_funcionario);

			String json = new Gson().toJson(funcionario);

			res.setContentType("application/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().write(json);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	
}
