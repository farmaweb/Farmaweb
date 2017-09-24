package br.com.farmaweb.models;

public class Funcionario {

	private int cod_funcionario;
	private Long matricula_funcionario;
	private String nome_funcionario;
	private Long tel_funcionario;
	private String funcao;
	private int cod_farm_func;

	public int getCod_funcionario() {
		return cod_funcionario;
	}

	public void setCod_funcionario(int cod_funcionario) {
		this.cod_funcionario = cod_funcionario;
	}
	
	public Long getMatricula_funcionario() {
		return matricula_funcionario;
	}

	public void setMatricula_funcionario(Long matricula_funcionario) {
		this.matricula_funcionario = matricula_funcionario;
	}
	

	public String getNome_funcionario() {
		return nome_funcionario;
	}

	public void setNome_funcionario(String nome_funcionario) {
		this.nome_funcionario = nome_funcionario;
	}

	public Long getTel_funcionario() {
		return tel_funcionario;
	}

	public void setTel_funcionario(Long tel_funcionario) {
		this.tel_funcionario = tel_funcionario;
	}

	public String getFuncao() {
		return funcao;
	}

	public void setFuncao(String funcao) {
		this.funcao = funcao;
	}

	public int getCod_farm_func() {
		return cod_farm_func;
	}

	public void setCod_farm_func(int cod_farm_func) {
		this.cod_farm_func = cod_farm_func;
	}

}
