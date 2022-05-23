package kr.go.songpa.ssem.service;

import kr.go.songpa.ssem.model.*;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2020-09-14
 * Description :
 * History :
 * Version :
 */
public interface AdminService {
    int checkAdminrId(String admin_id) throws Exception;

    void insertAdminInfo(AdminVo adminVo) throws Exception;

    int selectIpCount(String remoteIP) throws Exception;

    AdminLoginVo selectAdminInfo(AdminLoginVo adminLoginVo) throws Exception;

    void updateLoginSuccessInfo(AdminLoginVo adminLoginVo) throws Exception;

    void insertAdminConInfo(StatConVo statConVo) throws Exception;

    List<AdminVo> selectAdminList(SearchVo searchVo) throws Exception;

    int selectAdminListTotal(SearchVo searchVo) throws Exception;

    AdminVo selectAdminById(String admin_id) throws Exception;

    void updateAdminInfo(AdminVo adminVo) throws Exception;

    void insertAdminRuleInfo(AdminRuleVo adminRuleVo) throws Exception;

    List<AdminRuleVo> selectAdminRuleList(SearchVo searchVo) throws Exception;

    int selectAdminRuleListTotal(SearchVo searchVo) throws Exception;

    AdminRuleVo selectAdminRuleInfo(AdminRuleVo adminRuleVo) throws Exception;

    void updateAdminRuleInfo(AdminRuleVo adminRuleVo) throws Exception;

    List<AdminRuleVo> getRuleListByType(String type) throws Exception;

    int updateAdminPwd(AdminVo adminVo) throws Exception;

    int selectCurrentPwd(AdminVo adminVo) throws Exception;

    void updateAdminInfoEx(AdminVo adminVo) throws Exception;

    String selectAdminRuleInfoByIdx(long admin_rule_idx) throws Exception;

    void updateLoginFailedCnt(AdminLoginVo adminLoginVo) throws Exception;

    void updateAdminNoUse(String admin_id) throws Exception;
}
