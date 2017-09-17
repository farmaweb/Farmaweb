package br.com.farmaweb.models;

public class Produto {
	private int cod_prod;
	private String nome_prod;
	private String desc_prod;
	private int quat_prod;
	private Double preco;
	private int cod_farm_prod;

	public int getCod_prod() {
		return cod_prod;
	}

	public void setCod_prod(int cod_prod) {
		this.cod_prod = cod_prod;
	}

	public String getNome_prod() {
		return nome_prod;
	}

	public void setNome_prod(String nome_prod) {
		this.nome_prod = nome_prod;
	}

	public String getDesc_prod() {
		return desc_prod;
	}

	public void setDesc_prod(String desc_prod) {
		this.desc_prod = desc_prod;
	}

	public int getQuat_prod() {
		return quat_prod;
	}

	public void setQuat_prod(int quat_prod) {
		this.quat_prod = quat_prod;
	}

	public Double getPreco() {
		return preco;
	}

	public void setPreco(Double preco) {
		this.preco = preco;
	}

	public int getCod_farm_prod() {
		return cod_farm_prod;
	}

	public void setCod_farm_prod(int cod_farm_prod) {
		this.cod_farm_prod = cod_farm_prod;
	}
}
