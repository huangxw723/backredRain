package com.aoshi.service.manage.integration;

import com.aoshi.common.asenum.DictParam;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsActivityAdMapper;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.domain.AsActivityAd;
import com.aoshi.domain.AsDictParam;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class ShopPointService extends AsBaseService {

	private final static String PAGE_PATH = "manage/integration/";
	// 数据库操作标识
	protected boolean operaFlag;
	@Autowired
	private AsDictParamMapper asDictParamMapper;
	@Autowired
	private AsActivityAdMapper asActivityAdMapper;

	/**
	 * 获取积分配置信息
	 * 
	 * @author wangjs
	 * @date 2016年11月23日
	 * @return
	 */
	public Object getSetPoint(BaseController c) {
		initialized(c);
		Map<String, String> pointMap = new HashMap<String, String>();

		AsDictParam asdDictParam1 = asDictParamMapper.findAllByKeyCode(DictParam.PARAM_INVITE_POINT);
		AsDictParam asdDictParam2 = asDictParamMapper.findAllByKeyCode(DictParam.PARAM_POIN_EXCHANGE);
		AsDictParam asdDictParam3 = asDictParamMapper.findAllByKeyCode(DictParam.PARAM_MONEY_EXCHANGE);

		AsDictParam asdDictParam4 = asDictParamMapper.findAllByKeyCode(DictParam.PAREM_REGIN_POINT);
		AsDictParam asdDictParam5 = asDictParamMapper.findAllByKeyCode(DictParam.PAREM_LOGIN_POINT);
		AsDictParam asdDictParam6 = asDictParamMapper.findAllByKeyCode(DictParam.PAREM_SHARE_POINT);

		pointMap.put("invitePointValue", asdDictParam1.getDictValue());
		pointMap.put("invitePointId", asdDictParam1.getDictParamId().toString());

		pointMap.put("exchangePointValue", asdDictParam2.getDictValue());
		pointMap.put("exchangePointId", asdDictParam2.getDictParamId().toString());

		pointMap.put("moneyPointValue", asdDictParam3.getDictValue());
		pointMap.put("moneyPointId", asdDictParam3.getDictParamId().toString());

		pointMap.put("reginPointValue", asdDictParam4.getDictValue());
		pointMap.put("reginPointId", asdDictParam4.getDictParamId().toString());

		pointMap.put("loginPointValue", asdDictParam5.getDictValue());
		pointMap.put("loginPointId", asdDictParam5.getDictParamId().toString());

		pointMap.put("sharePointValue", asdDictParam6.getDictValue());
		pointMap.put("sharePointId", asdDictParam6.getDictParamId().toString());

		List<Conditions> listasActiv = asActivityAdMapper.selectByPosType(3);
		addViewData("asdictParm", pointMap);
		addViewData("listasActiv", listasActiv);
		return renderView(PAGE_PATH + "setpoin");
	}

	/**
	 * 修改积分配置
	 * 
	 * @author wangjs
	 * @date 2016年11月23日
	 * @return
	 */
	//public Object updatePointTx(String pointId,String pointValue,MultipartFile[] files,String[] imgOldIds,String[] imgOldAdUrls,String[] imgNewAdurls,String imgNewOldImgIds,String imgNewOldAdUrls,MultipartFile[] oldFiles) {
	public Object updatePointTx(String pointId,String pointValue) {
		//initialized(c);
		String [] pointIds = pointId.split(",");
		String [] pointValues = pointValue.split(",");
		
/*		String [] imgNewOldImgId = imgNewOldImgIds.split(",");
		String [] imgNewOldAdUrl = imgNewOldAdUrls.split(",");
		
	
		
		
		
		if(imgOldIds.length>0){
			for (int i = 0; i < imgOldIds.length; i++) {
				AsActivityAd initActivityAd = initActivityAd();
				initActivityAd.setAdId(Integer.valueOf(imgOldIds[i]));
				initActivityAd.setAdUrl(imgOldAdUrls[i]);
				initActivityAd.setAdSn(null);
				operaFlag =	asActivityAdMapper.updateByPrimaryKeySelective(initActivityAd)==1;
				ValidatorBreakException.NOT_TRUE(operaFlag);
			}
		}
		*/
		AsDictParam asDictParam1 = new AsDictParam();
		AsDictParam asDictParam2 = new AsDictParam();
		AsDictParam asDictParam3 = new AsDictParam();
		AsDictParam asDictParam4 = new AsDictParam();
		AsDictParam asDictParam5 = new AsDictParam();
		AsDictParam asDictParam6 = new AsDictParam();

		String invitePointId = pointIds[0];
		String invitePointValue = pointValues[0];
		asDictParam1.setDictParamId(Integer.valueOf(invitePointId));
		asDictParam1.setDictValue(invitePointValue);

		String exchangePointId = pointIds[1];
		String exchangePointValue = pointValues[1];
		asDictParam2.setDictParamId(Integer.valueOf(exchangePointId));
		asDictParam2.setDictValue(exchangePointValue);

		String moneyPointId =pointIds[2];
		String moneyPointValue =  pointValues[2];
		asDictParam3.setDictParamId(Integer.valueOf(moneyPointId));
		asDictParam3.setDictValue(moneyPointValue);
		//判断兑换金额比是否改变，如果改变则更新积分商品的积分
		AsDictParam adp3 = asDictParamMapper.findAllByKeyCode(DictParam.PARAM_MONEY_EXCHANGE);
		if (!adp3.getDictValue().equals(moneyPointValue)){
			asDictParamMapper.updateSalesPrice(Integer.parseInt(moneyPointValue));
		}


		String reginPointId = pointIds[3];
		String reginPointValue = pointValues[3];
		asDictParam4.setDictParamId(Integer.valueOf(reginPointId));
		asDictParam4.setDictValue(reginPointValue);

		String loginPointId = pointIds[4];
		String loginPointValue =  pointValues[4];
		asDictParam5.setDictParamId(Integer.valueOf(loginPointId));
		asDictParam5.setDictValue(loginPointValue);

		String sharePointId = pointIds[5];
		String sharePointValue = pointValues[5];
		asDictParam6.setDictParamId(Integer.valueOf(sharePointId));
		asDictParam6.setDictValue(sharePointValue);
		
		//operaFlag = savePointImgs(files,imgNewAdurls,imgNewOldImgId,imgNewOldAdUrl,oldFiles)==1;
		//ValidatorBreakException.NOT_TRUE(operaFlag);
		
		operaFlag = asDictParamMapper.updateByPrimaryKeySelective(asDictParam1) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		
		operaFlag = asDictParamMapper.updateByPrimaryKeySelective(asDictParam2) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		
		operaFlag = asDictParamMapper.updateByPrimaryKeySelective(asDictParam3) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
	
		operaFlag = asDictParamMapper.updateByPrimaryKeySelective(asDictParam4) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		
		operaFlag = asDictParamMapper.updateByPrimaryKeySelective(asDictParam5) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		
		operaFlag = asDictParamMapper.updateByPrimaryKeySelective(asDictParam6) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		
		return renderSuccess();
	}

/*	public String CheckFile() {
		String msg = "";
		if (StringUtils.isNotBlank(req.getParameter("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			BufferedImage buffImage;
			try {
				InputStream io = new ByteArrayInputStream(bytes);
				buffImage = javax.imageio.ImageIO.read(io);
				if (buffImage.getWidth() > CommonStr.IMG_WIDTH || buffImage.getHeight() > CommonStr.IMG_HEIGHT)
					msg = "图片尺寸大小超过限制！请上传" + CommonStr.IMG_WIDTH + "px" + "*" + CommonStr.IMG_HEIGHT + "px 的图片!";
				buffImage = javax.imageio.ImageIO.read(io);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return msg;
	}*/

	/**
	 *	积分商城上传广告图片初始化
	 * 
	 * @author wangjs
	 * @date 2016年11月29日
	 * @return
	 */
	private AsActivityAd initActivityAd() {
		AsActivityAd asactivityad = new AsActivityAd();
		asactivityad.setAdUrlType(0);
		asactivityad.setAdType(1);
		asactivityad.setAdName("积分商城广告");
		asactivityad.setAdStartTime(DateUtil.getTime());
		asactivityad.setAdEndTime(DateUtil.getNextTime(DateUtil.getTime(), 168));
		asactivityad.setStatus(1);
		asactivityad.setAdPosType(3);
		String code = UUID.randomUUID().toString().replaceAll("-", "");
		asactivityad.setAdSn(code);
		return asactivityad;
	}

	/**
	 *	积分商城上传广告图片
	 * 
	 * @author wangjs
	 * @date 2016年11月29日
	 * @return
	 */
	public int savePointImgs(MultipartFile[] files,String[] imgNewAdurls,String[] imgNewOldImgIds,String[] imgNewOldAdUrls,MultipartFile[] oldFiles) {
		int a = 1;
		if(files.length>0){
		for (int j = 0; j < files.length; j++) {
			if (!StringUtils.isEmpty(files[j].getOriginalFilename())) {
				try {
					String imgNewAdurl=null;
					if(imgNewAdurls.length>0){
						 imgNewAdurl = imgNewAdurls[j];
					}
					int b =  goodsImgUpload(initActivityAd(), files[j].getBytes(),imgNewAdurl,null,null,"0");
					if(1!=b){
						a=0;
						return a;
					}
					
				} catch (IOException e) {
					e.printStackTrace();
					a=0;
				}
			}
		}}
		if(oldFiles.length>0){
			for (int j = 0; j < oldFiles.length; j++) {
				if (!StringUtils.isEmpty(oldFiles[j].getOriginalFilename())) {
					try {
						String imgNewOldAdUrl=null;
						String imgNewOldImgId=null;
						if(imgNewOldImgIds.length>0){
							imgNewOldImgId = imgNewOldImgIds[j];
							imgNewOldAdUrl = imgNewOldAdUrls[j];
						}
						int b =  goodsImgUpload(initActivityAd(),oldFiles[j].getBytes(),null,imgNewOldImgId,imgNewOldAdUrl,"1");
						if(1!=b){
							a=0;
							return a;
						}
						
					} catch (IOException e) {
						e.printStackTrace();
						a=0;
					}
				}
			}
			
		}
		
		return a;

	}
	/**
	 *	积分商城上传广告图片本地写入地址
	 * 
	 * @author wangjs
	 * @date 2016年11月29日
	 * @return
	 */
	private int goodsImgUpload(AsActivityAd asActivityAds, byte[] bytes,String imgNewAdurls,String imgNewOldImgId,String imgNewOldAdUrl,String type) {
		int a = 1;
		String ftpFile = UuidUtil.get32UUID() + ".jpg";
		String ftpDir = Const.POINTFILEPATHIMG;
		boolean flag = ftpUpload(bytes, ftpFile, ftpDir);
		if (flag) {
			asActivityAds.setAdImg(ftpDir + "/" + ftpFile);
			//if(null!=imgNewAdurls&&!"".equals(imgNewAdurls)){
			if("0".equals(type)){
				asActivityAds.setAdUrl(imgNewAdurls);
				operaFlag = asActivityAdMapper.insertSelective(asActivityAds) == 1;
			}//if(null!=imgNewOldImgId&&!"".equals(imgNewOldImgId)){
			if("1".equals(type)){
				asActivityAds.setAdId(Integer.valueOf(imgNewOldImgId));
				asActivityAds.setAdUrl(imgNewAdurls);
				asActivityAdMapper.updateByPrimaryKeySelective(asActivityAds);
			}
		if(!operaFlag){
			a=0;
		}
		}else{
			a=0;
		}
		return a;
	}
	
	/**
	 *	积分商城上传广告图片ftp
	 * 
	 * @author wangjs
	 * @date 2016年11月29日
	 * @return
	 */
	private boolean ftpUpload(byte[] bytes, String ftpFile, String ftpDir) {
		String path =Const.FILEPATHIMGDIR+ftpDir;
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(),
					PropertyUtils.getFTP_PASS());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ftpConManager.uploadFileByInputStream(new ByteArrayInputStream(bytes), path, ftpFile);
	}

	/**
	 * 获取积分兑换比值
	 *
	 * @author tgb
	 * @date 2017年4月23日
	 * @return
	 */
	public  Integer getMoneyExchange(){
		AsDictParam dictParam = asDictParamMapper.findAllByKeyCode(DictParam.PARAM_MONEY_EXCHANGE);
		return  Integer.parseInt(dictParam.getDictValue());
	}

}
