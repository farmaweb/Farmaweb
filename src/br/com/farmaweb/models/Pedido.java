package br.com.farmaweb.models;

import java.sql.Date;

public class Pedido {
	private int cod_pedido;
	private String status;
	private Double valorTotal;
	private Double valorDesconto;
	private String dataPedido;
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

	public Double getValorTotal() {
		return valorTotal;
	}

	public void setValorTotal(Double valorTotal) {
		this.valorTotal = valorTotal;
	}

	public Double getValorDesconto() {
		return valorDesconto;
	}

	public void setValorDesconto(Double valorDesconto) {
		this.valorDesconto = valorDesconto;
	}

	public String getDataPedido() {
		return dataPedido;
	}

	public void setDataPedido(String dataPedido) {
		this.dataPedido = dataPedido;
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
