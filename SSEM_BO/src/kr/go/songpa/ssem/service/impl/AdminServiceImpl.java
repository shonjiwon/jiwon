package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.repository.tibero.AdminRepoistory;
import kr.go.songpa.ssem.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-09-14
 * Description :
 * History :
 * Version :
 */
@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminRepoistory adminRepoistory;


    @Override
    public int checkAdminrId(String admin_id) throws Exception {
        return adminRepoistory.checkAdminrId(admin_id);
    }

    @Override
    public void insertAdminInfo(AdminVo adminVo) throws Exception {
        adminRepoistory.insertAdminInfo(adminVo);
    }

    @Override
    public int selectIpCount(String remoteIP) throws Exception {
        return adminRepoistory.selectIpCount(remoteIP);
    }

    @Override
    public AdminLoginVo selectAdminInfo(AdminLoginVo adminLoginVo) throws Exception {
        return adminRepoistory.selectAdminInfo(adminLoginVo);
    }

    @Override
    public void updateLoginSuccessInfo(AdminLoginVo adminLoginVo) throws Exception {
        adminRepoistory.updateLoginSuccessInfo(adminLoginVo);
    }

    @Override
    public void insertAdminConInfo(StatConVo statConVo) throws Exception {
        adminRepoistory.insertAdminConInfo(statConVo);
    }

    @Override
    public List<AdminVo> selectAdminList(SearchVo searchVo) throws Exception {
        return adminRepoistory.selectAdminList(searchVo);
    }

    @Override
    public int selectAdminListTotal(SearchVo searchVo) throws Exception {
        return adminRepoistory.selectAdminListTotal(searchVo);
    }

    @Override
    public AdminVo selectAdminById(String admin_id) throws Exception {
        return adminRepoistory.selectAdminById(admin_id);
    }

    @Override
    public void updateAdminInfo(AdminVo adminVo) throws Exception {
        adminRepoistory.updateAdminInfo(adminVo);
    }

    @Override
    public void insertAdminRuleInfo(AdminRuleVo adminRuleVo) throws Exception {
        adminRepoistory.insertAdminRuleInfo(adminRuleVo);
    }

    @Override
    public List<AdminRuleVo> selectAdminRuleList(SearchVo searchVo) throws Exception {
        return adminRepoistory.selectAdminRuleList(searchVo);
    }

    @Override
    public int selectAdminRuleListTotal(SearchVo searchVo) throws Exception {
        return adminRepoistory.selectAdminRuleListTotal(searchVo);
    }

    @Override
    public AdminRuleVo selectAdminRuleInfo(AdminRuleVo adminRuleVo) throws Exception {
        return adminRepoistory.selectAdminRuleInfo(adminRuleVo);
    }

    @Override
    public void updateAdminRuleInfo(AdminRuleVo adminRuleVo) throws Exception {
        adminRepoistory.updateAdminRuleInfo(adminRuleVo);
    }

    @Override
    public List<AdminRuleVo> getRuleListByType(String type) throws Exception {
        return adminRepoistory.getRuleListByType(type);
    }

    @Override
    public int updateAdminPwd(AdminVo adminVo) throws Exception {
        return adminRepoistory.updateAdminPwd(adminVo);
    }

    @Override
    public int selectCurrentPwd(AdminVo adminVo) throws Exception {
        return adminRepoistory.selectCurrentPwd(adminVo);
    }

    @Override
    public void updateAdminInfoEx(AdminVo adminVo) throws Exception {
        adminRepoistory.updateAdminInfoEx(adminVo);
    }

    @Override
    public String selectAdminRuleInfoByIdx(long admin_rule_idx) throws Exception {
        return adminRepoistory.selectAdminRuleInfoByIdx(admin_rule_idx);
    }

    @Override
    public void updateLoginFailedCnt(AdminLoginVo adminLoginVo) throws Exception {
        adminRepoistory.updateLoginFailedCnt(adminLoginVo);
    }

    @Override
    public void updateAdminNoUse(String admin_id) throws Exception {
        adminRepoistory.updateAdminNoUse(admin_id);
    }
}
