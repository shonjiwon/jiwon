package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.LawtaxCounselVo;
import kr.go.songpa.ssem.model.SearchVo;
import kr.go.songpa.ssem.repository.tibero.LawTaxRepository;
import kr.go.songpa.ssem.service.LawTaxService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2021-11-08
 * Description :
 * History :
 * Version :
 */
@Service
public class LawTaxServiceImpl implements LawTaxService {

    @Autowired
    private LawTaxRepository lawTaxRepository;

    @Override
    public List<LawtaxCounselVo> selectLawTaxList(SearchVo searchVo) throws Exception {
        return lawTaxRepository.selectLawTaxList(searchVo);
    }

    @Override
    public int selectLawTaxListTotal(SearchVo searchVo) throws Exception {
        return lawTaxRepository.selectLawTaxListTotal(searchVo);
    }

    @Override
    public LawtaxCounselVo selectLawTax(LawtaxCounselVo lawtaxCounselVo) throws Exception {
        return lawTaxRepository.selectLawTax(lawtaxCounselVo);
    }

    @Override
    public void updateLawTax(LawtaxCounselVo lawtaxCounselVo) throws Exception {
        lawTaxRepository.updateLawTax(lawtaxCounselVo);
    }

    @Override
    public void deleteLawTax(LawtaxCounselVo lawtaxCounselVo) throws Exception {
        lawTaxRepository.deleteLawTax(lawtaxCounselVo);
    }
}
