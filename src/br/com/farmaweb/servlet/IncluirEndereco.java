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

@WebServlet("/incluirEndereco")
public class IncluirEndereco extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cep = Integer.parseInt(req.getParameter("cep"));
		String rua = req.getParameter("rua");
		String num_end = req.getParameter("num_end");
		String bairro = req.getParameter("bairro");
		String cidade = req.getParameter("cidade");
		String estado = req.getParameter("estado");
		String complemento = req.getParameter("complemento");

		Endereco endereco = new Endereco();

		endereco.setCep(cep);
		endereco.setRua(rua);
		endereco.setNum_end(num_end);
		endereco.setBairro(bairro);
		endereco.setCidade(cidade);
		endereco.setEstado(estado);
		endereco.setComplemento(complemento);

		EnderecoDao enderecoDao = null;

		try {
			enderecoDao = new EnderecoDao();
			enderecoDao.incluirEndereco(endereco);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = req.getRequestDispatcher("views/listarEnderecos.jsp");
		rd.forward(req, res);

	}
}
