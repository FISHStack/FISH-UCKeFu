package com.ukefu.webim.util;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.*;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * author: jinxiangyi
 * date:   2017/11/27
 * description: HTTP调用工具类
 */
public class HttpClientUtil {

    private static Logger log = LoggerFactory.getLogger(HttpClientUtil.class);

    // 字符编码
    private static ThreadLocal<String> encodeMap = new ThreadLocal<String>();




    public static String post(String url, Map<String, String> params) {
        HttpPost httpPost = initHttpPost(url, params, null);
        return doPost(HttpClients.createDefault(), httpPost);
    }

    public static String post(String url, Map<String, String> params, String encode) {
        HttpPost httpPost = initHttpPost(url, params, encode);
        return doPost(HttpClients.createDefault(), httpPost);
    }

    private static String doPost(CloseableHttpClient httpClient, HttpPost httpPost) {
        try {
            HttpResponse response = httpClient.execute(httpPost);
            return EntityUtils.toString(response.getEntity(), encodeMap.get());
        } catch (ClientProtocolException e) {
            log.error("Http调用出错，客户端协议异常！", e);
            return null;
        } catch (IOException e) {
            throw new RuntimeException("Http调用出错！", e);
        } finally {
            try {
                httpClient.close();
            } catch (IOException e) {
                log.error("Http客户端未正常关闭！");
            }
        }
    }

    private static HttpPost initHttpPost(String url, Map<String, String> paraMap, String encode) throws RuntimeException {
        try {
            encodeMap.set("UTF-8");
            if (StringUtils.isNotBlank(encode)) {
                encodeMap.set(encode);
            }

            RequestConfig config = RequestConfig.custom()
                    .setConnectTimeout(5000)
                    .setConnectionRequestTimeout(5000)
                    .setSocketTimeout(5000)
                    .setRedirectsEnabled(true)
                    .build();
            HttpPost httpPost = new HttpPost(url);
            httpPost.setConfig(config);

            List<NameValuePair> parameters = new ArrayList<NameValuePair>();
            Set<String> keys = paraMap.keySet();
            for (String key : keys) {
                parameters.add(new BasicNameValuePair(key, paraMap.get(key)));
            }
            httpPost.setEntity(new UrlEncodedFormEntity(parameters, encodeMap.get()));
            return httpPost;
        } catch (UnsupportedEncodingException e) {
            log.error("HTTP调用出错，不支持的编码格式" + encodeMap.get(), e);
            throw new RuntimeException("HTTP调用出错，不支持的编码格式" + encodeMap.get());
        }
    }
}
