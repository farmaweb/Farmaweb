package br.com.farmaweb.filtro;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import br.com.farmaweb.models.Login;

@WebFilter("/*")
public class Filtro implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;

		HttpSession session = req.getSession();
		Login usuarioLogado = (Login) session.getAttribute("usuario.logado");

		String usuario = "<deslogado>";

		if (usuarioLogado != null) {
			usuario = usuarioLogado.getUsuario();
		}

		System.out.println("Usuario " + usuario + " acessando a URI " + req.getRequestURI());
		chain.doFilter(req, resp);
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
