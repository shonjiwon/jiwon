package kr.go.songpa.ssem.repository.tibero;

import kr.go.songpa.ssem.model.*;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.repository.tibero
 * Author : shlee
 * Date : 2020-09-16
 * Description :
 * History :
 * Version :
 */
public interface BbsRepoistory {
    void insertNoticeInfo(BbsDetailVo bbsDetailVo) throws Exception;

    List<BbsDetailVo> selectBbsList(SearchVo searchVo) throws Exception;

    int selectbbsListTotal(SearchVo searchVo) throws Exception;

    void updateBbsViewCnt(BbsDetailVo bbsDetailVo) throws Exception;

    BbsDetailVo selectBbsInfo(BbsDetailVo bbsDetailVo) throws Exception;

    void updateBbsInfo(BbsDetailVo bbsDetailVo) throws Exception;

    void deleteBbsInfo(BbsDetailVo bbsDetailVo) throws Exception;

    void insertBannerInfo(BannerVo bannerVo) throws Exception;

    List<BannerVo> selectBannerList(SearchVo searchVo) throws Exception;

    int selectBannerListTotal(SearchVo searchVo) throws Exception;

    BannerVo selectBannerInfo(BannerVo bannerVo) throws Exception;

    void updateBannerInfo(BannerVo bannerVo) throws Exception;

    void deleteBannerInfo(BannerVo bannerVo) throws Exception;

    void updateBannerOrd(OrdVo ord) throws Exception;

    List<TogetherVo> selectTogetherInfo() throws Exception;

    void updateTogetherInfo(TogetherVo together) throws Exception;

    List<BbsDetailVo> selectSiteBbsList(SearchVo searchVo) throws Exception;

    int selectSiteBbsListTotal(SearchVo searchVo) throws Exception;

    void updateMainUseY(int bbs_detail_idx) throws Exception;

    List<BbsDetailVo> selectMainBbsList() throws Exception;

    void updateMainUseN(int bbs_detail_idx) throws Exception;

    List<BbsDetailVo> selectMainTempBbsList(int size) throws Exception;

    void updateBbsOrd(OrdVo ord) throws Exception;

    List<SvyMstVo> selectSurveyList(SearchVo searchVo) throws Exception;

    int selectSurveyListTotal(SearchVo searchVo) throws Exception;

    void insertSurveyMstInfo(SvyMstVo svyMstVo) throws Exception;

    void insertSurveyQstInfo(SvyQstVo quest) throws Exception;

    void insertSurveyItemInfo(SvyItemVo item) throws Exception;

    SvyMstVo selectSurvey(SvyMstVo svyMstVo) throws Exception;

    List<SvyQstVo> selectQuestList(SvyMstVo svyMstVo) throws Exception;

    List<SvyItemVo> selectItemList(SvyQstVo quest) throws Exception;

    void deleteSurveyItem(SvyMstVo svyMstVo) throws Exception;

    void deleteSurveyQuest(SvyMstVo svyMstVo) throws Exception;

    void deleteSurveyMst(SvyMstVo svyMstVo) throws Exception;

    void updateSurveyMstInfo(SvyMstVo svyMstVo) throws Exception;

    List<SvyRpyVo> selectReplyList(SvyItemVo item) throws Exception;

    int selectQuestTotalReply(SvyItemVo item) throws Exception;

    List<BbsDetailVo> selectNoticeMainList(BbsDetailVo bbsDetailVo) throws Exception;

    TogetherVo selectTogethInfoByIdx(int idx) throws Exception;

    BbsDetailVo selectNextBbs(BbsDetailVo bbsDetailVo) throws Exception;

    BbsDetailVo selectPrevBbs(BbsDetailVo bbsDetailVo) throws Exception;

    List<BannerVo> selectBannerMainList(BannerVo bannerVo) throws Exception;

    List<BbsDetailVo> selectNoticeMainListEx(BbsDetailVo bbsDetailVo) throws Exception;

    List<BbsDetailVo> selectBbsListEx(SearchVo searchVo) throws Exception;

    int selectbbsListTotalEx(SearchVo searchVo) throws Exception;

    BbsDetailVo selectNextBbsEx(BbsDetailVo bbsDetailVo) throws Exception;

    BbsDetailVo selectPrevBbsEx(BbsDetailVo bbsDetailVo) throws Exception;

    int checkSurveyReply(SvyMstVo survey) throws Exception;

    void insertSurveyReplyInfo(SvyRpyVo surveyReplyVo) throws Exception;

    void updateSurveyReplyCnt(long svy_idx) throws Exception;

    List<SvyMstVo> selectSurveyListForUser(SearchVo searchVo) throws Exception;

    int selectSurveyListForUserTotal(SearchVo searchVo) throws Exception;
}
