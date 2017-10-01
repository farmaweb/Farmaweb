package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.FuncionarioDao;
import br.com.farmaweb.models.Funcionario;

@WebServlet("/excluirFuncionario")
public class ExcluirFuncionario extends HttpServlet {

	private static final long serialVersionUID = 38607483694338978L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cod_funcionario = Integer.parseInt(req.getParameter("cod_funcionario"));

		Funcionario funcionario = new Funcionario();

		funcionario.setCod_funcionario(cod_funcionario);

		FuncionarioDao funcionarioDao = null;

		try {
			funcionarioDao = new FuncionarioDao();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			funcionarioDao.excluirFuncionario(funcionario);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/listarFuncionario.jsp");
		rd.forward(req, res);

	}

}