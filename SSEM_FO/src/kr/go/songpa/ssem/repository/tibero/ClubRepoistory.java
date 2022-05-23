package kr.go.songpa.ssem.repository.tibero;

import kr.go.songpa.ssem.model.ClubNewsVo;
import kr.go.songpa.ssem.model.ClubStatusVo;
import kr.go.songpa.ssem.model.ClubVo;
import kr.go.songpa.ssem.model.SearchVo;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.repository.tibero
 * Author : shlee
 * Date : 2020-09-20
 * Description :
 * History :
 * Version :
 */
public interface ClubRepoistory {
    List<ClubNewsVo> selectClubNewsList(SearchVo searchVo) throws Exception;

    int selectClubNewsListTotal(SearchVo searchVo) throws Exception;

    void insertClubNewsInfo(ClubNewsVo clubNewsVo) throws Exception;

    void updateClubNewsViewCnt(ClubNewsVo clubNewsVo) throws Exception;

    ClubNewsVo selectClubNewsInfo(ClubNewsVo clubNewsVo) throws Exception;

    void updateClubNewsInfo(ClubNewsVo clubNewsVo) throws Exception;

    void deleteClubNewsInfo(ClubNewsVo clubNewsVo) throws Exception;

    List<ClubStatusVo> selectClubStatusList(SearchVo searchVo) throws Exception;

    int selectClubStatusListTotal(SearchVo searchVo) throws Exception;

    void insertClubStatusInfo(ClubStatusVo clubStatusVo) throws Exception;

    ClubStatusVo selectClubStatusInfo(ClubStatusVo clubStatusVo) throws Exception;

    void updateClubStatusInfo(ClubStatusVo clubStatusVo) throws Exception;

    void deleteClubStatusInfo(ClubStatusVo clubStatusVo) throws Exception;

    List<ClubVo> selectClubList(SearchVo searchVo) throws Exception;

    int selectClubListTotal(SearchVo searchVo) throws Exception;

    ClubVo selectClubInfo(ClubVo clubVo) throws Exception;

    void updateClubInfo(ClubVo clubVo) throws Exception;

    void insertClubInfo(ClubVo clubVo) throws Exception;

    ClubNewsVo selectNextClubNews(ClubNewsVo clubNewsVo) throws Exception;

    ClubNewsVo selectPrevClubNews(ClubNewsVo clubNewsVo) throws Exception;

    void updateClubInfoEx(ClubVo clubVo) throws Exception;
}
