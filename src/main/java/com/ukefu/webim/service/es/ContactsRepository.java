package com.ukefu.webim.service.es;

import java.util.List;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import com.ukefu.webim.service.es.ContactsEsCommonRepository;
import com.ukefu.webim.web.model.Contacts;

public interface ContactsRepository extends  ElasticsearchRepository<Contacts, String> , ContactsEsCommonRepository {
	public int countByPhoneAndOrgi(String phone,String orgi);
}
