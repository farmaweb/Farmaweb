package br.com.farmaweb.models;

public class Farmacia {

	private int cod_farm;
	private String nome_fantasia;
	private String razao_social;
	private Long cnpj_farm;
	private Long tel_farm;
	private String observacao;
	private int cod_end_farm;

	public int getCod_farm() {
		return cod_farm;
	}

	public void setCod_farm(int cod_farm) {
		this.cod_farm = cod_farm;
	}

	public String getNome_fantasia() {
		return nome_fantasia;
	}

	public void setNome_fantasia(String nome_fantasia) {
		this.nome_fantasia = nome_fantasia;
	}

	public String getRazao_social() {
		return razao_social;
	}

	public void setRazao_social(String razao_social) {
		this.razao_social = razao_social;
	}

	public Long getCnpj_farm() {
		return cnpj_farm;
	}

	public void setCnpj_farm(Long cnpj_farm) {
		this.cnpj_farm = cnpj_farm;
	}

	public Long getTel_farm() {
		return tel_farm;
	}

	public void setTel_farm(Long tel_farm) {
		this.tel_farm = tel_farm;
	}

	public String getObservacao() {
		return observacao;
	}

	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}

	public int getCod_end_farm() {
		return cod_end_farm;
	}

	public void setCod_end_farm(int cod_end_farm) {
		this.cod_end_farm = cod_end_farm;
	}

}
