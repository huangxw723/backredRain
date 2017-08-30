package com.aoshi.service.manage.consultation.brand;

import com.aoshi.common.asenum.CommonStr;
import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsBrandMapper;
import com.aoshi.domain.AsBrand;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import org.apache.shiro.codec.Base64;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Service
@Transactional
public class BrandService extends AsBaseService {
	@Autowired
	AsBrandMapper asBrandMapper;
	
	public List<AsBrand> queryList(AsBrand asBrand){
		return asBrandMapper.queryList(asBrand);
	}

	public List<AsBrand> queryAll(){
		return asBrandMapper.queryAll();
	}

	public int save(AsBrand asBrand,BaseController c) {
		initialized(c);
		String brandLogo = pd.getStringRequired("img");
		ValidatorBreakException.NOT_TRUE(!(brandLogo == null || brandLogo
				.trim().length() == 0 ||"".equals(brandLogo)), "请上传广告图片");
		uploadModule(UploadPathEnum.BRAND, "img");
		String brandLogoUrl = pd.getStringRequired("img");
		asBrand.setSortOrder("1");
		asBrand.setBrandLogo(brandLogoUrl);
		return asBrandMapper.insertSelective(asBrand);
	}

	public int deleteByBrandIds(String []ids){
		return asBrandMapper.deleteByBrandIds(ids);
	}

	public int deleteByPrimaryKey(Integer brandId){
		return asBrandMapper.deleteByPrimaryKey(brandId);
	}

	public AsBrand selectByPrimaryKey(Integer brandId){
		return asBrandMapper.selectByPrimaryKey(brandId);
	}

	public int updateByPrimaryKeySelective(AsBrand asBrand,BaseController c){
		initialized(c);
		String brandLogo = pd.getStringRequired("img");
		uploadModule(UploadPathEnum.BRAND, "img");
		String brandLogoUrl = pd.getStringRequired("img");
        if(!StringUtils.isEmpty(brandLogoUrl)){
            asBrand.setBrandLogo(brandLogoUrl);
        }
		return asBrandMapper.updateByPrimaryKeySelective(asBrand);
	}

	public String CheckFile(){
		String msg="";
		if (StringUtils.isNotBlank(req.getParameter("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			BufferedImage buffImage;
			try {
				InputStream io = new ByteArrayInputStream(bytes);
				buffImage = javax.imageio.ImageIO.read(io);
				if(buffImage.getWidth()> CommonStr.IMG_WIDTH || buffImage.getHeight()>CommonStr.IMG_HEIGHT)
					msg="图片尺寸大小超过限制！请上传"+CommonStr.IMG_WIDTH+"px"+"*"+CommonStr.IMG_HEIGHT+"px 的图片!";
				buffImage = javax.imageio.ImageIO.read(io);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return msg;
	}
}
