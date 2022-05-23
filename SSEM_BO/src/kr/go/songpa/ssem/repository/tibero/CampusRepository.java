package kr.go.songpa.ssem.repository.tibero;

import kr.go.songpa.ssem.model.*;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.repository.tibero
 * Author : shlee
 * Date : 2020-10-02
 * Description :
 * History :
 * Version :
 */
public interface CampusRepository {
    void insertPersonBookInfo(PersonBookVo personBookVo) throws Exception;

    List<PersonBookVo> selectPersonBookList(SearchVo searchVo) throws Exception;

    int selectPersonBookListTotal(SearchVo searchVo) throws Exception;

    PersonBookVo selectPersonBookInfo(PersonBookVo personBookVo) throws Exception;

    void updatePersonBookInfo(PersonBookVo personBookVo) throws Exception;

    void deletePersonBookInfo(PersonBookVo personBookVo) throws Exception;

    void updatePersonBookViewCnt(PersonBookVo personBookVo) throws Exception;

    List<PersonBookApyVo> selectPersonBookApplyList(SearchVo searchVo) throws Exception;

    int selectPersonBookApplyListTotal(SearchVo searchVo) throws Exception;

    void updatePersonBookApplyViewCnt(PersonBookApyVo personBookApyVo) throws Exception;

    PersonBookApyVo selectPersonBookApplyInfo(PersonBookApyVo personBookApyVo) throws Exception;

    void updatePersonBookApplyInfo(PersonBookApyVo personBookApyVo) throws Exception;

    List<PersonBookRegVo> selectPersonBookRegList(SearchVo searchVo) throws Exception;

    int selectPersonBookRegListTotal(SearchVo searchVo) throws Exception;

    PersonBookRegVo selectPersonBookRegInfo(PersonBookRegVo personBookRegVo) throws Exception;

    void updatePersonBookRegInfo(PersonBookRegVo personBookRegVo) throws Exception;

    List<FutureEduIntroVo> selectFutureEduIntroList(SearchVo searchVo) throws Exception;

    int selectFutureEduIntroListTotal(SearchVo searchVo) throws Exception;

    void insertFutureEduInfoInfo(FutureEduIntroVo futureEduIntroVo) throws Exception;

    void updateFutureEduIntroViewCnt(FutureEduIntroVo futureEduIntroVo) throws Exception;

    FutureEduIntroVo selectFutureEduIntroInfo(FutureEduIntroVo futureEduIntroVo) throws Exception;

    void updateFutureEduIntroInfo(FutureEduIntroVo futureEduIntroVo) throws Exception;

    void deleteFutureEduIntroInfo(FutureEduIntroVo futureEduIntroVo) throws Exception;

    List<FutureEduReviewVo> selectFutureEduReviewList(SearchVo searchVo) throws Exception;

    int selectFutureEduReviewListTotal(SearchVo searchVo) throws Exception;

    void insertFutureEduReviewInfo(FutureEduReviewVo futureEduReviewVo) throws Exception;

    void updateFutureEduReviewViewCnt(FutureEduReviewVo futureEduReviewVo) throws Exception;

    FutureEduReviewVo selectFutureEduReviewInfo(FutureEduReviewVo futureEduReviewVo) throws Exception;

    void updateFutureEduReviewInfo(FutureEduReviewVo futureEduReviewVo) throws Exception;

    void deleteFutureEduReviewInfo(FutureEduReviewVo futureEduReviewVo) throws Exception;

    List<SelfEduIntroVo> selectSelfEduIntroList(SearchVo searchVo) throws Exception;

    int selectSelfEduIntroListTotal(SearchVo searchVo) throws Exception;

    void insertSelfEduIntroInfo(SelfEduIntroVo selfEduIntroVo) throws Exception;

    void updateSelfEduIntroViewCnt(SelfEduIntroVo selfEduIntroVo) throws Exception;

    SelfEduIntroVo selectSelfEduIntroInfo(SelfEduIntroVo selfEduIntroVo) throws Exception;

    void updateSelfEduIntroInfo(SelfEduIntroVo selfEduIntroVo) throws Exception;

    void deleteSelfEduIntroInfo(SelfEduIntroVo selfEduIntroVo) throws Exception;

    List<SelfCounselVo> selectSelfEduCounselList(SearchVo searchVo) throws Exception;

    int selectSelfEduCounselListTotal(SearchVo searchVo) throws Exception;

    void updateSelfEduCounselViewCnt(SelfCounselVo selfCounselVo) throws Exception;

    SelfCounselVo selectSelfEduCounselInfo(SelfCounselVo selfCounselVo) throws Exception;

    void updateSelfEduCounselInfo(SelfCounselVo selfCounselVo) throws Exception;

    List<InstrumReviewVo> selectInstrumReviewList(SearchVo searchVo) throws Exception;

    int selectInstrumReviewListTotal(SearchVo searchVo) throws Exception;

    void insertInstrumReviewInfo(InstrumReviewVo instrumReviewVo) throws Exception;

    void updateInstrumReviewViewCnt(InstrumReviewVo instrumReviewVo) throws Exception;

    InstrumReviewVo selectInstrumReviewInfo(InstrumReviewVo instrumReviewVo) throws Exception;

    void updateInstrumReviewInfo(InstrumReviewVo instrumReviewVo) throws Exception;

    void deleteInstrumReviewInfo(InstrumReviewVo instrumReviewVo) throws Exception;

    List<InstrumVo> selectInstrumRegList(SearchVo searchVo) throws Exception;

    int selectInstrumRegListTotal(SearchVo searchVo) throws Exception;

    void insertInstrumInfo(InstrumVo instrumVo) throws Exception;

    InstrumVo selectInstrumInfo(InstrumVo instrumVo) throws Exception;

    void updateInstrumInfo(InstrumVo instrumVo) throws Exception;

    List<InstrumDntVo> selectInstrumDntList(SearchVo searchVo) throws Exception;

    int selectInstrumDntListTotal(SearchVo searchVo) throws Exception;

    InstrumDntVo selectInstrumDntInfo(InstrumDntVo instrumDntVo) throws Exception;

    void updateInstrumDntInfo(InstrumDntVo instrumDntVo) throws Exception;

    void deleteInstrumDntInfo(InstrumDntVo instrumDntVo) throws Exception;

    List<InstrumApyVo> selectInstrumApyList(SearchVo searchVo) throws Exception;

    int selectInstrumApyListTotal(SearchVo searchVo) throws Exception;

    InstrumApyVo selectInstrumApyInfo(InstrumApyVo instrumApyVo) throws Exception;

    void updateInstrumApyInfo(InstrumApyVo instrumApyVo) throws Exception;

    void updateInstrumRentalQty(InstrumApyVo instrumApyVo) throws Exception;

    void insertRentalFtyInfo(RentalFtyVo rentalFtyVo) throws Exception;

    List<RentalFtyVo> selectRentalFtyList(SearchVo searchVo) throws Exception;

    int selectRentalFtyListTotal(SearchVo searchVo) throws Exception;

    RentalFtyVo selectRentalFtyInfo(RentalFtyVo rentalFtyVo) throws Exception;

    void updateRentalFtyInfo(RentalFtyVo rentalFtyVo) throws Exception;

    RentalFtyVo selectRentalFtyInfoByIdx(int rental_fty_idx) throws Exception;

    void insertRentalFtySchedule(RentalFtySdVo rentalFtySdVo) throws Exception;

    void deleteRentalFtySchedule(RentalFtySdVo deleteVo) throws Exception;

    List<RentalFtySdVo> selectRentalFtyscheduleList(RentalFtySdVo rentalFtySdVo) throws Exception;

    List<RentalFtyVo> selectRentalFtyListAll() throws Exception;

    List<RentalFtyApyVo> selectRentalFtyApyList(SearchVo searchVo) throws Exception;

    RentalFtyApyVo selectRentalFtyApyByIdx(int rental_fty_apy_idx) throws Exception;

    void updateRentalFtyApyInfo(RentalFtyApyVo rentalFtyApyVo) throws Exception;

    List<RentalFtyApyVo> selectRentalFtyApyListEx(SearchVo searchVo) throws Exception;

    int selectRentalFtyApyListTotalEx(SearchVo searchVo) throws Exception;

    InstrumApyVo selectInstrumApyInfoByIdx(long instrum_apy_idx) throws Exception;

    InstrumVo selectInstrumInfoByIdx(long instrum_idx) throws Exception;

    RentalFtyVo selectRentalFtyByIdx(int rental_fty_idx) throws Exception;

    List<InstrumApyVo> selectInstrumApyListSevenDays() throws Exception;

    List<InstrumApyVo> selectInstrumApyListLate() throws Exception;
}
