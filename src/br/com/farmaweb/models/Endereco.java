package br.com.farmaweb.models;

public class Endereco {

	private int cod_end;
	private int cep;
	private String rua;
	private String num_end;
	private String bairro;
	private String cidade;
	private String estado;
	private String complemento;

	public int getCod_end() {
		return cod_end;
	}

	public void setCod_end(int cod_end) {
		this.cod_end = cod_end;
	}

	public int getCep() {
		return cep;
	}

	public void setCep(int cep) {
		this.cep = cep;
	}

	public String getRua() {
		return rua;
	}

	public void setRua(String rua) {
		this.rua = rua;
	}

	public String getNum_end() {
		return num_end;
	}

	public void setNum_end(String num_end) {
		this.num_end = num_end;
	}

	public String getBairro() {
		return bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getComplemento() {
		return complemento;
	}

	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}

}
