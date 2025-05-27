

다음의 타임라인 구조를 프로그램으로 만들기 위함
<img width="986" alt="스크린샷 2025-05-10 오후 12 29 51" src="https://github.com/user-attachments/assets/bbd57dc5-4012-48b5-a43d-bd8c2806df62" />

REST API 설계
https://hulking-mangosteen-b98.notion.site/TimeLine-API-1fe0b3bb32d480f99ac0dbd7e0c80703?pvs=4

# 🛠️ REST API 명세서

## 📌 기본 정보
- **API 버전**: v1
- **Base URL**: `https://api.example.com/v1`
- **응답 포맷**: `JSON`

---

## 📍 1. 사용자 목록 조회 (`GET /users`)
**사용자 목록을 조회하는 API입니다.**

### ✅ 요청
- **HTTP Method**: `GET`
- **URL**: `/users`
- **Headers**:  
  - `Authorization: Bearer {token}`
  - `Accept: application/json`

### ✅ 응답 예시
```json
{
    "status": "success",
    "data": [
        {
            "id": 1,
            "name": "John Doe",
            "email": "john@example.com"
        },
        {
            "id": 2,
            "name": "Jane Doe",
            "email": "jane@example.com"
        }
    ]
}
```

✅ 응답 코드
상태 코드	설명
200 OK	성공적으로 사용자 목록 조회
401 Unauthorized	인증 실패
500 Internal Server Error	서버 오류
📍 2. 사용자 생성 (POST /users)
새로운 사용자를 등록하는 API입니다.

✅ 요청
HTTP Method: POST

URL: /users

Headers:

Authorization: Bearer {token}

Content-Type: application/json

Accept: application/json

Body:

json
{
    "name": "Alice",
    "email": "alice@example.com",
    "password": "securepassword"
}
✅ 응답 예시
json
{
    "status": "success",
    "data": {
        "id": 3,
        "name": "Alice",
        "email": "alice@example.com"
    }
}
✅ 응답 코드
상태 코드	설명
201 Created	사용자 생성 성공
400 Bad Request	요청 데이터 오류
500 Internal Server Error	서버 오류
📌 기타 참고사항
모든 API 요청은 Authorization 헤더를 포함해야 합니다.

응답 데이터는 JSON 포맷을 따릅니다.

더 자세한 사항은 공식 문서를 참고하세요.

Flutter를 통해 개발중인 화면
![image](https://github.com/user-attachments/assets/ad219949-e1c3-4e58-b6bf-c64a52b911f6)
