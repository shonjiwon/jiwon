package kr.go.songpa.ssem.repository.tibero;

import kr.go.songpa.ssem.model.FileVo;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.repository.tibero
 * Author : shlee
 * Date : 2020-09-16
 * Description :
 * History :
 * Version :
 */
public interface FileMngRepository {
    void insertFileMaster(FileVo vo) throws Exception;

    void insertFileDetail(FileVo vo) throws Exception;

    void updateFileDetail(FileVo vo) throws Exception;

    FileVo selectFileInf(FileVo vo) throws Exception;

    List<FileVo> selectFileList(FileVo vo) throws Exception;

    void deleteFileInf(FileVo vo) throws Exception;

    int getMaxFileSN(FileVo vo) throws Exception;

    List<FileVo> selectFileAll() throws Exception;

    void deleteAllFileInf(FileVo fvo) throws Exception;

    void updateFileDetailEx(FileVo f) throws Exception;
}
