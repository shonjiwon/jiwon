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
    public PersonBookVo selectNextPersonBook(PersonBookVo personBookVo) throws Exception {
        return campusRepository.selectNextPersonBook(personBookVo);
    }

    @Override
    public PersonBookVo selectPrevPersonBook(PersonBookVo personBookVo) throws Exception {
        return campusRepository.selectPrevPersonBook(personBookVo);
    }

    @Override
    public PersonBookVo selectPersonInfoMonthInfo(PersonBookVo personBookVo) throws Exception {
        return campusRepository.selectPersonInfoMonthInfo(personBookVo);
    }

    @Override
    public List<PersonBookVo> selectPersonMainList() throws Exception {
        return campusRepository.selectPersonMainList();
    }

    @Override
    public List<PersonBookVo> selectLiveMainList() throws Exception {
        return campusRepository.selectLiveMainList();
    }

    @Override
    public List<PersonBookVo> selectSchoolMainList() throws Exception {
        return campusRepository.selectSchoolMainList();
    }

    @Override
    public List<PersonBookVo> selectReviewMainList() throws Exception {
        return campusRepository.selectReviewMainList();
    }

    @Override
    public void insertPersonBookApyInfo(PersonBookApyVo personBookApyVo) throws Exception {
        campusRepository.insertPersonBookApyInfo(personBookApyVo);
    }

    @Override
    public void insertPersonRegInfo(PersonBookRegVo personBookRegVo) throws Exception {
        campusRepository.insertPersonRegInfo(personBookRegVo);
    }

    @Override
    public FutureEduReviewVo selectNextFutureReview(FutureEduReviewVo futureEduReviewVo) throws Exception {
        return campusRepository.selectNextFutureReview(futureEduReviewVo);
    }

    @Override
    public FutureEduReviewVo selectPrevFutureReview(FutureEduReviewVo futureEduReviewVo) throws Exception {
        return campusRepository.selectPrevFutureReview(futureEduReviewVo);
    }

    @Override
    public InstrumReviewVo selectNextInstrumReview(InstrumReviewVo instrumReviewVo) throws Exception {
        return campusRepository.selectNextInstrumReview(instrumReviewVo);
    }

    @Override
    public InstrumReviewVo selectPrevInstrumReview(InstrumReviewVo instrumReviewVo) throws Exception {
        return campusRepository.selectPrevInstrumReview(instrumReviewVo);
    }

    @Override
    public void insertInstrumDntInfo(InstrumDntVo instrumDntVo) throws Exception {
        campusRepository.insertInstrumDntInfo(instrumDntVo);
    }

    @Override
    public SelfEduIntroVo selectNextSelfIntro(SelfEduIntroVo selfEduIntroVo) throws Exception {
        return campusRepository.selectNextSelfIntro(selfEduIntroVo);
    }

    @Override
    public SelfEduIntroVo selectPrevSelfIntro(SelfEduIntroVo selfEduIntroVo) throws Exception {
        return campusRepository.selectPrevSelfIntro(selfEduIntroVo);
    }

    @Override
    public void insertSelfCounselInfo(SelfCounselVo selfCounselVo) throws Exception {
        campusRepository.insertSelfCounselInfo(selfCounselVo);
    }

    @Override
    public List<SelfEduIntroVo> selectSelfEduIntroMainList() throws Exception {
        return campusRepository.selectSelfEduIntroMainList();
    }

    @Override
    public List<FutureEduIntroVo> selectFutureEduIntroMainList() throws Exception {
        return campusRepository.selectFutureEduIntroMainList();
    }

    @Override
    public List<FutureEduReviewVo> selectFutureEduReviewMainList() throws Exception {
        return campusRepository.selectFutureEduReviewMainList();
    }

    @Override
    public InstrumVo selectNextInstrum(InstrumVo instrumVo) throws Exception {
        return campusRepository.selectNextInstrum(instrumVo);
    }

    @Override
    public InstrumVo selectPrevInstrum(InstrumVo instrumVo) throws Exception {
        return campusRepository.selectPrevInstrum(instrumVo);
    }

    @Override
    public InstrumVo selectInstrumInfoByIdx(long instrum_idx) throws Exception {
        return campusRepository.selectInstrumInfoByIdx(instrum_idx);
    }

    @Override
    public void insertInstrumApyInfo(InstrumApyVo instrumApyVo) throws Exception {
        campusRepository.insertInstrumApyInfo(instrumApyVo);
    }

    @Override
    public InstrumApyVo selectInstrumApyInfoByIdx(int instrum_apy_idx) throws Exception {
        return campusRepository.selectInstrumApyInfoByIdx(instrum_apy_idx);
    }

    @Override
    public void updateInstrumRentalQtyPlus(InstrumApyVo instrumApyVo) throws Exception {
        campusRepository.updateInstrumRentalQtyPlus(instrumApyVo);
    }

    @Override
    public List<PersonBookApyVo> selectPersonBookApyList(SearchVo searchVo) throws Exception {
        return campusRepository.selectPersonBookApyList(searchVo);
    }

    @Override
    public int selectPersonBookApyListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectPersonBookApyListTotal(searchVo);
    }

    @Override
    public void updatePersonBookApyInfo(PersonBookApyVo personBookApyVo) throws Exception {
        campusRepository.updatePersonBookApyInfo(personBookApyVo);
    }

    @Override
    public void updatePersonBookApyInfoCancel(PersonBookApyVo personBookApyVo) throws Exception {
        campusRepository.updatePersonBookApyInfoCancel(personBookApyVo);
    }

    @Override
    public void updatePersonBookRegInfoCancel(PersonBookRegVo personBookRegVo) throws Exception {
        campusRepository.updatePersonBookRegInfoCancel(personBookRegVo);
    }

    @Override
    public void updateInstrumRentalCancel(InstrumApyVo instrumApyVo) throws Exception {
        campusRepository.updateInstrumRentalCancel(instrumApyVo);
    }

    @Override
    public void updateInstrumRentalInfo(InstrumApyVo instrumApyVo) throws Exception {
        campusRepository.updateInstrumRentalInfo(instrumApyVo);
    }

    @Override
    public void updateInstrumRentalQtyDiff(InstrumApyVo instrumApyVo) throws Exception {
        campusRepository.updateInstrumRentalQtyDiff(instrumApyVo);
    }

    @Override
    public void updateInstrumRentalQtyEx(InstrumApyVo instrumApyVo) throws Exception {
        campusRepository.updateInstrumRentalQtyEx(instrumApyVo);
    }

    @Override
    public void updateInstrumDntCancel(InstrumDntVo instrumDntVo) throws Exception {
        campusRepository.updateInstrumDntCancel(instrumDntVo);
    }

    @Override
    public void updateSelfEduCounselCancel(SelfCounselVo selfCounselVo) throws Exception {
        campusRepository.updateSelfEduCounselCancel(selfCounselVo);
    }

    @Override
    public List<RentalFtyVo> selectRentalFtyList() throws Exception {
        return campusRepository.selectRentalFtyList();
    }

    @Override
    public RentalFtyVo selectRentalFtyByIdx(int rental_fty_idx) throws Exception {
        return campusRepository.selectRentalFtyByIdx(rental_fty_idx);
    }

    @Override
    public List<RentalFtySdVo> selectRentalFtySDList(RentalFtyVo selected_fty) throws Exception {
        return campusRepository.selectRentalFtySDList(selected_fty);
    }

    @Override
    public RentalFtySdVo selectRentalFtySD(RentalFtySdVo rentalFtySdVo) throws Exception {
        return campusRepository.selectRentalFtySD(rentalFtySdVo);
    }

    @Override
    public void insertRentalFtyApyInfo(RentalFtyApyVo rentalFtyApyVo) throws Exception {
        campusRepository.insertRentalFtyApyInfo(rentalFtyApyVo);
    }

    @Override
    public RentalFtyApyVo selectRentalFtyApyByIdx(int rental_fty_apy_idx) throws Exception {
        return campusRepository.selectRentalFtyApyByIdx(rental_fty_apy_idx);
    }

    @Override
    public void deleteRentalFtyApyInfo(RentalFtyApyVo rentalFtyApyVo) throws Exception {
        campusRepository.deleteRentalFtyApyInfo(rentalFtyApyVo);
    }

    @Override
    public int updateRentalFtyApyPayResult(RentalFtyApyVo rentalFtyApyVo) throws Exception {
        return campusRepository.updateRentalFtyApyPayResult(rentalFtyApyVo);
    }

    @Override
    public RentalFtyApyVo selectRentalFtyApyInfo(RentalFtyApyVo rentalFtyApyVo) throws Exception {
        return campusRepository.selectRentalFtyApyInfo(rentalFtyApyVo);
    }

    @Override
    public List<RentalFtyApyVo> selectRentalFtyApyList(SearchVo searchVo) throws Exception {
        return campusRepository.selectRentalFtyApyList(searchVo);
    }

    @Override
    public int selectRentalFtyApyListTotal(SearchVo searchVo) throws Exception {
        return campusRepository.selectRentalFtyApyListTotal(searchVo);
    }

    @Override
    public List<InstrumVo> selectInstrumMainList() throws Exception {
        return campusRepository.selectInstrumMainList();
    }

    @Override
    public List<InstrumReviewVo> selectInstrumReviewMainList() throws Exception {
        return campusRepository.selectInstrumReviewMainList();
    }

    @Override
    public List<RentalFtyApyVo> selectRentalFtyApyInfoListEx(RentalFtyApyVo rentalFtyApyVo) throws Exception {
        return campusRepository.selectRentalFtyApyInfoListEx(rentalFtyApyVo);
    }
}
