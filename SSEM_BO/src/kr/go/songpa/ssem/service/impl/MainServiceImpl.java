package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.MainImgVo;
import kr.go.songpa.ssem.model.OrdVo;
import kr.go.songpa.ssem.model.PopupVo;
import kr.go.songpa.ssem.model.SearchVo;
import kr.go.songpa.ssem.repository.tibero.MainRepository;
import kr.go.songpa.ssem.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-09-25
 * Description :
 * History :
 * Version :
 */
@Service
public class MainServiceImpl implements MainService {

    @Autowired
    private MainRepository mainRepository;

    @Override
    public void insertMainImgInfo(MainImgVo mainImgVo) throws Exception {
        mainRepository.insertMainImgInfo(mainImgVo);
    }

    @Override
    public List<MainImgVo> selectMainImgList(SearchVo searchVo) throws Exception {
        return mainRepository.selectMainImgList(searchVo);
    }

    @Override
    public int selectMainImgListTotal(SearchVo searchVo) throws Exception {
        return mainRepository.selectMainImgListTotal(searchVo);
    }

    @Override
    public void updateMainImgOrd(OrdVo ord) throws Exception {
        mainRepository.updateMainImgOrd(ord);
    }

    @Override
    public MainImgVo selectMainImgInfo(MainImgVo mainImgVo) throws Exception {
        return mainRepository.selectMainImgInfo(mainImgVo);
    }

    @Override
    public void updateMainImgInfo(MainImgVo mainImgVo) throws Exception {
        mainRepository.updateMainImgInfo(mainImgVo);
    }

    @Override
    public void deleteMainImgInfo(MainImgVo mainImgVo) throws Exception {
        mainRepository.deleteMainImgInfo(mainImgVo);
    }

    @Override
    public void insertPopupInfo(PopupVo popupVo) throws Exception {
        mainRepository.insertPopupInfo(popupVo);
    }

    @Override
    public List<PopupVo> selectPopupList(SearchVo searchVo) throws Exception {
        return mainRepository.selectPopupList(searchVo);
    }

    @Override
    public int selectPopupListTotal(SearchVo searchVo) throws Exception {
        return mainRepository.selectPopupListTotal(searchVo);
    }

    @Override
    public void updatePopupOrd(OrdVo ord) throws Exception {
        mainRepository.updatePopupOrd(ord);
    }

    @Override
    public PopupVo selectPopupInfo(PopupVo popupVo) throws Exception {
        return mainRepository.selectPopupInfo(popupVo);
    }

    @Override
    public void updatePopupInfo(PopupVo popupVo) throws Exception {
        mainRepository.updatePopupInfo(popupVo);
    }

    @Override
    public void deletePopupInfo(PopupVo popupVo) throws Exception {
        mainRepository.deletePopupInfo(popupVo);
    }

    @Override
    public void updateMainImgOrdAll() throws Exception {
        mainRepository.updateMainImgOrdAll();
    }
}
