package com.ukefu.webim.service.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.KnowledgeType;

public abstract interface KnowledgeTypeRepository extends
		JpaRepository<KnowledgeType, String> {
	
	public abstract KnowledgeType findByIdAndOrgi(String id, String orgi);

	public abstract int countByNameAndOrgiAndIdNot(String name, String orgi , String id);
	
	public abstract int countByNameAndOrgiAndParentidNot(String name, String orgi , String parentid);
	
	public abstract List<KnowledgeType> findByOrgi(String orgi) ;

	public abstract KnowledgeType findByNameAndOrgi(String name, String orgi);

	public abstract KnowledgeType findByNameAndOrgiAndIdNot(String name, String orgi, String id);

}
