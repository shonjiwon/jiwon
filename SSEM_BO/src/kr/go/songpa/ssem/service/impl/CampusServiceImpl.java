package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.repository.tibero.CampusRepository;
import kr.go.songpa.ssem.service.CampusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-10-02
 * Description :
 * History :
 * Version :
 */
@Service
public class CampusServiceImpl implements CampusService {

    @Autowired
    private CampusRepository campusRepository;

    @Override
    public void insertPersonBookInfo(PersonBookVo personBookVo) throws Exception {
        campusRepository.insertPersonBookInfo(personBookVo);
    }

    @Override
    public List<PersonBookVo> selectPersonBookList(SearchVo searchVo) throws Exception {
        return campusRepository.selectPersonBookList(searchVo);
    }

    @Override
    public int selectPersonBookListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectPersonBookListTotal(searchVo);
    }

    @Override
    public PersonBookVo selectPersonBookInfo(PersonBookVo personBookVo) throws Exception {
        return campusRepository.selectPersonBookInfo(personBookVo);
    }

    @Override
    public void updatePersonBookInfo(PersonBookVo personBookVo) throws Exception {
        campusRepository.updatePersonBookInfo(personBookVo);
    }

    @Override
    public void deletePersonBookInfo(PersonBookVo personBookVo) throws Exception {
        campusRepository.deletePersonBookInfo(personBookVo);
    }

    @Override
    public void updatePersonBookViewCnt(PersonBookVo personBookVo) throws Exception {
        campusRepository.updatePersonBookViewCnt(personBookVo);
    }

    @Override
    public List<PersonBookApyVo> selectPersonBookApplyList(SearchVo searchVo) throws Exception {
        return campusRepository.selectPersonBookApplyList(searchVo);
    }

    @Override
    public int selectPersonBookApplyListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectPersonBookApplyListTotal(searchVo);
    }

    @Override
    public void updatePersonBookApplyViewCnt(PersonBookApyVo personBookApyVo) throws Exception {
        campusRepository.updatePersonBookApplyViewCnt(personBookApyVo);
    }

    @Override
    public PersonBookApyVo selectPersonBookApplyInfo(PersonBookApyVo personBookApyVo) throws Exception {
        return campusRepository.selectPersonBookApplyInfo(personBookApyVo);
    }

    @Override
    public void updatePersonBookApplyInfo(PersonBookApyVo personBookApyVo) throws Exception {
        campusRepository.updatePersonBookApplyInfo(personBookApyVo);
    }

    @Override
    public List<PersonBookRegVo> selectPersonBookRegList(SearchVo searchVo) throws Exception {
        return campusRepository.selectPersonBookRegList(searchVo);
    }

    @Override
    public int selectPersonBookRegListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectPersonBookRegListTotal(searchVo);
    }

    @Override
    public PersonBookRegVo selectPersonBookRegInfo(PersonBookRegVo personBookRegVo) throws Exception {
        return campusRepository.selectPersonBookRegInfo(personBookRegVo);
    }

    @Override
    public void updatePersonBookRegInfo(PersonBookRegVo personBookRegVo) throws Exception {
        campusRepository.updatePersonBookRegInfo(personBookRegVo);
    }

    @Override
    public List<FutureEduIntroVo> selectFutureEduIntroList(SearchVo searchVo) throws Exception {
        return campusRepository.selectFutureEduIntroList(searchVo);
    }

    @Override
    public int selectFutureEduIntroListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectFutureEduIntroListTotal(searchVo);
    }

    @Override
    public void insertFutureEduInfoInfo(FutureEduIntroVo futureEduIntroVo) throws Exception {
        campusRepository.insertFutureEduInfoInfo(futureEduIntroVo);
    }

    @Override
    public void updateFutureEduIntroViewCnt(FutureEduIntroVo futureEduIntroVo) throws Exception {
        campusRepository.updateFutureEduIntroViewCnt(futureEduIntroVo);
    }

    @Override
    public FutureEduIntroVo selectFutureEduIntroInfo(FutureEduIntroVo futureEduIntroVo) throws Exception {
        return campusRepository.selectFutureEduIntroInfo(futureEduIntroVo);
    }

    @Override
    public void updateFutureEduIntroInfo(FutureEduIntroVo futureEduIntroVo) throws Exception {
        campusRepository.updateFutureEduIntroInfo(futureEduIntroVo);
    }

    @Override
    public void deleteFutureEduIntroInfo(FutureEduIntroVo futureEduIntroVo) throws Exception {
        campusRepository.deleteFutureEduIntroInfo(futureEduIntroVo);
    }

    @Override
    public List<FutureEduReviewVo> selectFutureEduReviewList(SearchVo searchVo) throws Exception {
        return campusRepository.selectFutureEduReviewList(searchVo);
    }

    @Override
    public int selectFutureEduReviewListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectFutureEduReviewListTotal(searchVo);
    }

    @Override
    public void insertFutureEduReviewInfo(FutureEduReviewVo futureEduReviewVo) throws Exception {
        campusRepository.insertFutureEduReviewInfo(futureEduReviewVo);
    }

    @Override
    public void updateFutureEduReviewViewCnt(FutureEduReviewVo futureEduReviewVo) throws Exception {
        campusRepository.updateFutureEduReviewViewCnt(futureEduReviewVo);
    }

    @Override
    public FutureEduReviewVo selectFutureEduReviewInfo(FutureEduReviewVo futureEduReviewVo) throws Exception {
        return campusRepository.selectFutureEduReviewInfo(futureEduReviewVo);
    }

    @Override
    public void updateFutureEduReviewInfo(FutureEduReviewVo futureEduReviewVo) throws Exception {
        campusRepository.updateFutureEduReviewInfo(futureEduReviewVo);
    }

    @Override
    public void deleteFutureEduReviewInfo(FutureEduReviewVo futureEduReviewVo) throws Exception {
        campusRepository.deleteFutureEduReviewInfo(futureEduReviewVo);
    }

    @Override
    public List<SelfEduIntroVo> selectSelfEduIntroList(SearchVo searchVo) throws Exception {
        return campusRepository.selectSelfEduIntroList(searchVo);
    }

    @Override
    public int selectSelfEduIntroListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectSelfEduIntroListTotal(searchVo);
    }

    @Override
    public void insertSelfEduIntroInfo(SelfEduIntroVo selfEduIntroVo) throws Exception {
        campusRepository.insertSelfEduIntroInfo(selfEduIntroVo);
    }

    @Override
    public void updateSelfEduIntroViewCnt(SelfEduIntroVo selfEduIntroVo) throws Exception {
        campusRepository.updateSelfEduIntroViewCnt(selfEduIntroVo);
    }

    @Override
    public SelfEduIntroVo selectSelfEduIntroInfo(SelfEduIntroVo selfEduIntroVo) throws Exception {
        return campusRepository.selectSelfEduIntroInfo(selfEduIntroVo);
    }

    @Override
    public void updateSelfEduIntroInfo(SelfEduIntroVo selfEduIntroVo) throws Exception {
        campusRepository.updateSelfEduIntroInfo(selfEduIntroVo);
    }

    @Override
    public void deleteSelfEduIntroInfo(SelfEduIntroVo selfEduIntroVo) throws Exception {
        campusRepository.deleteSelfEduIntroInfo(selfEduIntroVo);
    }

    @Override
    public List<SelfCounselVo> selectSelfEduCounselList(SearchVo searchVo) throws Exception {
        return campusRepository.selectSelfEduCounselList(searchVo);
    }

    @Override
    public int selectSelfEduCounselListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectSelfEduCounselListTotal(searchVo);
    }

    @Override
    public void updateSelfEduCounselViewCnt(SelfCounselVo selfCounselVo) throws Exception {
        campusRepository.updateSelfEduCounselViewCnt(selfCounselVo);
    }

    @Override
    public SelfCounselVo selectSelfEduCounselInfo(SelfCounselVo selfCounselVo) throws Exception {
        return campusRepository.selectSelfEduCounselInfo(selfCounselVo);
    }

    @Override
    public void updateSelfEduCounselInfo(SelfCounselVo selfCounselVo) throws Exception {
        campusRepository.updateSelfEduCounselInfo(selfCounselVo);
    }

    @Override
    public List<InstrumReviewVo> selectInstrumReviewList(SearchVo searchVo) throws Exception {
        return campusRepository.selectInstrumReviewList(searchVo);
    }

    @Override
    public int selectInstrumReviewListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectInstrumReviewListTotal(searchVo);
    }

    @Override
    public void insertInstrumReviewInfo(InstrumReviewVo instrumReviewVo) throws Exception {
        campusRepository.insertInstrumReviewInfo(instrumReviewVo);
    }

    @Override
    public void updateInstrumReviewViewCnt(InstrumReviewVo instrumReviewVo) throws Exception {
        campusRepository.updateInstrumReviewViewCnt(instrumReviewVo);
    }

    @Override
    public InstrumReviewVo selectInstrumReviewInfo(InstrumReviewVo instrumReviewVo) throws Exception {
        return campusRepository.selectInstrumReviewInfo(instrumReviewVo);
    }

    @Override
    public void updateInstrumReviewInfo(InstrumReviewVo instrumReviewVo) throws Exception {
        campusRepository.updateInstrumReviewInfo(instrumReviewVo);
    }

    @Override
    public void deleteInstrumReviewInfo(InstrumReviewVo instrumReviewVo) throws Exception {
        campusRepository.deleteInstrumReviewInfo(instrumReviewVo);
    }

    @Override
    public List<InstrumVo> selectInstrumRegList(SearchVo searchVo) throws Exception {
        return campusRepository.selectInstrumRegList(searchVo);
    }

    @Override
    public int selectInstrumRegListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectInstrumRegListTotal(searchVo);
    }

    @Override
    public void insertInstrumInfo(InstrumVo instrumVo) throws Exception {
        campusRepository.insertInstrumInfo(instrumVo);
    }

    @Override
    public InstrumVo selectInstrumInfo(InstrumVo instrumVo) throws Exception {
        return campusRepository.selectInstrumInfo(instrumVo);
    }

    @Override
    public void updateInstrumInfo(InstrumVo instrumVo) throws Exception {
        campusRepository.updateInstrumInfo(instrumVo);
    }

    @Override
    public List<InstrumDntVo> selectInstrumDntList(SearchVo searchVo) throws Exception {
        return campusRepository.selectInstrumDntList(searchVo);
    }

    @Override
    public int selectInstrumDntListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectInstrumDntListTotal(searchVo);
    }

    @Override
    public InstrumDntVo selectInstrumDntInfo(InstrumDntVo instrumDntVo) throws Exception {
        return campusRepository.selectInstrumDntInfo(instrumDntVo);
    }

    @Override
    public void updateInstrumDntInfo(InstrumDntVo instrumDntVo) throws Exception {
        campusRepository.updateInstrumDntInfo(instrumDntVo);
    }

    @Override
    public void deleteInstrumDntInfo(InstrumDntVo instrumDntVo) throws Exception {
        campusRepository.deleteInstrumDntInfo(instrumDntVo);
    }

    @Override
    public List<InstrumApyVo> selectInstrumApyList(SearchVo searchVo) throws Exception {
        return campusRepository.selectInstrumApyList(searchVo);
    }

    @Override
    public int selectInstrumApyListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectInstrumApyListTotal(searchVo);
    }

    @Override
    public InstrumApyVo selectInstrumApyInfo(InstrumApyVo instrumApyVo) throws Exception {
        return campusRepository.selectInstrumApyInfo(instrumApyVo);
    }

    @Override
    public void updateInstrumApyInfo(InstrumApyVo instrumApyVo) throws Exception {
        campusRepository.updateInstrumApyInfo(instrumApyVo);
    }

    @Override
    public void updateInstrumRentalQty(InstrumApyVo instrumApyVo) throws Exception {
        campusRepository.updateInstrumRentalQty(instrumApyVo);
    }

    @Override
    public void insertRentalFtyInfo(RentalFtyVo rentalFtyVo) throws Exception {
        campusRepository.insertRentalFtyInfo(rentalFtyVo);
    }

    @Override
    public List<RentalFtyVo> selectRentalFtyList(SearchVo searchVo) throws Exception {
        return campusRepository.selectRentalFtyList(searchVo);
    }

    @Override
    public int selectRentalFtyListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectRentalFtyListTotal(searchVo);
    }

    @Override
    public RentalFtyVo selectRentalFtyInfo(RentalFtyVo rentalFtyVo) throws Exception {
        return campusRepository.selectRentalFtyInfo(rentalFtyVo);
    }

    @Override
    public void updateRentalFtyInfo(RentalFtyVo rentalFtyVo) throws Exception {
        campusRepository.updateRentalFtyInfo(rentalFtyVo);
    }

    @Override
    public RentalFtyVo selectRentalFtyInfoByIdx(int rental_fty_idx) throws Exception {
        return campusRepository.selectRentalFtyInfoByIdx(rental_fty_idx);
    }

    @Override
    public void insertRentalFtySchedule(RentalFtySdVo rentalFtySdVo) throws Exception {
        campusRepository.insertRentalFtySchedule(rentalFtySdVo);
    }

    @Override
    public void deleteRentalFtySchedule(RentalFtySdVo deleteVo) throws Exception {
        campusRepository.deleteRentalFtySchedule(deleteVo);
    }

    @Override
    public List<RentalFtySdVo> selectRentalFtyscheduleList(RentalFtySdVo rentalFtySdVo) throws Exception {
        return campusRepository.selectRentalFtyscheduleList(rentalFtySdVo);
    }

    @Override
    public List<RentalFtyVo> selectRentalFtyListAll() throws Exception {
        return campusRepository.selectRentalFtyListAll();
    }

    @Override
    public List<RentalFtyApyVo> selectRentalFtyApyList(SearchVo searchVo) throws Exception {
        return campusRepository.selectRentalFtyApyList(searchVo);
    }

    @Override
    public RentalFtyApyVo selectRentalFtyApyByIdx(int rental_fty_apy_idx) throws Exception {
        return campusRepository.selectRentalFtyApyByIdx(rental_fty_apy_idx);
    }

    @Override
    public void updateRentalFtyApyInfo(RentalFtyApyVo rentalFtyApyVo) throws Exception {
        campusRepository.updateRentalFtyApyInfo(rentalFtyApyVo);
    }

    @Override
    public List<RentalFtyApyVo> selectRentalFtyApyListEx(SearchVo searchVo) throws Exception {
        return campusRepository.selectRentalFtyApyListEx(searchVo);
    }

    @Override
    public int selectRentalFtyApyListTotalEx(SearchVo searchVo) throws Exception {
        return campusRepository.selectRentalFtyApyListTotalEx(searchVo);
    }

    @Override
    public InstrumApyVo selectInstrumApyInfoByIdx(long instrum_apy_idx) throws Exception {
        return campusRepository.selectInstrumApyInfoByIdx(instrum_apy_idx);
    }

    @Override
    public InstrumVo selectInstrumInfoByIdx(long instrum_idx) throws Exception {
        return campusRepository.selectInstrumInfoByIdx(instrum_idx);
    }

    @Override
    public RentalFtyVo selectRentalFtyByIdx(int rental_fty_idx) throws Exception {
        return campusRepository.selectRentalFtyByIdx(rental_fty_idx);
    }

    @Override
    public List<InstrumApyVo> selectInstrumApyListSevenDays() throws Exception {
        return campusRepository.selectInstrumApyListSevenDays();
    }

    @Override
    public List<InstrumApyVo> selectInstrumApyListLate() throws Exception {
        return campusRepository.selectInstrumApyListLate();
    }
}
