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
 * Date : 2021-11-07
 * Description :
 * History :
 * Version :
 */
@Service
public class LawTaxServiceImpl implements LawTaxService {

    @Autowired
    private LawTaxRepository lawTaxRepository;

    @Override
    public void insertLawTaxCounsel(LawtaxCounselVo lawtaxCounselVo) throws Exception {
        lawTaxRepository.insertLawTaxCounsel(lawtaxCounselVo);
    }

    @Override
    public List<LawtaxCounselVo> selectLawTaxCounselApyList(SearchVo searchVo) throws Exception {
        return lawTaxRepository.selectLawTaxCounselApyList(searchVo);
    }

    @Override
    public int selectLawTaxCounselApyTotal(SearchVo searchVo) throws Exception {
        return lawTaxRepository.selectLawTaxCounselApyTotal(searchVo);
    }

    @Override
    public LawtaxCounselVo selectLawTaxCounsel(LawtaxCounselVo lawtaxCounselVo) throws Exception {
        return lawTaxRepository.selectLawTaxCounsel(lawtaxCounselVo);
    }

    @Override
    public void deleteLawTaxCounsel(LawtaxCounselVo lawtaxCounselVo) throws Exception {
        lawTaxRepository.deleteLawTaxCounsel(lawtaxCounselVo);
    }

    @Override
    public void updateLawTaxCounsel(LawtaxCounselVo lawtaxCounselVo) throws Exception {
        lawTaxRepository.updateLawTaxCounsel(lawtaxCounselVo);
    }
}
