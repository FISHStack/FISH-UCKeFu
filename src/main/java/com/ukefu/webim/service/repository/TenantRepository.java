package com.ukefu.webim.service.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.Tenant;

public abstract interface TenantRepository extends JpaRepository<Tenant, String> {
	
	public abstract Tenant findById(String id);
	
}
