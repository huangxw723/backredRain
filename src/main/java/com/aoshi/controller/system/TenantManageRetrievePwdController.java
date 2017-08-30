package com.aoshi.controller.system;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsShopOwnerInfoMapper;
import com.aoshi.dao.AsUserMapper;
import com.aoshi.dao.SysUserMapper;
import com.aoshi.domain.AsUser;
import com.aoshi.domain.SysUser;
import com.aoshi.util.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;


/**
 * 类名称：SecCodeController 类描述：忘记密码找回密码html
 */
@Controller
@RequestMapping("/TenantManage")
public class TenantManageRetrievePwdController extends BaseController {

    @Autowired
    SmsUtils smsUtils;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private AsUserMapper asUserMapper;

    @Autowired
    private AsShopOwnerInfoMapper asShopOwnerInfoMapper;

    /**
     * 图片验证码
     * @param response
     */
    @RequestMapping("/code")
    public void generate(HttpServletResponse response) {
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        String code = drawImg(output);

        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        session.setAttribute(Const.SESSION_SECURITY_CODE, code);

        try {
            ServletOutputStream out = response.getOutputStream();
            output.writeTo(out);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 验证手机号码和验证码
     */

    @RequestMapping(value = "/checkVerifyCode")
    @ResponseBody
    public Object checkVerifyCode(String phone, String verifyCode) {

        Map<String, Object> data = new HashMap<String, Object>();

        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        // 检查验证码
        String sessionCode = (String) session
                .getAttribute(Const.SESSION_SECURITY_CODE);
        if (!verifyCode.equalsIgnoreCase(sessionCode)) {
            data.put("msg", "验证码不正确，请输入正确的验证码！");
            data.put("status", "2");
            return data;
        }
        SysUser sysUser = sysUserMapper.findByPhone(phone);
        if (sysUser == null) {
            data.put("msg", "您预留手机号码不存在，请输入正确的号码！");
            data.put("status", "1");
            return data;
        }
        Conditions shopOwnerInfo = asShopOwnerInfoMapper.getStatusBySysUserId(sysUser.getUserId());
        if (shopOwnerInfo == null) {
            data.put("msg", "该用户已经被禁用，请联系客服！");
            data.put("status", "3");
            return data;
        }
        data.put("status", "0");
        return data;
    }

    /**
     * 通过手机号码获取短信验证码
     */

    @RequestMapping(value = "/forgetPwd")
    @ResponseBody
    public Object forgetPwd(String phone) {

        Map<String, Object> data = new HashMap<String, Object>();

        String code = RandomCodeUtil.getNumber(6);
        String msg = "【澳视官网】提醒您，您的验证码为" + code
                + "，为保证您的权益，请保管好该验证码。此验证码有效期60秒";
        try {
            smsUtils.sendSms2(phone, msg);
            data.put("status", "0");
        } catch (Exception e) {
            data.put("status", "3");
            data.put("msg", "系统繁忙！");
        }

        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();

        session.setAttribute("phone", phone);
        session.setAttribute("code", code);
        //session.setTimeout(60000);
        data.put("phone", phone);
        return data;
    }

    /**
     * 校验短信验证码
     *
     * @param phone
     * @param code
     * @return
     */
    @RequestMapping(value = "/checkCode")
    @ResponseBody
    public Object checkCode(String phone, String code) {
        Map<String, Object> data = new HashMap<String, Object>();
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();

        String adminCode = session.getAttribute("code") == null ? "" : session.getAttribute("code").toString();
        String adminPhone = session.getAttribute("phone") == null ? "" : session.getAttribute("phone").toString();

        if (code.equals(adminCode) && adminPhone.equals(phone)) {
            data.put("status", "0");
        } else {
            data.put("status", "1");
            data.put("msg", "验证码不正确！");
        }
        return data;

    }

    /**
     * 确认修改密码
     *
     * @return
     */
    @RequestMapping("/updatePwd")
    @ResponseBody
    public Object updatePwd(String phone, String password, String confirmPassword) {
        Map<String, Object> data = new HashMap<String, Object>();
        if (!password.equals(confirmPassword)) {
            data.put("status", "1");
            data.put("msg", "两次密码不一致，请重新输入！");
        }
        SysUser sysUser = sysUserMapper.findByPhone(phone);
        if (sysUser == null) {
            data.put("status", "2");
            data.put("msg", "系统繁忙，请稍后再试！");
            return data;
        } else {
            AsUser asUser = asUserMapper.getBySysUserId(sysUser.getUserId());
            //AsUser staff = asUserMapper.getByAccountAndType(asUser.getAccount());
            if(asUser==null){
                data.put("status", "2");
                data.put("msg", "系统繁忙，请稍后再试！");
                return data;
            }
            //密码加密
            String SHA1Password = CommonUtils.encryptPwd(password, 2);
            String MD5Password = CommonUtils.encryptPwd(password);
            // 修改后台用户表密码
            sysUser.setPassword(SHA1Password);
            sysUserMapper.updateByPrimaryKeySelective(sysUser);

            // 修改商家账号密码
            asUser.setPassword(MD5Password);
            asUserMapper.updateByPrimaryKeySelective(asUser);

            // 修改店员账号密码
            //staff.setPassword(MD5Password);
            //asUserMapper.updateByPrimaryKeySelective(staff);

            data.put("status", "0");
            data.put("msg", "重设密码成功，请登录！");
        }
        return data;
    }


    private String drawImg(ByteArrayOutputStream output) {
        String code = "";
        for (int i = 0; i < 4; i++) {
            code += randomChar();
        }
        int width = 70;
        int height = 25;
        BufferedImage bi = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
        Font font = new Font("Times New Roman", Font.PLAIN, 20);
        Graphics2D g = bi.createGraphics();
        g.setFont(font);
        Color color = new Color(66, 2, 82);
        g.setColor(color);
        g.setBackground(new Color(226, 226, 240));
        g.clearRect(0, 0, width, height);
        FontRenderContext context = g.getFontRenderContext();
        Rectangle2D bounds = font.getStringBounds(code, context);
        double x = (width - bounds.getWidth()) / 2;
        double y = (height - bounds.getHeight()) / 2;
        double ascent = bounds.getY();
        double baseY = y - ascent;
        g.drawString(code, (int) x, (int) baseY);
        g.dispose();
        try {
            ImageIO.write(bi, "jpg", output);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return code;
    }

    private char randomChar() {
        Random r = new Random();
        String s = "ABCDEFGHJKLMNPRSTUVWXYZ0123456789";
        return s.charAt(r.nextInt(s.length()));
    }
}
