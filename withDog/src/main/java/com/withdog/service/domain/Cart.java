package com.withdog.service.domain;

import java.sql.Date;


public class Cart {
	
	private int cartNo;
	private User user;
	private Product product;
	private int cartQuantity;
	
	
	public Cart(){
	}


	public int getCartNo() {
		return cartNo;
	}


	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public Product getProduct() {
		return product;
	}


	public void setProduct(Product product) {
		this.product = product;
	}


	public int getCartQuantity() {
		return cartQuantity;
	}


	public void setCartQuantity(int cartQuantity) {
		this.cartQuantity = cartQuantity;
	}


	@Override
	public String toString() {
		return "Cart [cartNo=" + cartNo + ", user=" + user + ", product=" + product + ", cartQuantity=" + cartQuantity
				+ "]";
	}
	
	
	
	
	
}