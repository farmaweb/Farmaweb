package br.com.farmaweb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.farmaweb.models.Produto;
import br.com.farmaweb.utils.ConexaoBanco;

public class ProdutoDao {
	private Connection connection;

	public ProdutoDao() throws ClassNotFoundException {
		new ConexaoBanco();
		this.connection = ConexaoBanco.getConnection();
	}

	public ArrayList<Produto> getProdutos(int cod_login) {
		try {
			
			FarmaciaDao farmaciaDao = new FarmaciaDao();
			int cod_farm_prod = farmaciaDao.retornaCodFarm(cod_login);

			PreparedStatement stmt = this.connection.prepareStatement("select * from produto where cod_farm_prod = ? ");
			stmt.setInt(1, cod_farm_prod);
			
			ResultSet rs = stmt.executeQuery();

			ArrayList<Produto> produtos = new ArrayList<Produto>();

			while (rs.next()) {
				Produto produto = new Produto();

				produto.setCod_produto(rs.getInt("cod_produto"));
				produto.setNome_produto(rs.getString("nome_produto"));
				produto.setMarca_fabricante(rs.getString("marca_fabricante"));
				produto.setCaracteristica(rs.getString("caracteristica"));
				produto.setDescricao_produto(rs.getString("descricao_produto"));
				produto.setQuantidade_produto(rs.getInt("quantidade_produto"));
				produto.setReceita(rs.getInt("receita"));
				produto.setPreco_unitario(rs.getDouble("preco_unitario"));
				produto.setDesconto(rs.getInt("desconto"));
				produto.setCod_farm_prod(rs.getInt("cod_farm_prod"));
				
				produtos.add(produto);
			}
			
			rs.close();
			stmt.close();

			return produtos;
		} catch (SQLException | ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}
	
	public ArrayList<Produto> listaProdutoFarmacia(int cod_farmacia) {
		try {
			
			PreparedStatement stmt = this.connection.prepareStatement("select * from produto where cod_farm_prod = ? ");
			stmt.setInt(1, cod_farmacia);
			
			ResultSet rs = stmt.executeQuery();

			ArrayList<Produto> produtos = new ArrayList<Produto>();

			while (rs.next()) {
				Produto produto = new Produto();

				produto.setCod_produto(rs.getInt("cod_produto"));
				produto.setNome_produto(rs.getString("nome_produto"));
				produto.setMarca_fabricante(rs.getString("marca_fabricante"));
				produto.setCaracteristica(rs.getString("caracteristica"));
				produto.setDescricao_produto(rs.getString("descricao_produto"));
				produto.setQuantidade_produto(rs.getInt("quantidade_produto"));
				produto.setReceita(rs.getInt("receita"));
				produto.setPreco_unitario(rs.getDouble("preco_unitario"));
				produto.setDesconto(rs.getInt("desconto"));
				
				produtos.add(produto);
			}

			rs.close();
			stmt.close();

			return produtos;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public int getQuantidadeProduto(int cod_produto) {
		try {

			PreparedStatement stmt = this.connection.prepareStatement("select quantidade_produto from produto where cod_produto = ? ");
			stmt.setInt(1, cod_produto);
			
			ResultSet rs = stmt.executeQuery();

			int quantidade = 0;
					
			while (rs.next()) {
				quantidade = rs.getInt("quantidade_produto");
			}
			
			rs.close();
			stmt.close();

			return quantidade;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}


	public int alterarQuantidade(int cod_produto, int quantidade_nova) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"update produto set quantidade_produto = ? where cod_produto = ?");

			stmt.setInt(1, quantidade_nova);
			stmt.setInt(2, cod_produto);

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;

	public byte[] recuperaImagem(int cod_farmacia, int cod_produto) {
		try {			
			PreparedStatement stmt = this.connection.prepareStatement("select foto_produto from produto where cod_farm_prod = ? and cod_produto = ?");
			stmt.setInt(1, cod_farmacia);
			stmt.setInt(2, cod_produto);
			
			ResultSet rs = stmt.executeQuery();

			byte[] imagem = null;

			while (rs.next()) {
				imagem = rs.getBytes("foto_produto");
			}

			rs.close();
			stmt.close();

			return imagem;

		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	

	public int incluirProduto(Produto produto) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"insert into produto(nome_produto, marca_fabricante, caracteristica, descricao_produto, quantidade_produto, receita, preco_unitario, desconto, foto_produto, cod_farm_prod)"
							+ "values ( ?,?,?,?,?,?,?,?,?,? )");

			stmt.setString(1, produto.getNome_produto());
			stmt.setString(2, produto.getMarca_fabricante());
			stmt.setString(3, produto.getCaracteristica());
			stmt.setString(4, produto.getDescricao_produto());
			stmt.setInt(5, produto.getQuantidade_produto());
			stmt.setInt(6, produto.getReceita());
			stmt.setDouble(7, produto.getPreco_unitario());
			stmt.setInt(8, produto.getDesconto());
			if (produto.getFoto_produto() != null) {
                stmt.setBlob(9, produto.getFoto_produto());
            }
			stmt.setInt(10, produto.getCod_farm_prod());
			
			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int excluirProduto(Produto produto) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("delete from produto where cod_produto = ?");

			stmt.setInt(1, produto.getCod_produto());
			
			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public int alterarProduto(Produto produto) throws SQLException {
		try {
			PreparedStatement stmt = this.connection.prepareStatement(
					"update farmacia set nome_produto = ?, descricao_produto = ?, quatidade_produto = ?, preco_unitario = ?, cod_farm_prod = ? where cod_produto = ?");

			stmt.setString(1, produto.getNome_produto());
			stmt.setString(2, produto.getDescricao_produto());
			stmt.setInt(3, produto.getQuantidade_produto());
			stmt.setDouble(4, produto.getPreco_unitario());
			stmt.setInt(5, produto.getCod_farm_prod());

			int ret = stmt.executeUpdate();

			stmt.close();

			return ret;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
