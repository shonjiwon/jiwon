package kr.go.songpa.ssem.service;

import kr.go.songpa.ssem.model.LawtaxCounselVo;
import kr.go.songpa.ssem.model.SearchVo;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2021-11-07
 * Description :
 * History :
 * Version :
 */
public interface LawTaxService {
    void insertLawTaxCounsel(LawtaxCounselVo lawtaxCounselVo) throws Exception;

    List<LawtaxCounselVo> selectLawTaxCounselApyList(SearchVo searchVo) throws Exception;

    int selectLawTaxCounselApyTotal(SearchVo searchVo) throws Exception;

    LawtaxCounselVo selectLawTaxCounsel(LawtaxCounselVo lawtaxCounselVo) throws Exception;

    void deleteLawTaxCounsel(LawtaxCounselVo lawtaxCounselVo) throws Exception;

    void updateLawTaxCounsel(LawtaxCounselVo lawtaxCounselVo) throws Exception;
}
