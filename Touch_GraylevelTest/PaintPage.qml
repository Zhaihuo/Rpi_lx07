import QtQuick
import QtQuick.Controls

Rectangle {
    property real startX
    property real startY
    property real stopX
    property real stopY
    property bool isMouseMoveEnable: false
    property alias canvas: canvas
    border.color: "#666"
    border.width: 4

    Canvas{
        id:canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d")
            ctx.lineWidtn = 3
            ctx.strokeStyle = "blue"

            //开始绘制
            ctx.beginPath()
            ctx.moveTo(startX,startY)
            //记录鼠标开始的位置坐标点
            startX = area.mouseX
            startY = area.mouseY
            ctx.lineTo(startX,startY)
            ctx.stroke()
        }
    }
    MouseArea   {
        id:area
        anchors.fill: parent
        //当鼠标按下时调用本函数
        onPressed: {
            isClicked = true
            startX = mouseX
            startY = mouseY
            isMouseMoveEnable = true

        }
        onReleased: {
            isMouseMoveEnable = false
            canvas.requestPaint()
        }
        onPositionChanged: {
            if(isMouseMoveEnable)
            {
                canvas.requestPaint()
            }
        }
    }
    Rectangle{
        width: 100
        height: 50
        color: "#50303030"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        radius: 10
        Text {
            anchors.centerIn:parent
            font.pixelSize: 24
            color: "#ffffff"
            text: qsTr("clear")
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                canvas.context.clearRect(0,0,canvas.width,canvas.height)
                canvas.requestPaint()
            }
        }
    }
}
