package com.ukefu.util.es;


import static org.elasticsearch.common.xcontent.XContentFactory.jsonBuilder;

import java.io.IOException;

import org.elasticsearch.ElasticsearchException;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ukefu.core.UKDataContext;
import com.ukefu.webim.web.model.MetadataTable;
import com.ukefu.webim.web.model.TableProperties;

public class ESTools {
	private static final Logger log = LoggerFactory.getLogger(ESTools	.class); 
	public static boolean checkMapping(String tb,String orgi){
		return UKDataContext.getTemplet().typeExists(orgi, tb) ;
	}
	
	public static void mapping(MetadataTable tb , String orgi) throws ElasticsearchException, IOException{
		log.info(tb.getTablename()+" ORGI : "+orgi+" Mapping Not Exists , Waiting Form init ......");

		XContentBuilder builder = jsonBuilder().startObject()  
                .startObject(tb.getTablename().toLowerCase())
                .startObject("properties")  ;
		for(TableProperties tp:tb.getTableproperty()){
			builder.startObject(tp.getFieldname().toLowerCase()) ;
			if(tp.getDatatypename().equalsIgnoreCase("text") && !tp.getFieldname().equalsIgnoreCase("id")){
				builder.field("type", "string").field("store", "yes").field("index", tp.isToken() ? "analyzed":"not_analyzed") ;
				if(tp.isToken() && "keyword".equalsIgnoreCase(tp.getTokentype())){
					builder.field("analyzer" , "whitespace") ;
				}
				if(!tp.isToken()){
					builder.field("ignore_above" , "256") ;
				}
			}else if(tp.getDatatypename().equalsIgnoreCase("date") ){
				builder.field("type", "date").field("store", "yes").field("index", "not_analyzed").field("format","yyyy-MM-dd") ;
			}else if(tp.getDatatypename().equalsIgnoreCase("datetime")){
				builder.field("type", "date").field("store", "yes").field("index", "not_analyzed").field("format","yyyy-MM-dd HH:mm:ss") ;
			}else if(tp.getDatatypename().equalsIgnoreCase("textarea")){
				builder.field("type", "string").field("store", "yes").field("index", "analyzed") ;
			}else if(tp.getDatatypename().equalsIgnoreCase("nlp")){
				builder.field("type", "string").field("store", "yes").field("index", "not_analyzed").field("ignore_above" , "256") ;
			}else if(tp.getDatatypename().equalsIgnoreCase("url")){
				builder.field("type", "string").field("store", "yes").field("index", "analyzed") ;
			}else if(tp.getDatatypename().equalsIgnoreCase("email")){
				builder.field("type", "string").field("store", "yes").field("index", "analyzed") ;
			}else if(tp.getDatatypename().equalsIgnoreCase("number") ){
				builder.field("type", "float").field("store", "yes").field("index", "not_analyzed");
			}else if(tp.getDatatypename().equalsIgnoreCase("boolean") ){
				builder.field("type", "boolean").field("store", "yes").field("index", "not_analyzed");
			}else{
				builder.field("type", "string").field("store", "yes").field("index", tp.isToken() ? "analyzed":"not_analyzed") ;
			}
			builder.endObject() ;
		}
		builder.endObject().endObject().endObject();
        UKDataContext.getTemplet().putMapping(UKDataContext.SYSTEM_INDEX, tb.getTablename(), builder);

	}
}
