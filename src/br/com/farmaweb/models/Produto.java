package br.com.farmaweb.models;

public class Produto {
	private int cod_produto;
	private String nome_produto;
	private String marca_fabricante;
	private String caracteristica;
	private String descricao_produto;
	private int quantidade_produto;
	private int receita;
	private Double preco_unitario;
	private int desconto;
	private int cod_farm_prod;

	public int getCod_produto() {
		return cod_produto;
	}

	public void setCod_produto(int cod_produto) {
		this.cod_produto = cod_produto;
	}

	public String getNome_produto() {
		return nome_produto;
	}

	public void setNome_produto(String nome_produto) {
		this.nome_produto = nome_produto;
	}

	public String getMarca_fabricante() {
		return marca_fabricante;
	}

	public void setMarca_fabricante(String marca_fabricante) {
		this.marca_fabricante = marca_fabricante;
	}

	public String getCaracteristica() {
		return caracteristica;
	}

	public void setCaracteristica(String caracteristica) {
		this.caracteristica = caracteristica;
	}

	public String getDescricao_produto() {
		return descricao_produto;
	}

	public void setDescricao_produto(String descricao_produto) {
		this.descricao_produto = descricao_produto;
	}

	public int getQuantidade_produto() {
		return quantidade_produto;
	}

	public void setQuantidade_produto(int quantidade_produto) {
		this.quantidade_produto = quantidade_produto;
	}

	public int getReceita() {
		return receita;
	}

	public void setReceita(int receita) {
		this.receita = receita;
	}

	public Double getPreco_unitario() {
		return preco_unitario;
	}

	public void setPreco_unitario(Double preco_unitario) {
		this.preco_unitario = preco_unitario;
	}

	public int getDesconto() {
		return desconto;
	}

	public void setDesconto(int desconto) {
		this.desconto = desconto;
	}

	public int getCod_farm_prod() {
		return cod_farm_prod;
	}

	public void setCod_farm_prod(int cod_farm_prod) {
		this.cod_farm_prod = cod_farm_prod;
	}

}
