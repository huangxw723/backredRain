package com.aoshi.util.excel;

import java.io.File;
import java.io.FileInputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 *  操作Excel的工具类
 * @author strong
 * @version 1.0
 * 2017年1月3日下午1:19:33
 */
public final class ExcelTools {
	
	/**
	 *转换MultipartFile为file
	 */
	public static List<List<Object>> readExcelTool(MultipartFile excel) throws Exception{
		CommonsMultipartFile cf= (CommonsMultipartFile)excel; 
        DiskFileItem fi = (DiskFileItem)cf.getFileItem(); 
        File file = fi.getStoreLocation();
        return readExcel(file);
	}
	
	
	/**
	 * 导出Excel方法
	 * @param titles 标题行
	 * @param sheetname 工作单名称
	 * @param excelFileName Excel的文件名
	 * @param data Excel中的数据
	 * @param response 响应对象
	 * @param request 请求对象
	 * @throws Exception
	 */
	public static void exportExcel(String[] titles, String sheetname,
					String excelFileName,
					List<?> data, HttpServletResponse response,   
					HttpServletRequest request) throws Exception{
		/** 创建工作簿 */
		XSSFWorkbook workbook = new XSSFWorkbook();
		/** 通过工作簿创建工作单 */
		XSSFSheet sheet = workbook.createSheet(sheetname);
		/** 创建第一行(标题行) */
		XSSFRow row = sheet.createRow(0);
		/** 循环创建第一行中需要列 */
		for (int i = 0; i < titles.length; i++){
			/** 通过行创建列 */
			XSSFCell cell = row.createCell(i);
			/** 设置列中的数据 */
			cell.setCellValue(titles[i]);
		}
		
		/** ################ 中间行的数据 ############# */
		for (int i = 0; i < data.size(); i++){
			/** 创建行 */
			row = sheet.createRow(i + 1);
			/** 获取集合中的元素 */
			Object obj = data.get(i);
			/** 获取对象中所有的Field */
			Field[] fields = obj.getClass().getDeclaredFields();
			/** 循环Field创建列 */
			for (int j = 0; j < fields.length; j++){
				/** 创建列 */
				XSSFCell cell = row.createCell(j);
				/** 获取字段 */
				Field field = fields[j];
				/** 设置该Field可以访问 */
				field.setAccessible(true);
				/** 获取Field的值 */
				Object value = field.get(obj);
				/** 设置列中的内容 */
				cell.setCellValue(value == null ? "" : value.toString());
			}
		}
		/** ################ 中间行的数据 ############# */
		// 响应过程
		// 服务器：utf-8 --> iso8859-1   firefox: iso8859-1  --> utf-8 (除了msie)
		// 服务器：gbk --> iso8859-1     msie: iso8859-1  --> gbk (msie)
		/** 获取浏览器类型 */
		String userAgent = request.getHeader("user-agent");
		String encoding = "utf-8";
		if (userAgent.toLowerCase().indexOf("msie") != -1){
			encoding = "gbk";
		}
		/** 下载的文件名是中文解决乱码 */
		excelFileName = new String(excelFileName.getBytes(encoding), "iso8859-1");
		/** 设置响应头指定下载的文件名 */
		response.setHeader("Content-Disposition", "attachment;filename=" + excelFileName + ".xls");
		/** 往浏览器输出工作簿 */
		workbook.write(response.getOutputStream());
		/** 关闭工作簿 */
		workbook.close();
	}
	
	/**
	 * 读取Excel
	 * @param excel 文件
	 * @return Excel中的数据
	 */
	public static List<List<Object>> readExcel(File excel) throws Exception{
		/** 创建工作簿 */
		XSSFWorkbook workbook = new XSSFWorkbook(new FileInputStream(excel));
		/** 获取一个工作单 */
		XSSFSheet sheet = workbook.getSheetAt(0);
		/** 获取最后一行的索引号 */
		int lastRowNum = sheet.getLastRowNum();
		/** 定义List封装Excel中的所有数据 */
		List<List<Object>> excelData = new ArrayList<>();
		/** 循环获取行 (第一行不要)*/
		for (int i = 1; i <= lastRowNum; i++){
			/** 获取一行 */
			XSSFRow row = sheet.getRow(i);
			/** 获取最后一列的索引号 row.getLastCellNum();*/
			/** 获取列的迭代器 */
			Iterator<Cell> cells = row.cellIterator();
			/** 定义List集合封装一行数据 */
			List<Object> rowData = new ArrayList<>();
			/** 迭代所有的列 */
			while (cells.hasNext()){
				/** 获取一列 */
				Cell cell = cells.next();
				/** 判断列的数据类型 */
				if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN){ // boolean
					rowData.add(cell.getBooleanCellValue());
				}else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC){ // number
					/** 判断是不是日期类型 */
					if (DateUtil.isCellDateFormatted(cell)){// date
						rowData.add(cell.getDateCellValue());
					}else{
						rowData.add(cell.getNumericCellValue());
					}
				}else{ // string
					rowData.add(cell.getStringCellValue());
				}
			}
			excelData.add(rowData);
		}
		return excelData;
	}
	
}
