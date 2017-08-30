package com.aoshi.controller.manage.consultation.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.aoshi.dao.AsConsultationFoodMapper;
import com.aoshi.domain.AsConsultationFood;
import com.aoshi.util.excel.ExcelTools;

/**
 * excel导入数据
 * @author strong
 * @version 1.0
 * 2017年1月4日下午1:22:06
 */
@Controller
@RequestMapping("excel")
public class ExcelController {
	
	/*@Autowired
	private ExcelService excelService;
	
	
	*//**
	 * 导入数据
	 *//*
	@RequestMapping("importExcel")
	@ResponseBody
	public Map<String,Object> excel(MultipartFile excel) throws Exception{
		CommonsMultipartFile cf= (CommonsMultipartFile)excel; 
        DiskFileItem fi = (DiskFileItem)cf.getFileItem(); 
        File file = fi.getStoreLocation();
		
		List<List<Object>> readExcel = ExcelTools.readExcel(file);
		excelService.importExcel(readExcel);
		
		Map<String,Object> map = new HashMap<String,Object>();
		// map.put("result", result);
	     map.put("status", "0");
	     map.put("msg", "操作成功！");
		return map;
	}*/
	
	@Autowired
	AsConsultationFoodMapper food;
	
	/**
	 * 导入数据
	 */
	@RequestMapping("importDoc")
	public String importDoc(MultipartFile excel) throws Exception{
		@SuppressWarnings("unchecked")
		List<AsConsultationFood> records = new ExcelBuilder<AsConsultationFood>()
				.setFile(excel)
				.setConverter(new FoodConverter()).build();
		for(AsConsultationFood f : records) {
			food.insert(f);
		}
		return null;
	}
	
	
	

	
}
