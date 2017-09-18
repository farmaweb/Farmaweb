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

@WebServlet("/alterarEndereco")
public class AlterarEndereco extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int cod_end = Integer.parseInt(req.getParameter("cod_end"));
		int cep = Integer.parseInt(req.getParameter("cep"));
		String rua = req.getParameter("rua");
		String num_end = req.getParameter("num_end");
		String bairro = req.getParameter("bairro");
		String cidade = req.getParameter("cidade");
		String estado = req.getParameter("estado");
		String complemento = req.getParameter("complemento");
		String observacao = req.getParameter("observacao");

		Endereco endereco = new Endereco();

		endereco.setCod_end(cod_end);
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
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			enderecoDao.alterarEndereco(endereco);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher rd = req.getRequestDispatcher("views/listarEndereco.jsp");
		rd.forward(req, res);
	}
}
