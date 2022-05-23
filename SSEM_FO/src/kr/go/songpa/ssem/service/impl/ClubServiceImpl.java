package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.ClubNewsVo;
import kr.go.songpa.ssem.model.ClubStatusVo;
import kr.go.songpa.ssem.model.ClubVo;
import kr.go.songpa.ssem.model.SearchVo;
import kr.go.songpa.ssem.repository.tibero.ClubRepoistory;
import kr.go.songpa.ssem.service.ClubService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-09-20
 * Description :
 * History :
 * Version :
 */
@Service
public class ClubServiceImpl implements ClubService {

    @Autowired
    private ClubRepoistory clubRepoistory;

    @Override
    public List<ClubNewsVo> selectClubNewsList(SearchVo searchVo) throws Exception {
        return clubRepoistory.selectClubNewsList(searchVo);
    }

    @Override
    public int selectClubNewsListTotal(SearchVo searchVo) throws Exception {
        return clubRepoistory.selectClubNewsListTotal(searchVo);
    }

    @Override
    public void insertClubNewsInfo(ClubNewsVo clubNewsVo) throws Exception {
        clubRepoistory.insertClubNewsInfo(clubNewsVo);
    }

    @Override
    public void updateClubNewsViewCnt(ClubNewsVo clubNewsVo) throws Exception {
        clubRepoistory.updateClubNewsViewCnt(clubNewsVo);
    }

    @Override
    public ClubNewsVo selectClubNewsInfo(ClubNewsVo clubNewsVo) throws Exception {
        return clubRepoistory.selectClubNewsInfo(clubNewsVo);
    }

    @Override
    public void updateClubNewsInfo(ClubNewsVo clubNewsVo) throws Exception {
        clubRepoistory.updateClubNewsInfo(clubNewsVo);
    }

    @Override
    public void deleteClubNewsInfo(ClubNewsVo clubNewsVo) throws Exception {
        clubRepoistory.deleteClubNewsInfo(clubNewsVo);
    }

    @Override
    public List<ClubStatusVo> selectClubStatusList(SearchVo searchVo) throws Exception {
        return clubRepoistory.selectClubStatusList(searchVo);
    }

    @Override
    public int selectClubStatusListTotal(SearchVo searchVo) throws Exception {
        return clubRepoistory.selectClubStatusListTotal(searchVo);
    }

    @Override
    public void insertClubStatusInfo(ClubStatusVo clubStatusVo) throws Exception {
        clubRepoistory.insertClubStatusInfo(clubStatusVo);
    }

    @Override
    public ClubStatusVo selectClubStatusInfo(ClubStatusVo clubStatusVo) throws Exception {
        return clubRepoistory.selectClubStatusInfo(clubStatusVo);
    }

    @Override
    public void updateClubStatusInfo(ClubStatusVo clubStatusVo) throws Exception {
        clubRepoistory.updateClubStatusInfo(clubStatusVo);
    }

    @Override
    public void deleteClubStatusInfo(ClubStatusVo clubStatusVo) throws Exception {
        clubRepoistory.deleteClubStatusInfo(clubStatusVo);
    }

    @Override
    public List<ClubVo> selectClubList(SearchVo searchVo) throws Exception {
        return clubRepoistory.selectClubList(searchVo);
    }

    @Override
    public int selectClubListTotal(SearchVo searchVo) throws Exception {
        return clubRepoistory.selectClubListTotal(searchVo);
    }

    @Override
    public ClubVo selectClubInfo(ClubVo clubVo) throws Exception {
        return clubRepoistory.selectClubInfo(clubVo);
    }

    @Override
    public void updateClubInfo(ClubVo clubVo) throws Exception {
        clubRepoistory.updateClubInfo(clubVo);
    }

    @Override
    public void insertClubInfo(ClubVo clubVo) throws Exception {
        clubRepoistory.insertClubInfo(clubVo);
    }

    @Override
    public ClubNewsVo selectNextClubNews(ClubNewsVo clubNewsVo) throws Exception {
        return clubRepoistory.selectNextClubNews(clubNewsVo);
    }

    @Override
    public ClubNewsVo selectPrevClubNews(ClubNewsVo clubNewsVo) throws Exception {
        return clubRepoistory.selectPrevClubNews(clubNewsVo);
    }

    @Override
    public void updateClubInfoEx(ClubVo clubVo) throws Exception {
        clubRepoistory.updateClubInfoEx(clubVo);
    }
}
