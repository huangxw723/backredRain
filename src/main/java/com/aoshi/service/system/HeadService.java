package com.aoshi.service.system;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.SqlSessionUtils;
import org.springframework.stereotype.Service;

import com.aoshi.dao.DaoSupport;

@Service("headService")
public class HeadService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	public List<String> getTable() throws Exception {
		SqlSessionTemplate st = (SqlSessionTemplate) dao.getSqlSessionTemplate();

		Connection connection = SqlSessionUtils.getSqlSession(st.getSqlSessionFactory(), st.getExecutorType(), st.getPersistenceExceptionTranslator()).getConnection();

		DatabaseMetaData dbmd = connection.getMetaData();
		ResultSet rs = dbmd.getTables(null, "fantang", null, null);
		List<String> tablenames = new ArrayList<String>();
		while (rs.next()) {
			String tableName = rs.getString("TABLE_NAME");
			tablenames.add(tableName);
		}
		return tablenames;

	}

	public List<String[]> getColumn(String tablename) throws Exception {
		SqlSessionTemplate st = (SqlSessionTemplate) dao.getSqlSessionTemplate();

		Connection connection = SqlSessionUtils.getSqlSession(st.getSqlSessionFactory(), st.getExecutorType(), st.getPersistenceExceptionTranslator()).getConnection();
		String sql = String.format("SELECT * FROM `%s` LIMIT 1", tablename);
		PreparedStatement stmt = connection.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		// DatabaseMetaData dbmd = connection.getMetaData();
		// ResultSet rs=dbmd.getColumns(null, null, tablename, null);
		ResultSetMetaData rsmd = rs.getMetaData(); // .getTables(null,
													// "fantang", null, null);
		List<String[]> fieldList = new ArrayList<String[]>();

		int count = rsmd.getColumnCount();
		for (int i = 1; i <= count; i++) {
			String columnName = rsmd.getColumnName(i);
			// int columnType = rsmd.getColumnType(i);
			String columnLabel = rsmd.getColumnLabel(i);
			// String columnTypeName = rsmd.getColumnTypeName(i);
			String columnClassName = rsmd.getColumnClassName(i);
			int isNullable = rsmd.isNullable(i);
			String[] str = new String[5];
			str[0] = columnName;
			str[1] = columnClassName;
			str[2] = columnLabel;
			str[3] = String.valueOf(isNullable);
			// str[4]=rsmd.
			fieldList.add(str);
		}
		return fieldList;

	}
}
