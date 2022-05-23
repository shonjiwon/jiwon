package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.repository.tibero.BbsRepoistory;
import kr.go.songpa.ssem.service.BbsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-09-16
 * Description :
 * History :
 * Version :
 */
@Service
public class BbsServiceImpl implements BbsService {

    @Autowired
    private BbsRepoistory bbsRepoistory;

    @Override
    public void insertNoticeInfo(BbsDetailVo bbsDetailVo) throws Exception {
        bbsRepoistory.insertNoticeInfo(bbsDetailVo);
    }

    @Override
    public List<BbsDetailVo> selectBbsList(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectBbsList(searchVo);
    }

    @Override
    public int selectbbsListTotal(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectbbsListTotal(searchVo);
    }

    @Override
    public void updateBbsViewCnt(BbsDetailVo bbsDetailVo) throws Exception {
        bbsRepoistory.updateBbsViewCnt(bbsDetailVo);
    }

    @Override
    public BbsDetailVo selectBbsInfo(BbsDetailVo bbsDetailVo) throws Exception {
        return bbsRepoistory.selectBbsInfo(bbsDetailVo);
    }

    @Override
    public void updateBbsInfo(BbsDetailVo bbsDetailVo) throws Exception {
        bbsRepoistory.updateBbsInfo(bbsDetailVo);
    }

    @Override
    public void deleteBbsInfo(BbsDetailVo bbsDetailVo) throws Exception {
        bbsRepoistory.deleteBbsInfo(bbsDetailVo);
    }

    @Override
    public void insertBannerInfo(BannerVo bannerVo) throws Exception {
        bbsRepoistory.insertBannerInfo(bannerVo);
    }

    @Override
    public List<BannerVo> selectBannerList(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectBannerList(searchVo);
    }

    @Override
    public int selectBannerListTotal(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectBannerListTotal(searchVo);
    }

    @Override
    public BannerVo selectBannerInfo(BannerVo bannerVo) throws Exception {
        return bbsRepoistory.selectBannerInfo(bannerVo);
    }

    @Override
    public void updateBannerInfo(BannerVo bannerVo) throws Exception {
        bbsRepoistory.updateBannerInfo(bannerVo);
    }

    @Override
    public void deleteBannerInfo(BannerVo bannerVo) throws Exception {
        bbsRepoistory.deleteBannerInfo(bannerVo);
    }

    @Override
    public void updateBannerOrd(OrdVo ord) throws Exception {
        bbsRepoistory.updateBannerOrd(ord);
    }

    @Override
    public List<TogetherVo> selectTogetherInfo() throws Exception {
        return bbsRepoistory.selectTogetherInfo();
    }

    @Override
    public void updateTogetherInfo(TogetherVo together) throws Exception {
        bbsRepoistory.updateTogetherInfo(together);
    }

    @Override
    public List<BbsDetailVo> selectSiteBbsList(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectSiteBbsList(searchVo);
    }

    @Override
    public int selectSiteBbsListTotal(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectSiteBbsListTotal(searchVo);
    }

    @Override
    public void updateMainUseY(int bbs_detail_idx) throws Exception {
        bbsRepoistory.updateMainUseY(bbs_detail_idx);
    }

    @Override
    public List<BbsDetailVo> selectMainBbsList() throws Exception {
        return bbsRepoistory.selectMainBbsList();
    }

    @Override
    public void updateMainUseN(int bbs_detail_idx) throws Exception {
        bbsRepoistory.updateMainUseN(bbs_detail_idx);
    }

    @Override
    public List<BbsDetailVo> selectMainTempBbsList(int size) throws Exception {
        return bbsRepoistory.selectMainTempBbsList(size);
    }

    @Override
    public void updateBbsOrd(OrdVo ord) throws Exception {
        bbsRepoistory.updateBbsOrd(ord);
    }

    @Override
    public List<SvyMstVo> selectSurveyList(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectSurveyList(searchVo);
    }

    @Override
    public int selectSurveyListTotal(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectSurveyListTotal(searchVo);
    }

    @Override
    public void insertSurveyMstInfo(SvyMstVo svyMstVo) throws Exception {
        bbsRepoistory.insertSurveyMstInfo(svyMstVo);
    }

    @Override
    public void insertSurveyQstInfo(SvyQstVo quest) throws Exception {
        bbsRepoistory.insertSurveyQstInfo(quest);
    }

    @Override
    public void insertSurveyItemInfo(SvyItemVo item) throws Exception {
        bbsRepoistory.insertSurveyItemInfo(item);
    }

    @Override
    public SvyMstVo selectSurvey(SvyMstVo svyMstVo) throws Exception {
        return bbsRepoistory.selectSurvey(svyMstVo);
    }

    @Override
    public List<SvyQstVo> selectQuestList(SvyMstVo svyMstVo) throws Exception {
        return bbsRepoistory.selectQuestList(svyMstVo);
    }

    @Override
    public List<SvyItemVo> selectItemList(SvyQstVo quest) throws Exception {
        return bbsRepoistory.selectItemList(quest);
    }

    @Override
    public void deleteSurveyItem(SvyMstVo svyMstVo) throws Exception {
        bbsRepoistory.deleteSurveyItem(svyMstVo);
    }

    @Override
    public void deleteSurveyQuest(SvyMstVo svyMstVo) throws Exception {
        bbsRepoistory.deleteSurveyQuest(svyMstVo);
    }

    @Override
    public void deleteSurveyMst(SvyMstVo svyMstVo) throws Exception {
        bbsRepoistory.deleteSurveyMst(svyMstVo);
    }

    @Override
    public void updateSurveyMstInfo(SvyMstVo svyMstVo) throws Exception {
        bbsRepoistory.updateSurveyMstInfo(svyMstVo);
    }

    @Override
    public List<SvyRpyVo> selectReplyList(SvyItemVo item) throws Exception {
        return bbsRepoistory.selectReplyList(item);
    }

    @Override
    public int selectQuestTotalReply(SvyItemVo item) throws Exception {
        return bbsRepoistory.selectQuestTotalReply(item);
    }

    @Override
    public List<BbsDetailVo> selectNoticeMainList(BbsDetailVo bbsDetailVo) throws Exception {
        return bbsRepoistory.selectNoticeMainList(bbsDetailVo);
    }

    @Override
    public TogetherVo selectTogethInfoByIdx(int idx) throws Exception {
        return bbsRepoistory.selectTogethInfoByIdx(idx);
    }

    @Override
    public BbsDetailVo selectNextBbs(BbsDetailVo bbsDetailVo) throws Exception {
        return bbsRepoistory.selectNextBbs(bbsDetailVo);
    }

    @Override
    public BbsDetailVo selectPrevBbs(BbsDetailVo bbsDetailVo) throws Exception {
        return bbsRepoistory.selectPrevBbs(bbsDetailVo);
    }

    @Override
    public List<BannerVo> selectBannerMainList(BannerVo bannerVo) throws Exception {
        return bbsRepoistory.selectBannerMainList(bannerVo);
    }

    @Override
    public List<BbsDetailVo> selectNoticeMainListEx(BbsDetailVo bbsDetailVo) throws Exception {
        return bbsRepoistory.selectNoticeMainListEx(bbsDetailVo);
    }

    @Override
    public List<BbsDetailVo> selectBbsListEx(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectBbsListEx(searchVo);
    }

    @Override
    public int selectbbsListTotalEx(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectbbsListTotalEx(searchVo);
    }

    @Override
    public BbsDetailVo selectNextBbsEx(BbsDetailVo bbsDetailVo) throws Exception {
        return bbsRepoistory.selectNextBbsEx(bbsDetailVo);
    }

    @Override
    public BbsDetailVo selectPrevBbsEx(BbsDetailVo bbsDetailVo) throws Exception {
        return bbsRepoistory.selectPrevBbsEx(bbsDetailVo);
    }

    @Override
    public int checkSurveyReply(SvyMstVo survey) throws Exception {
        return bbsRepoistory.checkSurveyReply(survey);
    }

    @Override
    public void insertSurveyReplyInfo(SvyRpyVo surveyReplyVo) throws Exception {
        bbsRepoistory.insertSurveyReplyInfo(surveyReplyVo);
    }

    @Override
    public void updateSurveyReplyCnt(long svy_idx) throws Exception {
        bbsRepoistory.updateSurveyReplyCnt(svy_idx);
    }

    @Override
    public List<SvyMstVo> selectSurveyListForUser(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectSurveyListForUser(searchVo);
    }

    @Override
    public int selectSurveyListForUserTotal(SearchVo searchVo) throws Exception {
        return bbsRepoistory.selectSurveyListForUserTotal(searchVo);
    }
}
