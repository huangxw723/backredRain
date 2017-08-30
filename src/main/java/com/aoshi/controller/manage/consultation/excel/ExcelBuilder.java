package com.aoshi.controller.manage.consultation.excel;

import java.io.File;
import java.util.List;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.aoshi.util.excel.ExcelTools;

public class ExcelBuilder<T> {
	
		MultipartFile file;
		
		File excelFile;
		
	
		private List<List<Object>> objects;

		private Converter converter; 
		
		public MultipartFile getFile() {
			return file;
		}

		public ExcelBuilder setFile(MultipartFile file) {
			this.file = file;
			return this;
		}

		public File getExcelFile() {
			return excelFile;
		}

		private ExcelBuilder setExcelFile(File excelFile) {
			this.excelFile = excelFile;
			return this;
		}

		public Converter getConverter() {
			return converter;
		}

		public ExcelBuilder setConverter(Converter converter) {
			this.converter = converter;
			return this;
		}
		
		@SuppressWarnings("unchecked")
		public List<T> build() throws Exception{
			translateFile();
			importExcelToObject();
			return converter.convert(objects);
		}

		private void importExcelToObject() throws Exception {
			// TODO Auto-generated method stub
			objects = ExcelTools.readExcel(excelFile);
		}

		private void translateFile() {
			// TODO Auto-generated method stub
			CommonsMultipartFile cf= (CommonsMultipartFile)file; 
	        DiskFileItem fi = (DiskFileItem)cf.getFileItem(); 
	        excelFile= fi.getStoreLocation();
		}
		
	

}
