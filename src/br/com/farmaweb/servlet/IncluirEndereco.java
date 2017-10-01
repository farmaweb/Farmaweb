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

@WebServlet("/incluirEndereco")
public class IncluirEndereco extends HttpServlet {

	private static final long serialVersionUID = -8719919992473646719L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cep = Integer.parseInt(req.getParameter("cep"));
		String rua = req.getParameter("rua");
		String numero = req.getParameter("numero");
		String bairro = req.getParameter("bairro");
		String cidade = req.getParameter("cidade");
		String estado = req.getParameter("estado");
		String complemento = req.getParameter("complemento");

		Endereco endereco = new Endereco();

		endereco.setCep(cep);
		endereco.setRua(rua);
		endereco.setNumero(numero);
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
