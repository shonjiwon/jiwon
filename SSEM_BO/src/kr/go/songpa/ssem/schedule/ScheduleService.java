package kr.go.songpa.ssem.schedule;

import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.CampusService;
import kr.go.songpa.ssem.service.LectureService;
import kr.go.songpa.ssem.service.MsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.schedule
 * Author : shlee
 * Date : 2020-12-14
 * Description :
 * History :
 * Version :
 */
@Service
public class ScheduleService {
    @Autowired
    private CampusService campusService;

    @Autowired
    private MsgService msgService;

    @Autowired
    private LectureService lectureService;

    // 테스트를 위한 10초마다 실행
    //@Scheduled(cron="*/10 * * * * *")

    // 매일 00시 10분에 실행
    // 악기 반납일 7일전 악기도서관 메세지 발송
    @Scheduled(cron="0 10 0 * * *")
    public void instrum_lib_rental_seven_prev() throws Exception {
        List<InstrumApyVo> itemList = campusService.selectInstrumApyListSevenDays();
        for(InstrumApyVo instrumApyVo : itemList) {
            // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                InstrumVo instrumVo = campusService.selectInstrumInfoByIdx(instrumApyVo.getInstrum_idx());

                StringBuffer sb = new StringBuffer();
                sb.append("[송파구청 송파쌤(SSEM)]");
                sb.append("\r\n");
                sb.append(String.format("%s님의 악기대여 반납일이 7일 남았습니다.", instrumApyVo.getApy_nm()));
                sb.append("\r\n");
                sb.append("<악기대여내역>");
                sb.append("\r\n");
                sb.append(String.format("- 악기명: %s", instrumVo.getName()));
                sb.append("\r\n");
                sb.append(String.format("- 대여수량: %d", instrumApyVo.getRental_qty()));
                sb.append("\r\n");
                sb.append(String.format("- 대여기간: %s~%s", instrumApyVo.getRental_start_dt(), instrumApyVo.getRental_end_dt()));
                sb.append("\r\n");
                sb.append("악기대여기간 확인은 마이페이지에서 확인이 가능하며, 연체시 연체료 부과와 악기대여 이용에 제한이 되실 수 있습니다.");
                sb.append("\r\n");
                sb.append("감사합니다.");
                sb.append("\r\n");
                sb.append("☎ 문의: 송파쌤(SSEM) 악기도서관 02-2147-2544");

                msgService.sendMsgKakao("반납일 안내", sb.toString(), instrumApyVo.getApy_nm(), instrumApyVo.getApy_mob_no().replaceAll("-", ""), "UMS_2021061514563775492");
            }
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
    }

    // 매일 00시 20분에 실행
    // 악기도서관 악기 연체 안내 메세지 발송
    @Scheduled(cron="0 20 0 * * *")
    public void instrum_lib_rental_late() throws Exception{
        List<InstrumApyVo> itemList = campusService.selectInstrumApyListLate();
        for(InstrumApyVo instrumApyVo : itemList) {
            // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                InstrumVo instrumVo = campusService.selectInstrumInfoByIdx(instrumApyVo.getInstrum_idx());

                StringBuffer sb = new StringBuffer();
                sb.append("[송파구청 송파쌤(SSEM)]");
                sb.append("\r\n");
                sb.append(String.format("%s님의 악기대여 반납일이 초과되었습니다.", instrumApyVo.getApy_nm()));
                sb.append("\r\n");
                sb.append("<악기대여내역>");
                sb.append("\r\n");
                sb.append(String.format("- 악기명: %s", instrumVo.getName()));
                sb.append("\r\n");
                sb.append(String.format("- 대여수량: %d", instrumApyVo.getRental_qty()));
                sb.append("\r\n");
                sb.append(String.format("- 대여기간: %s~%s", instrumApyVo.getRental_start_dt(), instrumApyVo.getRental_end_dt()));
                sb.append("\r\n");
                sb.append("악기대여기간 확인은 마이페이지에서 확인이 가능하며, 연체시 연체료 부과와 악기대여 이용에 제한이 있을 수 있습니다.");
                sb.append("\r\n");
                sb.append("감사합니다.");
                sb.append("\r\n");
                sb.append("☎ 문의: 송파쌤(SSEM) 악기도서관 02-2147-2544");

                msgService.sendMsgKakao("연체 안내", sb.toString(), instrumApyVo.getApy_nm(), instrumApyVo.getApy_mob_no().replaceAll("-", ""), "UMS_2021061514563786778");
            }
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
    }

    // 매일 00시 30분에 실행
    // 프로그램 미결제시 2일 이후 자동 취소 - 메세지 발송
    @Scheduled(cron="0 30 0 * * *")
    public void program_auto_cancel() throws Exception{
        List<LectureApyVo> itemList = lectureService.selectLectureApyListAutoCancel();
        // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        for(LectureApyVo lectureApyVo : itemList) {

            // 상태 정보 업데이트
            lectureService.updateLectureAutoCancel(lectureApyVo.getLecture_apy_idx());

            if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                LectureVo lectureVo = lectureService.selectLecureInfoByIdx(lectureApyVo.getLecture_idx());
                GroupVo groupVo = lectureService.selectGroupInfoByIdx((int) lectureVo.getGroup_idx());

                StringBuffer sb = new StringBuffer();
                sb.append("[송파구청 송파쌤(SSEM)]");
                sb.append("\r\n");
                sb.append(String.format("%s님의 프로그램 신청이 취소되었습니다.", lectureApyVo.getApy_name()));
                sb.append("\r\n");
                sb.append("<취소내역>");
                sb.append("\r\n");
                sb.append(String.format("- 프로그램: %s", lectureVo.getName()));
                sb.append("\r\n");
                sb.append("감사합니다.");
                sb.append("\r\n");
                sb.append(String.format("☎ 문의: %s", groupVo.getTel_no()));
                sb.append("\r\n");
                sb.append(String.format("송파쌤(SSEM) %s", groupVo.getName()));

                msgService.sendMsgKakao("신청취소 안내", sb.toString(), lectureApyVo.getApy_name(), lectureApyVo.getApy_mob_no().replaceAll("-", ""), "10206");
            }
        }
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
}
