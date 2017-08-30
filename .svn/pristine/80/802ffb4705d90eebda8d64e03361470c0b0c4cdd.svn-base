package com.aoshi.service.manage.yp;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.dao.AsImageSourceMapper;
import com.aoshi.domain.AsImageSource;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PropertyUtils;
import com.aoshi.util.UuidUtil;

@Service
@Transactional
public class ImageSourceService {
	@Autowired
	AsImageSourceMapper asImageSourceMapper;

	public List<AsImageSource> selectAll() {
		return asImageSourceMapper.selectAll();
	}

	public List<AsImageSource> selectByAttr(AsImageSource asImageSource) {
		return asImageSourceMapper.selectByAttr(asImageSource);
	}

	public int saveImageSource(AsImageSource imageSource,MultipartFile file) {
		boolean flag = false;
		String fileName = file.getOriginalFilename();
		String ftpFile = "";
		String ftpDir = Const.TEMPLATEPATHIMG;
		if(!StringUtils.isEmpty(fileName)){
			
			ftpFile = UuidUtil.get32UUID() + fileName.substring(fileName.indexOf("."),fileName.length());
			try {
				flag = ftpUpload(file.getBytes(), ftpFile,ftpDir);
				if(flag){
					imageSource.setImageUrl(ftpDir+"/"+ftpFile);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(StringUtils.isEmpty(imageSource.getImageSourceId())){
			imageSource.setCreateTime(DateUtil.getTime());
			return asImageSourceMapper.insertSelective(imageSource);
		}else{
			return asImageSourceMapper.updateByPrimaryKeySelective(imageSource);
		}
		
	}
	
	public AsImageSource selectByPrimaryKey(Integer imageSourceId){
		return asImageSourceMapper.selectByPrimaryKey(imageSourceId);
	}
	
	private boolean ftpUpload(byte[] bytes,String ftpFile,String ftpDir){
		String path = Const.FILEPATHIMGDIR + ftpDir;
		//byte[] bytes = Base64.decode(goodsImg);
		
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			ftpConManager.login(PropertyUtils.getFTP_URL(),
			PropertyUtils.getFTP_USERNAME(),
			PropertyUtils.getFTP_PASS());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ftpConManager.uploadFileByInputStream(new ByteArrayInputStream(bytes), path, ftpFile);
	}
	
	
}
