# FinalProject - SingleBungle


<!-- contents -->
<details open="open">
  <summary>Contents</summary>
  <ol>
    <li>
      <a href="#개요">개요</a>
    </li>
    <li>
      <a href="#팀원별-역할">팀원별 역할</a>
    </li>
    <li>
      <a href="#설계의-주안점">설계의 주안점</a>
    </li>
    <li>
      <a href="#DB-설계">DB 설계</a>
    </li>
    <li><a href="#구현-기능">구현 기능</a>
      <ul>
        <li><a href="#싱글이의-영수증-목록-조회">싱글이의 영수증 목록 조회</a></li>
        <li><a href="#게시글-검색하기">게시글 검색하기</a></li>
        <li><a href="#게시글-등록하기">게시글 등록하기</a></li>
        <li><a href="#게시글-상세조회">게시글 상세조회</a></li>
        <li><a href="#게시글-수정하기">게시글 수정하기</a></li>
        <li><a href="#게시글-삭제하기">게시글 삭제하기</a></li>
        <li><a href="#게시글-좋아요">게시글 좋아요</a></li>
        <li><a href="#댓글,답글">댓글,답글</a></li>
        <li><a href="#게시글,댓글-신고">게시글,댓글 신고</a></li>
      </ul>
       <ul>
        <li><a href="#쪽지-보내기-버튼">쪽지 보내기 버튼</a></li>
        <li><a href="#쪽지-보내기">쪽지 보내기</a></li>
        <li><a href="#쪽지함">쪽지함</a></li>
        <li><a href="#받은-쪽지함">받은 쪽지함</a></li>
        <li><a href="#보낸-쪽지함">보낸 쪽지함</a></li>
      </ul>
    </li>
  </ol>
</details>


# ![단체](https://user-images.githubusercontent.com/73421820/112747171-8e75b800-8fee-11eb-8d46-61f14ba3dc8d.png)개요 

* 프로젝트 명 : SingleBungle
* 일정 : 2021.01.29 ~ 2021.03.11
* 개발 목적 : 1인 가구의 정보를 공유하고 소통할 수 있는 커뮤니티 사이트 제작
* 개발 환경
  - OS : Windows 10
  - WAS :  Apache-tomcat-8.5.61
  - Java EE IDE : Eclipse ( version 2020-06 (4.16.0) )  
  - Database : Oracle SQL Developer ( version 20.2.0 )
  - Programming Language : JAVA, HTML, CSS, JavaScript, JSP, SQL
  - Framework/flatform : Spring, mybatis, jQuery 3.5.1, Bootstrap v4.6.x
  - API : WebSocket, Kakao map, summernote
  - Version management : Git

------------

##### ![팀원](https://user-images.githubusercontent.com/73421820/112724869-adc20600-8f58-11eb-99c4-6c104cb1c4ec.png)팀원별 역할

```
공통 : 기획, 요구 사항 정의, 와이어 프레임, DB 설계
강보령 : 싱글이의 영수증 게시판 CRUD, 쪽지
강수정 : 만남의 광장 게시판 CRUD, 채팅
김현혜 : 공지사항 게시판 CRUD, 고객센터 게시판 CRUD, 관리자
신주희 : 회원가입, 로그인, 마이페이지
이솔이 : 일상을 말해봐 게시판 CRUD, 먹보의 하루 게시판 CRUD
이한솔 : 벙글 장터 게시판 CRUD
```

------------

##### ![체크](https://user-images.githubusercontent.com/73421820/112724945-0d201600-8f59-11eb-9c07-d79ad0d5775f.png)설계의 주안점
```
- 먹보의 하루 게시판 글 작성 시 맛집 위치를 지도에 표시할 수 있도록 할 것.
- 벙글 장터 게시판 글 작성 시 작성자의 동네 위치를 인증할 것.
- 만남의 광장 게시판 참여 회원 간의 채팅이 가능할 수 있도록 할 것.
- 벙글 장터, 만남의 광장 게시판 이용 시 회원 간의 쪽지 보내기/받기가 가능하게 할 것.
```
------------

##### ![체크](https://user-images.githubusercontent.com/73421820/112724945-0d201600-8f59-11eb-9c07-d79ad0d5775f.png)DB 설계
![singlebungleDB](https://user-images.githubusercontent.com/73421820/112747261-21aeed80-8fef-11eb-88cb-83510ff7f43f.png)

------------

# ![노트북](https://user-images.githubusercontent.com/73421820/112725392-55403800-8f5b-11eb-9247-c772e4c09493.png)구현 기능

## 싱글이의 영수증

### 싱글이의 영수증 목록 조회

- 화면 설명 : 구매 후기를 올리는 게시판인 싱글이의 영수증의 목록이 조회됩니다.
- 관련 코드는 <a href="https://devboryung.github.io/finalproject/final-1/">이곳</a>에서 확인하실 수 있습니다.
![image](https://user-images.githubusercontent.com/73421820/112748665-3cd22b00-8ff8-11eb-92e0-64fe8da6c36c.png)


- 구현 기능 설명
  - 페이지의 Header에서 싱글이의 영수증을 클릭하면 등록된 게시글의 목록이 출력됩니다.
  - 등록 시 가장 상단에 올린 이미지가 썸네일로 지정되며, 게시글의 정보가 출력됩니다.
  - 오늘 작성한 글일 경우 00:00 형태로 시간이 표시되며, 오늘 작성한 게시글이 아닐 경우 날짜가 출력됩니다.
  - 본인이 좋아요를 누른 게시글일 경우 빨간색 하트로 표시됩니다.
  - 카테고리별로 배경색이 다른 배지가 적용됩니다.
  - 한 페이지당 9개의 게시글이 조회되며 페이징 바를 이용해 다른 페이지로 이동할 수 있습니다.

------------

### 게시글 검색하기
- 화면 설명 :  원하는 게시글만 조회할 수 있습니다.
- 관련 코드는 <a href="https://devboryung.github.io/finalproject/final-6/">이곳</a>에서 확인하실 수 있습니다.
![게시글 검색](https://user-images.githubusercontent.com/73421820/112747774-6e47f800-8ff2-11eb-953d-924f3abd4338.gif)
- 구현 기능 설명
    - 상단의 카테고리로 원하는 카테고리를 선택해서 조회할 수 있습니다.
    - 최신순, 좋아요 순으로 정렬할 수 있습니다.
    - 검색어 입력 시 현재 클릭해 놓은 카테고리와 정렬이 유지됩니다.
    - 검색어가 포함되는 게시글들이 조회됩니다.
------------

### 게시글 등록하기
- 화면 설명 : 등록하기 버튼을 누르면 게시글 등록 화면으로 이동됩니다.
- 관련 코드는 <a href="https://devboryung.github.io/finalproject/final-3/">이곳</a>에서 확인하실 수 있습니다.
![게시글 등록](https://user-images.githubusercontent.com/73421820/112747918-6177d400-8ff3-11eb-98cb-850212ccf2a7.gif)


- 구현 기능 설명
  - 등록하기 버튼을 누르면 summernote를 사용한 게시글 작성 화면이 나타납니다.
  - 편의를 위해서 최소한의 정보만 입력받습니다.
  - 제목과 내용을 작성하지 않으면 alert창이 나타납니다.
  ![image](https://user-images.githubusercontent.com/73421820/112747995-fc70ae00-8ff3-11eb-9d96-8567598b5134.png)
  - 취소 버튼을 누르면 목록으로 돌아갑니다.
  - 등록 버튼을 누르면 게시글이 등록되며 상세조회 페이지로 이동합니다.
------------

### 게시글 상세조회
- 화면 설명 : 원하는 게시글을 클릭하면 상세조회 페이지로 이동됩니다.
- 관련 코드는 <a href="https://devboryung.github.io/finalproject/final-2/">이곳</a>에서 확인하실 수 있습니다.
![게시글 상세조회](https://user-images.githubusercontent.com/73421820/112748063-53768300-8ff4-11eb-8b72-6385ed88f63f.gif)


- 구현 기능 설명
  - 어느 게시글을 보고있는지 확인하기 쉽도록 게시판의 이름과 카테고리가 출력됩니다.
  - 작성자의 회원 등급에 맞는 등급 아이콘이 출력됩니다.
  - 댓글 작성창이 있습니다.
  - 페이지 하단에 해당 게시판의 조회수 TOP 3인 게시글의 목록이 출력되며 클릭할 경우 상세조회 페이지로 이동합니다.
------------

### 게시글 수정하기
- 화면 설명 : 해당 게시글을 업로드한 회원으로 로그인하면 수정 버튼이 나타납니다.
- 관련 코드는 <a href="https://devboryung.github.io/finalproject/final-4/">이곳</a>에서 확인하실 수 있습니다.
![게시글 수정](https://user-images.githubusercontent.com/73421820/112748359-16ab8b80-8ff6-11eb-80d8-bc9275e77941.gif)


- 구현 기능 설명
  - 기존에 등록한 게시글의 정보가 출력됩니다.
  - 등록할 때와 마찬가지로 제목과 내용은 필수로 입력해야 합니다.
  - 취소 버튼을 누르면 상세조회 페이지로 돌아갑니다. 
  - 수정 버튼을 누르면 수정된 정보로 상세조회 페이지가 나타납니다.
------------

### 게시글 삭제하기
- 화면 설명 : 해당 게시글을 업로드한 회원으로 로그인하면 삭제 버튼이 나타납니다.
- 관련 코드는 <a href="https://devboryung.github.io/finalproject/final-5/">이곳</a>에서 확인하실 수 있습니다.
![게시글 삭제](https://user-images.githubusercontent.com/73421820/112748430-81f55d80-8ff6-11eb-83b7-c0e6cd67f7b1.gif)


- 구현 기능 설명
    - 삭제 버튼을 누르면 confirm창이 뜹니다.
    - 확인 버튼을 누르면 게시글이 삭제되면서 목록으로 이동됩니다.
------------


### 게시글 좋아요
- 화면 설명 : 마음에 드는 게시글일 경우 상세조회 페이지에서 좋아요를 클릭할 수 있습니다. 
![게시글 좋아요](https://user-images.githubusercontent.com/73421820/112748219-558d1180-8ff5-11eb-92f1-1c183813b5b9.gif)

- 구현 기능 설명
    - AJAX를 이용해 비동기로 하트 모양과 좋아요 수가 변경됩니다.
------------

### 댓글,답글
- 화면 설명 : 게시글에 댓글 및 답글을 작성할 수 있습니다.
- 관련 코드는 <a href="https://devboryung.github.io/finalproject/final-8/">이곳</a>에서 확인하실 수 있습니다.
![댓답글](https://user-images.githubusercontent.com/73421820/112748624-e2d16580-8ff7-11eb-9169-43e680341a0b.gif)

- 구현 기능 설명
    - ajax를 통해 비동기적으로 작성 가능합니다.
    - 원하는 게시글에 댓글을 작성할 수 있으며, 댓글 작성 후 수정 및 삭제가 가능합니다.
    - 다른 사람이 작성한 댓글에 답글을 작성할 수 있으며, 답글 수정 및 삭제가 가능합니다.
------------


### 게시글,댓글 신고
- 화면 설명 : 다른 사람이 작성한 게시글 및 댓글을 신고할 수 있습니다.
- 관련 코드는 <a href="https://devboryung.github.io/finalproject/final-7/">이곳</a>에서 확인하실 수 있습니다.
![신고](https://user-images.githubusercontent.com/73421820/112754864-18d31180-9019-11eb-8aa6-dd95d4f16f87.gif)
    
- 구현 기능 설명
    - 신고 버튼을 클릭하면 신고 페이지가 생성됩니다.
    - 신고 제목, 카테고리, 내용을 작성 후 신고 버튼을 누르면 페이지가 닫힙니다. 
    - 관리자 마이페이지에서 신고된 게시글과 댓글을 확인할 수 있으며, 삭제 처리를 할 수 있습니다.

------------

## 쪽지

- 관련 코드는 <a href="https://devboryung.github.io/finalproject/final-9/">이곳</a>에서 확인하실 수 있습니다.

### 쪽지 보내기 버튼

- 화면 설명 : 만남의 광장, 벙글장터 게시판에서 다른 사람의 게시글을 클릭하면 쪽지보내기 버튼이 생성됩니다.
![image](https://user-images.githubusercontent.com/73421820/112755026-e2e25d00-9019-11eb-871e-d1afd95ad297.png)
![image](https://user-images.githubusercontent.com/73421820/112755045-f8f01d80-9019-11eb-9ef8-846b0a22486f.png)

------------

### 쪽지 보내기
- 화면 설명 : 
![친구 쪽지보내기](https://user-images.githubusercontent.com/73421820/112755217-b418b680-901a-11eb-8781-9a4f741e73fe.gif)
![벙개장터 쪽지보내기](https://user-images.githubusercontent.com/73421820/112755215-b0852f80-901a-11eb-83ab-7f7c9a813f56.gif)
- 구현 기능 설명
    - 쪽지 보내기 버튼을 클릭하면 받는 사람 이름으로 작성자의 닉네임이 출력됩니다.
    - 원하는 내용을 작성 후 전송 버튼을 누르면 쪽지를 보낼 수 있습니다.
    - 내용을 입력하지 않으면 alert창이 나타납니다.
     ![image](https://user-images.githubusercontent.com/73421820/112755612-59805a00-901c-11eb-8290-b9df966c2e98.png)
     
    - 쪽지 Modal 
    ![image](https://user-images.githubusercontent.com/73421820/113969100-53397b80-986f-11eb-8cb5-68a1cc3c4be5.png)
------------

### 쪽지함
- 화면 설명 : 1등급 회원으로 로그인하면 헤더에 쪽지함이 나타납니다.
![image](https://user-images.githubusercontent.com/73421820/112755638-7e74cd00-901c-11eb-8726-66ce3cc68c7a.png)
------------

### 받은 쪽지함
- 화면 설명 : 받은 쪽지를 확인할 수 있습니다.
![받은 쪽지함](https://user-images.githubusercontent.com/73421820/112755950-f42d6880-901d-11eb-854c-e44786688ada.gif)

- 구현 기능 설명
  - 메세지의 읽음 상태가 표시됩니다.
  - 내용을 누르면 쪽지가 열리며 답장 버튼을 눌러 답장을 할 수 있습니다.
  - 읽지 않은 쪽지를 클릭하면 AJAX를 통해 메세지의 상태가 변경되며, 메세지 창이 닫히면 상태가 읽음으로 변경됩니다.
  - 보낸 사람의 닉네임을 클릭해서 쪽지를 보낼 수 있습니다.
  - AJAX를 통해 비동기적으로 원하는 쪽지를 삭제할 수 있습니다.
  - 상단의 체크 박스를 클릭하면 전체 쪽지가 선택됩니다. 
------------

### 보낸 쪽지함
- 화면 설명 : 보낸 쪽지를 확인할 수 있습니다.
![보낸 쪽지함](https://user-images.githubusercontent.com/73421820/112755802-4752eb80-901d-11eb-933b-fd71e518db31.gif)

- 구현 기능 설명
  - 내용을 클릭하면 쪽지창이 나타나며 기존에 작성한 내용이 나타납니다.
  - 받는 사람 닉네임을 클릭하면 해당 회원에게 쪽지를 보낼 수 있습니다.
  - AJAX를 통해 비동기적으로 원하는 쪽지를 삭제할 수 있습니다.
  - 상단의 체크 박스를 클릭하면 모든 쪽지가 선택됩니다. 
------------

<p align="center">
감사합니다.<br>
</p>
