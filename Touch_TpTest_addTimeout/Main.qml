import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import CppData

Window {
    property bool isExit: false
    property bool isClicked: false
    property int pageIndex: 0
    property int getValue: 0
    id: mainWindow
    width: 1280
    height: 412
    visible: true
    Item {
        width: mainWindow.width
        height: 412
        DefaultPage {
            width: parent.width
            height: parent.height
            // source: "images/45hz/45hz_1.png"
            source: "images/60hz/60hz_1.png"
            visible: if (pageIndex == 0)
                         return true
                     else
                         return false
        }
        DefaultPage {
            width: parent.width
            height: parent.height
            // source: "images/45hz/45hz_2.png"
            source: "images/60hz/60hz_2.png"
            visible: if (pageIndex == 1)
                         return true
                     else
                         return false
        }

        CalibrationPage {
            id:calibrationPage
            width: parent.width
            height: parent.height
            visible: if (pageIndex == 2)
                         return true
                     else
                         return false
        }
        ColorChangePage {
            id:colorPage
            width: parent.width
            height: parent.height
            visible: if (pageIndex == 3)
                         return true
                     else
                         return false
        }
        PaintPage {
            id:paintPage
            width: parent.width
            height: parent.height
            visible: if (pageIndex == 4)
                         return true
                     else
                         return false
        }
    }
    Rectangle {
        id: button
        x:parent.width-width-10
        y:parent.height-height-100
        width: 100
        height: width/2
        radius: 10
        color: "#23aaf2"
        opacity: 0.5
        visible: isClicked?true:false
        Text {
            anchors.centerIn: parent
            text: qsTr("OK")
            color: "#ffffff"
            font.pixelSize:     36
        }
        MouseArea {
            anchors.fill: parent
            drag.target: button
            drag.maximumX: 1230
            drag.minimumX: 0
            drag.maximumY: 670
            drag.minimumY: 0
            onClicked: {
                isClicked = false
                pageIndex++
                if (pageIndex >= 5)
                {
                    pageIndex = 0
                    isClicked = true
                    calibrationPage.calibrationNum = 0
                    colorPage.clickNum = 0
                    colorPage.imgNum = 0
                    colorPage.source = "images/pic0" + colorPage.imgNum + ".png"
                }

            }
        }

    }
    CppToQmlData{
        id:cpp
    }
    onPageIndexChanged: {
        if(pageIndex == 1)
        {
            isClicked = true
        }

        if(pageIndex == 0)
        {
            cpp.qmlValue(true)
            paintPage.canvas.context.clearRect(0,0,paintPage.canvas.width,paintPage.canvas.height)
            paintPage.canvas.requestPaint()
        }
        else
            cpp.qmlValue(false)
    }

    Timer {
        id: timer
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            getValue = cpp.getUartValue()
            if(( getValue== 1) && (pageIndex == 0))
            {
//                isClicked = true

            }
        }
    }
    onIsClickedChanged: {
        console.log(isClicked)
    }

}
