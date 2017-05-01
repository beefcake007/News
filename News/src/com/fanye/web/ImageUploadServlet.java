package com.fanye.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.fanye.util.DateUtil;
import com.fanye.util.PropertiesUtil;

public class ImageUploadServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8 "); 
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out=response.getWriter();
		FileItemFactory factory=new DiskFileItemFactory();
		ServletFileUpload upload=new ServletFileUpload(factory);
		try {
			List<FileItem> list=upload.parseRequest(request);
			for(FileItem fileItem:list){
				String imageName=DateUtil.getCurrentDateStr();
				File file=new File(PropertiesUtil.getValue("imagePath")+imageName+"."+fileItem.getName().split("\\.")[1]);
				String newPath=PropertiesUtil.getValue("imageFile")+"/"+imageName+"."+fileItem.getName().split("\\.")[1];
				fileItem.write(file);
				String callback = request.getParameter("CKEditorFuncNum");
				out.println("<script type=\"text/javascript\">");
				out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + newPath + "',''" + ")");
				out.println("</script>");
				out.flush();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
