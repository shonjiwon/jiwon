package kr.go.songpa.ssem.service;

import kr.go.songpa.ssem.model.FileVo;

import java.util.List;
import java.util.Map;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2020-09-16
 * Description :
 * History :
 * Version :
 */
public interface FileMngService {
    /**
     * 파일에 대한 목록을 조회한다.
     *
     * @param fvo
     * @return
     * @throws Exception
     */
    List<FileVo> selectFileInfs(FileVo fvo) throws Exception;

    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     *
     * @param fvo
     * @throws Exception
     */
    String insertFileInf(FileVo fvo) throws Exception;

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     *
     * @param fvoList
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    String insertFileInfs(List fvoList) throws Exception;

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     *
     * @param fvoList
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    void updateFileInfs(List fvoList) throws Exception;

    /**
     * 여러 개의 파일을 삭제한다.
     *
     * @param fvoList
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    void deleteFileInfs(List fvoList) throws Exception;

    /**
     * 하나의 파일을 삭제한다.
     *
     * @param fvo
     * @throws Exception
     */
    void deleteFileInf(FileVo fvo) throws Exception;

    /**
     * 파일에 대한 상세정보를 조회한다.
     *
     * @param fvo
     * @return
     * @throws Exception
     */
    FileVo selectFileInf(FileVo fvo) throws Exception;

    /**
     * 파일 구분자에 대한 최대값을 구한다.
     *
     * @param fvo
     * @return
     * @throws Exception
     */
    int getMaxFileSN(FileVo fvo) throws Exception;

    /**
     * 전체 파일을 삭제한다.
     *
     * @param fvo
     * @throws Exception
     */
    void deleteAllFileInf(FileVo fvo) throws Exception;

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     *
     * @param fvo
     * @return
     * @throws Exception
     */
    Map<String, Object> selectFileListByFileNm(FileVo fvo) throws Exception;

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     *
     * @param vo
     * @return
     * @throws Exception
     */
    List<FileVo> selectImageFileList(FileVo vo) throws Exception;

    /**
     * 이미지 세부 정보를 입력한다.
     * @param newfileList
     * @throws Exception
     */
    void insertFileDetailInfs(List<FileVo> newfileList)throws Exception;

    void updateFileInf(FileVo f) throws Exception;
}
