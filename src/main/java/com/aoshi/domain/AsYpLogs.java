package com.aoshi.domain;

public class AsYpLogs {
    private Integer logsId;

    private Integer userId;

    private String recordModule;

    private String recordDescp;

    private String createTime;
    
    private String ip;
    
    private String createName;

    public Integer getLogsId() {
        return logsId;
    }

    public void setLogsId(Integer logsId) {
        this.logsId = logsId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getRecordModule() {
        return recordModule;
    }

    public void setRecordModule(String recordModule) {
        this.recordModule = recordModule == null ? null : recordModule.trim();
    }

    public String getRecordDescp() {
        return recordDescp;
    }

    public void setRecordDescp(String recordDescp) {
        this.recordDescp = recordDescp == null ? null : recordDescp.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	
	public String getCreateName() {
		return createName;
	}

	public void setCreateName(String createName) {
		this.createName = createName;
	}

	public AsYpLogs(Integer userId, String recordModule,
			String recordDescp, String createTime,String ip, String createName) {
		
		this.userId = userId;
		this.recordModule = recordModule;
		this.recordDescp = recordDescp;
		this.createTime = createTime;
		this.ip = ip;
		this.createName = createName;
	}
    
}