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


@WebServlet("/AlterarFuncionario")
public class AlterarFuncionario extends HttpServlet {
	
	private static final long serialVersionUID = -5464150701937824880L;

	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		Integer cod_funcionario = Integer.parseInt(req.getParameter("cod_funcionario"));
		String nome_funcionario = req.getParameter("nome_funcionario");
		Long tel_funcionario =  Long.parseLong(req.getParameter("tel_funcionario").replace("-", "").trim());
		String funcao =req.getParameter("funcao");
		
		Funcionario funcionario = new Funcionario();
		funcionario.setCod_funcionario(cod_funcionario);
		funcionario.setNome_funcionario(nome_funcionario);
		funcionario.setTel_funcionario(tel_funcionario);
		funcionario.setFuncao(funcao);
		
		try {
			FuncionarioDao funcionarioDao = new FuncionarioDao();
			funcionarioDao.alterarFuncionario(funcionario) ;
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/listarFuncionario.jsp");
		rd.forward(req, res);
	}


}
