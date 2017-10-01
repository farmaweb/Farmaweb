package br.com.farmaweb.models;

public class Login {

	private int cod_login;
	private String usuario;
	private String senha;
	private int tipo;
	
	
	public int getCod_login() {
		return cod_login;
	}
	public void setCod_login(int cod_login) {
		this.cod_login = cod_login;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
	public int getTipo() {
		return tipo;
	}
	public void setTipo(int tipo) {
		this.tipo = tipo;
	}

	

}
