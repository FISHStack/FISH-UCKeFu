package com.ukefu.webim.service.repository;

import com.ukefu.webim.web.model.Topic;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * author: jinxiangyi
 * date:   2018/2/1
 * description:
 */
public interface KnowledgeRepository extends JpaRepository<Topic, String> {

    @Query("select title as question from Topic where orgi = ?1 and top = 1 order by createtime desc")
    List<String> findByOrgi(String orgi);
}
