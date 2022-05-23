package kr.go.songpa.ssem.repository.tibero;

import kr.go.songpa.ssem.model.*;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.repository.tibero
 * Author : shlee
 * Date : 2020-09-25
 * Description :
 * History :
 * Version :
 */
public interface MainRepository {
    void insertMainImgInfo(MainImgVo mainImgVo) throws Exception;

    List<MainImgVo> selectMainImgList(SearchVo searchVo) throws Exception;

    int selectMainImgListTotal(SearchVo searchVo) throws Exception;

    void updateMainImgOrd(OrdVo ord) throws Exception;

    MainImgVo selectMainImgInfo(MainImgVo mainImgVo) throws Exception;

    void updateMainImgInfo(MainImgVo mainImgVo) throws Exception;

    void deleteMainImgInfo(MainImgVo mainImgVo) throws Exception;

    void insertPopupInfo(PopupVo popupVo) throws Exception;

    List<PopupVo> selectPopupList(SearchVo searchVo) throws Exception;

    int selectPopupListTotal(SearchVo searchVo) throws Exception;

    void updatePopupOrd(OrdVo ord) throws Exception;

    PopupVo selectPopupInfo(PopupVo popupVo) throws Exception;

    void updatePopupInfo(PopupVo popupVo) throws Exception;

    void deletePopupInfo(PopupVo popupVo) throws Exception;

    List<MainImgVo> selectMainImgYouthList() throws Exception;

    List<BbsDetailVo> selectNoticeMainList() throws Exception;

    List<MainImgVo> selectMainImgSeniorList() throws Exception;

    List<LectureVo> selectLectureYouthMainList() throws Exception;

    List<LectureVo> selectLectureSeniorMainList() throws Exception;

    List<PopupVo> selectPopupMainList(String kind) throws Exception;
}
