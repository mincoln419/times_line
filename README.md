

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


Flutter를 통해 개발중인 화면
![image](https://github.com/user-attachments/assets/ad219949-e1c3-4e58-b6bf-c64a52b911f6)
