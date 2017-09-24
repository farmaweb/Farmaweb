package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.EnderecoDao;
import br.com.farmaweb.models.Endereco;

@WebServlet("/excluirEndereco")
public class ExcluirEndereco extends HttpServlet {
	
	private static final long serialVersionUID = 8736375157574292032L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cod_endereco = Integer.parseInt(req.getParameter("cod_endereco"));

		Endereco endereco = new Endereco();

		endereco.setCod_endereco(cod_endereco);

		EnderecoDao enderecoDao = null;

		try {
			enderecoDao = new EnderecoDao();
			enderecoDao.excluirEndereco(endereco);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = req.getRequestDispatcher("views/listarEndereco.jsp");
		rd.forward(req, res);

	}
}
