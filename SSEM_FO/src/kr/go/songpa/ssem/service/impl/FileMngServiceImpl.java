package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.FileVo;
import kr.go.songpa.ssem.repository.tibero.FileMngRepository;
import kr.go.songpa.ssem.service.FileMngService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-09-16
 * Description :
 * History :
 * Version :
 */
@Service
public class FileMngServiceImpl implements FileMngService {
    protected final static Logger logger = LoggerFactory.getLogger(FileMngServiceImpl.class);

    @Autowired
    private FileMngRepository fileMngRepository;

    @Override
    public List<FileVo> selectFileInfs(FileVo fvo) throws Exception {
        return fileMngRepository.selectFileList(fvo);
    }

    @Transactional(propagation= Propagation.REQUIRED, rollbackFor={Exception.class})
    @Override
    public String insertFileInf(FileVo fvo) throws Exception {
        String atchFileId = fvo.getAtch_file_id();
        if (fvo != null) {
            fileMngRepository.insertFileMaster(fvo);
            fileMngRepository.insertFileDetail(fvo);
        }
        if(atchFileId == ""){
            atchFileId = null;
        }
        return atchFileId;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Exception.class})
    @Override
    public String insertFileInfs(List fvoList) throws Exception {
        FileVo mvo = (FileVo)fvoList.get(0);
        String atchFileId = mvo.getAtch_file_id();
        if (fvoList.size() != 0) {
            fileMngRepository.insertFileMaster(mvo);
            Iterator iter = fvoList.iterator();
            while (iter.hasNext()) {
                FileVo vo = (FileVo)iter.next();
                fileMngRepository.insertFileDetail(vo);
            }
        }
        if(atchFileId == ""){
            atchFileId = null;
        }
        return atchFileId;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Exception.class})
    @Override
    public void insertFileDetailInfs(List<FileVo> newfileList) throws Exception {
        if (newfileList.size() != 0) {
            Iterator iter = newfileList.iterator();
            while (iter.hasNext()) {
                FileVo vo = (FileVo)iter.next();
                fileMngRepository.insertFileDetail(vo);
            }
        }
    }

    @Override
    public void updateFileInf(FileVo f) throws Exception {
        fileMngRepository.updateFileDetailEx(f);
    }

    @Override
    public void updateFileInfs(List fvoList) throws Exception {
        FileVo vo;
        Iterator iter = fvoList.iterator();
        while (iter.hasNext()) {
            vo = (FileVo)iter.next();
            FileVo chkVo = fileMngRepository.selectFileInf(vo);
            if(chkVo == null){
                fileMngRepository.insertFileDetail(vo);
            }else{
                fileMngRepository.updateFileDetail(vo);
            }
        }
    }

    @Override
    public void deleteFileInfs(List fvoList) throws Exception {
        FileVo vo;
        Iterator iter = fvoList.iterator();
        while (iter.hasNext()) {
            vo = (FileVo) iter.next();
            fileMngRepository.deleteFileInf(vo);
        }
    }

    @Override
    public void deleteFileInf(FileVo fvo) throws Exception {
        fileMngRepository.deleteFileInf(fvo);
    }

    @Override
    public FileVo selectFileInf(FileVo fvo) throws Exception {
        return fileMngRepository.selectFileInf(fvo);
    }

    @Override
    public int getMaxFileSN(FileVo fvo) throws Exception {
        return fileMngRepository.getMaxFileSN(fvo);
    }

    @Override
    public void deleteAllFileInf(FileVo fvo) throws Exception {
        fileMngRepository.deleteAllFileInf(fvo);
    }

    @Override
    public Map<String, Object> selectFileListByFileNm(FileVo fvo) throws Exception {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<FileVo> selectImageFileList(FileVo vo) throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
}
