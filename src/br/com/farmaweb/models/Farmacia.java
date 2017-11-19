package br.com.farmaweb.models;

public class Farmacia {

	private int cod_farmacia;
	private String nome_fantasia;
	private String razao_social;
	private Long cnpj;
	private Long tel_farmacia;
	private String observacao;
	private Float taxa_entrega;
	private String tempo_entrega;	
	
	private int cod_end_farm;
	
	public int getCod_farmacia() {
		return cod_farmacia;
	}
	public void setCod_farmacia(int cod_farmacia) {
		this.cod_farmacia = cod_farmacia;
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
	public Long getCnpj() {
		return cnpj;
	}
	public void setCnpj(Long cnpj) {
		this.cnpj = cnpj;
	}
	public Long getTel_farmacia() {
		return tel_farmacia;
	}
	public void setTel_farmacia(Long tel_farmacia) {
		this.tel_farmacia = tel_farmacia;
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
	public Float getTaxaEntrega() {
		return taxa_entrega;
	}
	public void setTaxaEntrega(Float taxaeEntrega) {
		this.taxa_entrega = taxaeEntrega;
	}
	public String getTempo_entrega() {
		return tempo_entrega;
	}
	public void setTempo_entrega(String tempo_entrega) {
		this.tempo_entrega = tempo_entrega;
	}



}
