package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.repository.tibero.CommonRepoistory;
import kr.go.songpa.ssem.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-09-16
 * Description :
 * History :
 * Version :
 */
@Service
public class CommonServiceImpl implements CommonService {
    @Autowired
    private CommonRepoistory commonRepoistory;

    @Override
    public String getNextStringId() throws Exception {
        String nextStringId = commonRepoistory.getNextStringId();
        commonRepoistory.setNextStringId();
        return nextStringId;
    }
}
