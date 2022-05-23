package kr.go.songpa.ssem.service;

import kr.go.songpa.ssem.model.MainImgVo;
import kr.go.songpa.ssem.model.OrdVo;
import kr.go.songpa.ssem.model.PopupVo;
import kr.go.songpa.ssem.model.SearchVo;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2020-09-25
 * Description :
 * History :
 * Version :
 */
public interface MainService {

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

    void updateMainImgOrdAll() throws Exception;
}
