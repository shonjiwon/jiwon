package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.repository.tibero.AppRepoistory;
import kr.go.songpa.ssem.service.AppService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-09-13
 * Description :
 * History :
 * Version :
 */
@Service
public class AppServiceImpl implements AppService {

    @Autowired
    private AppRepoistory appRepoistory;

    @Override
    public List<MenuVo> seletTopMenuList(MenuVo menu) throws Exception {
        return appRepoistory.seletTopMenuList(menu);
    }

    @Override
    public MenuVo selectMenu(String url) throws Exception {
        return appRepoistory.selectMenu(url);
    }

    @Override
    public MenuVo selectMenuByIdx(int p_menu_idx) throws Exception {
        return appRepoistory.selectMenuByIdx(p_menu_idx);
    }

    @Override
    public List<MenuVo> selectSubMenuList(int menu_idx) throws Exception {
        return appRepoistory.selectSubMenuList(menu_idx);
    }

    @Override
    public String selectMenuUrl(int idx) throws Exception {
        return appRepoistory.selectMenuUrl(idx);
    }

    @Override
    public List<GroupVo> getMasterGroupList() throws Exception {
        return appRepoistory.getMasterGroupList();
    }

    @Override
    public List<GroupVo> getSubGroupList(long group_idx) throws Exception {
        return appRepoistory.getSubGroupList(group_idx);
    }

    @Override
    public GroupVo selectGruopByIdx(long group_idx) throws Exception {
        return appRepoistory.selectGruopByIdx(group_idx);
    }

    @Override
    public List<CodeVo> selectCodeList(String gubun) throws Exception {
        return appRepoistory.selectCodeList(gubun);
    }

    @Override
    public List<StatConVo> selectStatConList(SearchVo searchVo) throws Exception {
        return appRepoistory.selectStatConList(searchVo);
    }

    @Override
    public int selectStatConListTotal(SearchVo searchVo) throws Exception {
        return appRepoistory.selectStatConListTotal(searchVo);
    }

    @Override
    public List<StatUpVo> selectStatUpList(SearchVo searchVo) throws Exception {
        return appRepoistory.selectStatUpList(searchVo);
    }

    @Override
    public int selectStatUpListTotal(SearchVo searchVo) throws Exception {
        return appRepoistory.selectStatUpListTotal(searchVo);
    }

    @Override
    public void insertStatUpInfo(StatUpVo statUpVo) throws Exception {
        appRepoistory.insertStatUpInfo(statUpVo);
    }

    @Override
    public List<StatPrivateVo> selectStatPrivateList(SearchVo searchVo) throws Exception {
        return appRepoistory.selectStatPrivateList(searchVo);
    }

    @Override
    public int selectStatPrivateListTotal(SearchVo searchVo) throws Exception {
        return appRepoistory.selectStatPrivateListTotal(searchVo);
    }

    @Override
    public List<GroupVo> selectGroupList() throws Exception {
        return appRepoistory.selectGroupList();
    }

    @Override
    public List<GroupVo> selectSubGroupList(GroupVo group) throws Exception {
        return appRepoistory.selectSubGroupList(group);
    }

    @Override
    public void updateGroupMainInfo(GroupVo groupVo) throws Exception {
        appRepoistory.updateGroupMainInfo(groupVo);
    }

    @Override
    public void updateGroupSubInfo(GroupVo groupVo) throws Exception {
        appRepoistory.updateGroupSubInfo(groupVo);
    }

    @Override
    public int insertGroupMainInfo(GroupVo groupVo) throws Exception {
        return appRepoistory.insertGroupMainInfo(groupVo);
    }

    @Override
    public void insertGroupSubInfo(GroupVo groupVo) throws Exception {
        appRepoistory.insertGroupSubInfo(groupVo);
    }

    @Override
    public void insertPrivateInfo(StatPrivateVo statPrivateVo) throws Exception {
        appRepoistory.insertPrivateInfo(statPrivateVo);
    }

    @Override
    public String selectCodeByIdx(long code_idx) throws Exception {
        return appRepoistory.selectCodeByIdx(code_idx);
    }

    @Override
    public List<StudyPlaceVo> selectStudyPlaceList(long group_idx) throws Exception {
        return appRepoistory.selectStudyPlaceList(group_idx);
    }
}
