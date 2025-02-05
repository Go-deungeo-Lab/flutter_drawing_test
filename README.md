
# Flutter Drawing App - 기술 설명

## 주요 구성 요소

### DrawingCanvas 위젯
```dart
class DrawingCanvas extends StatefulWidget {
  @override
  DrawingCanvasState createState() => DrawingCanvasState();
}
```
- StatefulWidget을 사용하는 이유: 그림을 그릴 때마다 상태(선, 점 등)가 변경되어야 하기 때문
- 사용자의 입력에 따라 지속적으로 화면을 업데이트하기 위해 필수적

### 상태 관리 (DrawingCanvasState)
```dart
class DrawingCanvasState extends State<DrawingCanvas> {
  List<DrawingPoint?> drawingPoints = []; // 그려진 점들을 저장
  double strokeWidth = 2.0; // 선 굵기 기본값
```
- `drawingPoints`: 사용자가 그린 모든 점의 위치와 스타일 정보를 저장
- `strokeWidth`: 현재 선의 굵기를 관리

### 그리기 기능 구현
1. 터치/펜 입력 감지
```dart
onPointerDown: (PointerDownEvent event) {
  setState(() {
    drawingPoints.add(
      DrawingPoint(
        offset: event.localPosition, // 터치 위치
        paint: Paint()
          ..color = Colors.black
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      ),
    );
  });
}
```
- `onPointerDown`: 화면 터치 시작 시 호출
- `onPointerMove`: 터치하며 이동할 때 호출
- `onPointerUp`: 터치 종료 시 호출

2. CustomPainter를 통한 실제 그리기
```dart
class _DrawingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length - 1; i++) {
      if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        canvas.drawLine(
          drawingPoints[i]!.offset,
          drawingPoints[i + 1]!.offset,
          drawingPoints[i]!.paint,
        );
      }
    }
  }
}
```
- 연속된 두 점 사이를 선으로 연결하여 부드러운 선 생성
- null 값은 선과 선 사이의 구분자로 사용

### 유틸리티 기능
```dart
void updateStrokeWidth(double width) {
  setState(() {
    strokeWidth = width;
  });
}

void clear() {
  setState(() {
    drawingPoints.clear();
  });
}
```
- `updateStrokeWidth`: 선 굵기 업데이트
- `clear`: 캔버스 초기화

## 작동 원리
1. 사용자가 화면을 터치하거나 Apple Pencil로 그리면 위치 감지
2. 감지된 각 점들을 `drawingPoints` 리스트에 저장
3. `CustomPainter`가 저장된 점들을 기반으로 선을 그림
4. 연속된 점들을 부드러운 선으로 연결
5. 상태 변화가 있을 때마다 화면 업데이트

## 특징
- 선 굵기 조절 가능
- 부드러운 그리기 경험 제공
- 전체 지우기 기능
- iPad에서 Apple Pencil 지원

굿노트가 어케 돌아가는지 궁금해서 해봤음 

![IMG_1317](https://github.com/user-attachments/assets/1c788a07-fcf9-4b68-a866-4aa758bdbed6)

