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


@WebServlet("/incluirFarmacia")
public class IncluirFarmacia extends HttpServlet {

	private static final long serialVersionUID = 2493436086519680293L;

	@Override
    protected void service(HttpServletRequest req, HttpServletResponse res)
              throws ServletException, IOException {
			
		//incluir endere�o farm�cia
		int cep = Integer.parseInt(req.getParameter("cep_farmacia"));
		String rua = req.getParameter("rua_farmacia");
		String numero = req.getParameter("numero");
		String bairro = req.getParameter("bairro_farmacia");
		String cidade = req.getParameter("cidade_farmacia");
		String estado = req.getParameter("estado_farmacia");
		String complemento = req.getParameter("complemento");
		Float taxa_entrega = Float.parseFloat(req.getParameter("taxa_entrega"));
		String tempo_entrega = req.getParameter("tempo_entrega");
		 
		Endereco endereco = new Endereco();
		endereco.setCep(cep);
		endereco.setRua(rua);
		endereco.setNumero(numero);
		endereco.setBairro(bairro);
		endereco.setCidade(cidade);
		endereco.setEstado(estado);
		endereco.setComplemento(complemento);
		
		String nome_fantasia = req.getParameter("nome_fantasia");
		String razao_social = req.getParameter("razao_social");
		Long cnpj = Long.parseLong(req.getParameter("cnpj").replace("-", "").replace("/", "").replace(".", "").replace(".", "").trim());
		Long tel_farmacia = Long.parseLong(req.getParameter("tel_farmacia"));
		String observacao = req.getParameter("observacao");
		
		Farmacia farmacia = new Farmacia();
		
		farmacia.setNome_fantasia(nome_fantasia);
		farmacia.setRazao_social(razao_social);
		farmacia.setCnpj(cnpj);
		farmacia.setTel_farmacia(tel_farmacia);
		farmacia.setObservacao(observacao);
		farmacia.setTaxaEntrega(taxa_entrega);
		farmacia.setTempo_entrega(tempo_entrega);
		
		FarmaciaDao farmaciaDao = null;
		EnderecoDao enderecoDao = null;
		
		try {
			enderecoDao = new EnderecoDao();
			int cod_endereco = enderecoDao.incluirEndereco(endereco);
			
			farmaciaDao = new FarmaciaDao();
			int cod_farm_func = farmaciaDao.incluirFarmacia(farmacia,cod_endereco);
			req.setAttribute("cod_farm_func",cod_farm_func);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		req.setAttribute("incluirClienteFarmacia",1);
		
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/login.jsp");
		rd.forward(req, res);
	    		
	}
}
