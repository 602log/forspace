# forspace

학교, 학원 연습실 예약 프로젝트

### 프로젝트 목적 및 용도
forspace는 연습실 예약을 위해 직접 방문해서 수기로 입력하던 예술학교의 지인을 통해 듣게 된 불편사항을 계기로 만들어졌습니다.<br>
다양한 시설에서 사용할 수 있으며, 예약관리, 불편사항 관리, 회원 관리 등의 기능이 갖추어져 있습니다.

### 사용기술

Front-End
* HTML, CSS3, JavaScript, Bootstrap5, jQuery, Ajax
Back-End
* Java (JDK 1.8), Apache Tomcat 9.0, Project Lombok, Maven, MyBatis, HikariCP
Database
* Oracle Database
Tools
* Spring 5, Spring Security, STS

### 개발기간
* 개발 인원 1명, 약 7주

```
2021/10/21 ~ 2021/11/30
```

### ERD
![image](https://user-images.githubusercontent.com/80696631/144721376-b36f3761-5f48-4216-8c8c-f56d8936152b.png)

### 프로젝트 주요 기능
1. 소속기관별 고유 인증번호가 발급되어 이용자는 회원가입시 반드시 해당 인증번호를 입력해야 한다.
2. 관리자는 연습실 등록, 회원은 연습실 예약, 취소 기능이 제공된다.
3. 관리자가 회원에게 이용을 제한할 수 있다.

--------------------------------------------------------------------------------------------------------------------------------------------

## 프로젝트 기능 및 화면

### 회원가입
* ADMIN
![image](https://user-images.githubusercontent.com/80696631/144720201-f01c32db-3f5e-4219-9a9a-693443395dbb.png)
* USER
![image](https://user-images.githubusercontent.com/80696631/144720345-a15ec83d-7b48-4475-9993-3c3b2795f2f7.png)

### 연습실
* ADMIN : 연습실 등록
![image](https://user-images.githubusercontent.com/80696631/144720246-6212241c-db53-4ada-b69d-639d081267ed.png)
* ADMIN & USER : 연습실 리스트
![image](https://user-images.githubusercontent.com/80696631/144720263-e76ac300-619f-4052-b105-522b360911ad.png)
* ADMIN & USER : 연습실 상세
![image](https://user-images.githubusercontent.com/80696631/144735182-78d81a49-4027-41d2-b380-7cde7813b5d4.png)


### 예약
* ADMIN
![image](https://user-images.githubusercontent.com/80696631/144735153-133a092e-24fc-46f2-9568-ab4ddd72b0ac.png)
* USER
![image](https://user-images.githubusercontent.com/80696631/144735218-e0615ea8-0e6b-41d6-be1f-8a03c9419efd.png)

### 이용제한
* ADMIN
![image](https://user-images.githubusercontent.com/80696631/144720366-f466dec5-c78f-462b-a09a-e387d87437ef.png)

### 공지사항
![image](https://user-images.githubusercontent.com/80696631/144720375-316ddbfb-6081-4671-b0c8-10d43844fbe4.png)

### 불편사항
* ADMIN & USER
![image](https://user-images.githubusercontent.com/80696631/144720910-6b48c3e4-d83a-472c-9ee7-d88d680279de.png)


---------------------------------------------------------------------------------------------------------------
