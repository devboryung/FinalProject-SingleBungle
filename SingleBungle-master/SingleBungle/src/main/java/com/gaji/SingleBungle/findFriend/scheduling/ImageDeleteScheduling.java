package com.gaji.SingleBungle.findFriend.scheduling;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gaji.SingleBungle.findFriend.model.service.FindFriendService;

@Component
public class ImageDeleteScheduling {

	@Autowired
	private ServletContext servletContext;

	@Autowired
	private FindFriendService service;

	@Scheduled(cron = "0 0 0 * * *")
	//@Scheduled(cron = "0 * * * * *") // test
	public void deleteImage() {

		String savePath = servletContext.getRealPath("/resources/findFriendImages");

		File folder = new File(savePath);

		File[] fileList = folder.listFiles(); // savePath 폴더에 있는 모든 이미지 파일이 배열로 반환

		// fileList에서 최근 3일을 제외한 나머지 이미지 파일만 새로운 List에 저장
		List<File> serverFileList = new ArrayList<File>();

		// 3일전
		Date threeDaysAgo = new Date(System.currentTimeMillis() - (3 * 24 * 60 * 60 * 1000));
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHH");

		// 3일 전 날짜가 지정된 패턴 모양의 문자열로 변환됨
		String standard = sdf.format(threeDaysAgo);

		for (File file : fileList) {

			// fileList 배열에 반복 접근하여 파일명만 얻어오기
			String fileName = file.toString().substring(file.toString().lastIndexOf("\\") + 1);
			// System.out.println(file.toString());
			// System.out.println(fileName);

			if (standard.compareTo(fileName.substring(0, 8)) >= 0) {

				serverFileList.add(file);
			}

		}

		// 2) DB 이미지 정보 파일 리스트
		List<String> dbFileList = service.selectDBFileList();

		// 2. 두 리스트를 비교하여 불일치 되는 서버 이미지 파일을 삭제
		// db에서 조회된 파일이 있고 서버에 3일 이상 저장된 파일이 있을 경우
		if (dbFileList != null && !serverFileList.isEmpty()) {

			// serverFileList 반복 접근
			for (File serverFile : serverFileList) {

				String fileName = serverFile.toString().substring(serverFile.toString().lastIndexOf("\\") + 1);

				// indexOf(비교값) : 비교값이 List에 존재하면 해당 index 반환, 없으면 -1 반환
				if (dbFileList.indexOf(fileName) < 0) {
					serverFile.delete();
					System.out.println(fileName + " 삭제");
				}

			}

		}

	}
}
