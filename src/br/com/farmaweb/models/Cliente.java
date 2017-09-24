package br.com.farmaweb.models;

public class Cliente {
	
	private int cod_cliente;
	private String nome_cliente;
	private Long cpf_cliente;
	private String email_cliente;
	private Long tel_cliente;

	public int getCod_cliente() {
		return cod_cliente;
	}

	public void setCod_cliente(int cod_cliente) {
		this.cod_cliente = cod_cliente;
	}

	public String getNome_cliente() {
		return nome_cliente;
	}

	public void setNome_cliente(String nome_cliente) {
		this.nome_cliente = nome_cliente;
	}

	public Long getCpf_cliente() {
		return cpf_cliente;
	}

	public void setCpf_cliente(Long cpf_cliente) {
		this.cpf_cliente = cpf_cliente;
	}

	public String getEmail_cliente() {
		return email_cliente;
	}

	public void setEmail_cliente(String email_cliente) {
		this.email_cliente = email_cliente;
	}

	public Long getTel_cliente() {
		return tel_cliente;
	}

	public void setTel_cliente(Long tel_cliente) {
		this.tel_cliente = tel_cliente;
	}

}
