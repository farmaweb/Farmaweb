package br.com.farmaweb.models;

public class Pedido {
	private int cod_pedido;
	private String status;
	private Double valor_total;
	private Double valor_desconto;
	private String data_pedido;
	private int cod_pag_ped;
	private int cod_cli_ped;
	private int cod_func;

	public int getCod_pedido() {
		return cod_pedido;
	}

	public void setCod_pedido(int cod_pedido) {
		this.cod_pedido = cod_pedido;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Double getValor_total() {
		return valor_total;
	}

	public void setValor_total(Double valor_total) {
		this.valor_total = valor_total;
	}

	public Double getValor_desconto() {
		return valor_desconto;
	}

	public void setValor_desconto(Double valor_desconto) {
		this.valor_desconto = valor_desconto;
	}

	public String getData_pedido() {
		return data_pedido;
	}

	public void setData_pedido(String data_pedido) {
		this.data_pedido = data_pedido;
	}

	public int getCod_pag_ped() {
		return cod_pag_ped;
	}

	public void setCod_pag_ped(int cod_pag_ped) {
		this.cod_pag_ped = cod_pag_ped;
	}

	public int getCod_cli_ped() {
		return cod_cli_ped;
	}

	public void setCod_cli_ped(int cod_cli_ped) {
		this.cod_cli_ped = cod_cli_ped;
	}

	public int getCod_func() {
		return cod_func;
	}

	public void setCod_func(int cod_func) {
		this.cod_func = cod_func;
	}

}
