package kr.go.songpa.ssem.service;

import kr.go.songpa.ssem.model.LawtaxCounselVo;
import kr.go.songpa.ssem.model.SearchVo;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2021-11-08
 * Description :
 * History :
 * Version :
 */
public interface LawTaxService {
    List<LawtaxCounselVo> selectLawTaxList(SearchVo searchVo) throws Exception;

    int selectLawTaxListTotal(SearchVo searchVo) throws Exception;

    LawtaxCounselVo selectLawTax(LawtaxCounselVo lawtaxCounselVo) throws Exception;

    void updateLawTax(LawtaxCounselVo lawtaxCounselVo) throws Exception;

    void deleteLawTax(LawtaxCounselVo lawtaxCounselVo) throws Exception;
}
