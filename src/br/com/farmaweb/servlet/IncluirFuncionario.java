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

import br.com.farmaweb.daos.ClienteDao;
import br.com.farmaweb.daos.FarmaciaDao;
import br.com.farmaweb.daos.FuncionarioDao;
import br.com.farmaweb.daos.LoginDao;
import br.com.farmaweb.models.Cliente;
import br.com.farmaweb.models.Funcionario;
import br.com.farmaweb.models.Login;

@WebServlet("/incluirFuncionario")
public class IncluirFuncionario extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//Login
		String usuario = req.getParameter("usuario");
		String senha = req.getParameter("senha");
		int tipo = Integer.parseInt(req.getParameter("tipo"));
		
		//Funcionario
		String nome_funcionario = req.getParameter("nome_funcionario");
		Long matricula_funcionario = Long.parseLong(req.getParameter("matricula_funcionario"));
		Long tel_funcionario = Long.parseLong(req.getParameter("tel_funcionario"));
		String funcao = req.getParameter("funcao");
		Integer cod_farm_func = Integer.parseInt(req.getParameter("cod_farm_func"));
		
		if(cod_farm_func == 0) {
			try {
				FarmaciaDao farmaciadao = new FarmaciaDao();
				HttpSession session = req.getSession();
				Login usuarioLogado = (Login) session.getAttribute("usuarioLogado");
				cod_farm_func = farmaciadao.retornaCodFarm(usuarioLogado.getCod_login());
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
		
		Login login = new Login();
		login.setUsuario(usuario);
		login.setSenha(senha);
		login.setTipo(tipo);
		
		try {
			LoginDao logindao = new LoginDao();
			
			if(logindao.verificaLogin(usuario) == true) return;
			
			int cod_login = logindao.incluirUsuario(login);
			
			Funcionario funcionario = new Funcionario();
			
			funcionario.setCod_funcionario(cod_login);
			funcionario.setMatricula_funcionario(matricula_funcionario);
			funcionario.setNome_funcionario(nome_funcionario);
			funcionario.setTel_funcionario(tel_funcionario);
			funcionario.setFuncao(funcao);
			funcionario.setCod_farm_func(cod_farm_func);
			
			FuncionarioDao funcionarioDao = new FuncionarioDao();
			
			funcionarioDao.incluirFuncionario(funcionario);
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		RequestDispatcher rd = req.getRequestDispatcher("/login");
		rd.forward(req, resp);
	}
}
