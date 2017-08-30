package com.aoshi.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

/**
 * SmsConfig
 *
 * @author zf
 * @date 16/6/28
 */
@PropertySource(value = "classpath:dbconfig.properties")
@Service
public class SmsConfig {

    @Value("${sms.username}")
    private static String username;

    @Value("${sms.password}")
    private static String password;


    public SmsConfig() {
    }

    public  String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public  String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
