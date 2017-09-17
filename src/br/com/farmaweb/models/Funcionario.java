package br.com.farmaweb.models;

public class Funcionario {

	private int cod_func;
	private Long matr_func;
	private String nome_func;
	private Long tel_func;
	private String funcao;
	private int cod_login_func;
	private int cod_farm_func;

	public int getCod_func() {
		return cod_func;
	}

	public void setCod_func(int cod_func) {
		this.cod_func = cod_func;
	}

	public Long getMatr_func() {
		return matr_func;
	}

	public void setMatr_func(Long matr_func) {
		this.matr_func = matr_func;
	}

	public String getNome_func() {
		return nome_func;
	}

	public void setNome_func(String nome_func) {
		this.nome_func = nome_func;
	}

	public Long getTel_func() {
		return tel_func;
	}

	public void setTel_func(Long tel_func) {
		this.tel_func = tel_func;
	}

	public String getFuncao() {
		return funcao;
	}

	public void setFuncao(String funcao) {
		this.funcao = funcao;
	}

	public int getCod_login_func() {
		return cod_login_func;
	}

	public void setCod_login_func(int cod_login_func) {
		this.cod_login_func = cod_login_func;
	}

	public int getCod_farm_func() {
		return cod_farm_func;
	}

	public void setCod_farm_func(int cod_farm_func) {
		this.cod_farm_func = cod_farm_func;
	}

}
