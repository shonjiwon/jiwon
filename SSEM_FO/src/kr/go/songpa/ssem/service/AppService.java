package kr.go.songpa.ssem.service;

import kr.go.songpa.ssem.model.*;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2020-09-13
 * Description :
 * History :
 * Version :
 */
public interface AppService {
    List<MenuVo> seletTopMenuList(MenuVo menu) throws Exception;

    MenuVo selectMenu(String url) throws Exception;

    MenuVo selectMenuByIdx(int p_menu_idx) throws Exception;

    List<MenuVo> selectSubMenuList(int menu_idx) throws Exception;

    String selectMenuUrl(int idx) throws Exception;

    List<GroupVo> getMasterGroupList() throws Exception;

    List<GroupVo> getSubGroupList(long group_idx) throws Exception;

    GroupVo selectGruopByIdx(long group_idx) throws Exception;

    List<CodeVo> selectCodeList(String gubun) throws Exception;

    List<StatConVo> selectStatConList(SearchVo searchVo) throws Exception;

    int selectStatConListTotal(SearchVo searchVo) throws Exception;

    List<StatUpVo> selectStatUpList(SearchVo searchVo) throws Exception;

    int selectStatUpListTotal(SearchVo searchVo) throws Exception;

    void insertStatUpInfo(StatUpVo statUpVo) throws Exception;

    List<StatPrivateVo> selectStatPrivateList(SearchVo searchVo) throws Exception;

    int selectStatPrivateListTotal(SearchVo searchVo) throws Exception;

    List<GroupVo> selectGroupList() throws Exception;

    List<GroupVo> selectSubGroupList(GroupVo group) throws Exception;

    void updateGroupMainInfo(GroupVo groupVo) throws Exception;

    void updateGroupSubInfo(GroupVo groupVo) throws Exception;

    int insertGroupMainInfo(GroupVo groupVo) throws Exception;

    void insertGroupSubInfo(GroupVo groupVo) throws Exception;

    void insertPrivateInfo(StatPrivateVo statPrivateVo) throws Exception;

    String selectCodeByIdx(long code_idx) throws Exception;

    int selectGroupIdx(String name) throws Exception;

    List<String> selectGroupIdxList(String p_name) throws Exception;

    List<GroupVo> selectSubGroupListAll() throws Exception;
}
