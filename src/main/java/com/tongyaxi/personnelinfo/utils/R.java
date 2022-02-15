package com.tongyaxi.personnelinfo.utils;

import java.util.HashMap;
import java.util.Map;

public class R {

	// 状态码
	private int code;
	
	// 提示信息
	private String msg;
	
	// 数据
	private Map<String,Object> map = new HashMap<String,Object>();

	public static R success() {
		R r = new R();
		r.setCode(200);
		r.setMsg("SUCCESS");
		return r;
	}
	
	public static R fail() {
		R r = new R();
		r.setCode(999);
		r.setMsg("FAIL");
		return r;
	}
	
	// 数据返回
	public R add(String key, Object value) {
		this.getMap().put(key, value);
		return this;
	}
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	
	
}
