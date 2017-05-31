package com.ukefu.webim.web.handler.resouce;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.util.Menu;
import com.ukefu.util.UKTools;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.UploadStatus;

@Controller
@RequestMapping("/res")
public class MediaController extends Handler{
	
	@Value("${web.upload-path}")
    private String path;
	
    @RequestMapping("/image")
    @Menu(type = "resouce" , subtype = "image" , access = true)
    public void index(HttpServletResponse response, @Valid String id) throws IOException {
    	File file = new File(path ,id) ;
    	if(id.endsWith("_original") && !file.exists()){
    		File orgFile = new File(path , id.substring(0 , id.indexOf("_original"))) ;
    		if(orgFile.exists()){
    			orgFile.renameTo(file) ;
    		}
    		UKTools.processImage(id, orgFile, path) ;
    	}else if(!StringUtils.isBlank(id) && file.exists() && !id.endsWith("_original")){
    		File destFile = new File(path , id+"_original") ;
    		file.renameTo(destFile) ;
    		UKTools.processImage(id, destFile, path) ;
    	}else if(!StringUtils.isBlank(id) && !file.exists() && !id.endsWith("_original")){
    		File destFile = new File(path , id+"_original") ;
    		if(destFile.exists()){
    			UKTools.processImage(id, destFile, path) ;
    		}
    		file = new File(path , id) ;
    	}
    	if(file.exists() && file.isFile()){
    		response.getOutputStream().write(FileUtils.readFileToByteArray(new File(path ,id)));
    	}
    }
    
    @RequestMapping("/voice")
    @Menu(type = "resouce" , subtype = "voice" , access = true)
    public void voice(HttpServletResponse response, @Valid String id) throws IOException {
    	File file = new File(path ,id) ;
    	if(file.exists() && file.isFile()){
    		response.getOutputStream().write(FileUtils.readFileToByteArray(new File(path ,id)));
    	}
    }
    
    @RequestMapping("/url")
    @Menu(type = "resouce" , subtype = "image" , access = true)
    public void url(HttpServletResponse response, @Valid String url) throws IOException {
    	byte[] data = new byte[1024] ;
    	int length = 0 ;
    	OutputStream out = response.getOutputStream();
    	if(!StringUtils.isBlank(url)){
    		InputStream input = new URL(url).openStream() ;
    		while((length = input.read(data) )> 0){
    			out.write(data, 0, length);
    		}
    		input.close();
    	}
    }
    
    @RequestMapping("/image/upload")
    @Menu(type = "resouce" , subtype = "imageupload" , access = false)
    public ModelAndView upload(ModelMap map,HttpServletRequest request , @RequestParam(value = "imgFile", required = false) MultipartFile imgFile) throws IOException {
    	ModelAndView view = request(super.createRequestPageTempletResponse("/public/upload")) ; 
    	UploadStatus upload = null ;
    	String fileName = null ;
    	if(imgFile!=null && imgFile.getOriginalFilename().lastIndexOf(".") > 0){
    		File uploadDir = new File(path , "upload");
    		if(!uploadDir.exists()){
    			uploadDir.mkdirs() ;
    		}
    		fileName = "upload/"+UKTools.md5(imgFile.getBytes())+imgFile.getOriginalFilename().substring(imgFile.getOriginalFilename().lastIndexOf(".")) ;
    		FileCopyUtils.copy(imgFile.getBytes(), new File(path , fileName));
    		
    		String fileURL =  request.getScheme()+"://"+request.getServerName()+"/res/image.html?id="+fileName ;
    		if(request.getServerPort() == 80){
    			fileURL = request.getScheme()+"://"+request.getServerName()+"/res/image.html?id="+fileName;
			}else{
				fileURL = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/res/image.html?id="+fileName;
			}
    		upload = new UploadStatus("0" , fileURL); //图片直接发送给 客户，不用返回
    	}else{
    		upload = new UploadStatus("请选择图片文件");
    	}
    	map.addAttribute("upload", upload) ;
        return view ; 
    }
    
}