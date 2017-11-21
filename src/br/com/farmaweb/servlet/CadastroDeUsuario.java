package br.com.farmaweb.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.farmaweb.daos.ClienteDao;
import br.com.farmaweb.daos.LoginDao;
import br.com.farmaweb.models.Cliente;
import br.com.farmaweb.models.Login;

@WebServlet("/cadastrarUsuario")
public class CadastroDeUsuario extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3742936888899167660L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//Login
		String usuario = req.getParameter("usuario");
		String senha = req.getParameter("senha");
		int tipo = Integer.parseInt(req.getParameter("tipo"));
		
		//Cliente
		String nome_cliente = req.getParameter("nome_cliente");
		Long cpf_cliente = Long.parseLong(req.getParameter("cpf_cliente").replace("-", "").replace(".", "").replace(".", "").trim());
		String email_cliente = req.getParameter("email_cliente");
		Long tel_cliente = Long.parseLong(req.getParameter("tel_cliente").replace("-", "").trim());
		
		
		Login login = new Login();
		login.setUsuario(usuario);
		login.setSenha(senha);
		login.setTipo(tipo);
		
		try {
			LoginDao logindao = new LoginDao();
			
			if(logindao.verificaLogin(usuario) == true) return;
			
			int cod_login = logindao.incluirUsuario(login);
			
			Cliente cliente = new Cliente();
			cliente.setCod_cliente(cod_login);
			cliente.setNome_cliente(nome_cliente);
			cliente.setCpf_cliente(cpf_cliente);
			cliente.setEmail_cliente(email_cliente);
			cliente.setTel_cliente(tel_cliente);
			
			ClienteDao clientedao = new ClienteDao();
			clientedao.incluirCliente(cliente);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		req.setAttribute("verificaResultado", 1);
		RequestDispatcher rd = req.getRequestDispatcher("/");
		rd.forward(req, resp);
	}
}
