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
import br.com.farmaweb.daos.FarmaciaDao;
import br.com.farmaweb.models.Endereco;
import br.com.farmaweb.models.Farmacia;

@WebServlet("/excluirEndereco")
public class ExcluirEndereco extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cod_end = Integer.parseInt(req.getParameter("cod_end"));

		Endereco endereco = new Endereco();

		endereco.setCod_end(cod_end);

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
