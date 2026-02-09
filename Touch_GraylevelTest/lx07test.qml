import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import CppData

Window {
    property bool isExit: false
    property bool isClicked: true
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
            source: "images/Default.jpg"
            visible: if (pageIndex == 0)
                         return true
                     else
                         return false
        }
        DefaultPage {
            width: parent.width
            height: parent.height
            //source: "images/pic00.png"
            source: "images/test01.png"
            visible: if (pageIndex == 1)
                         return true
                     else
                         return false
        }
        DefaultPage {
            width: parent.width
            height: parent.height
            //source: "images/pic01.png"
            source: "images/test04.png"
            visible: if (pageIndex == 2)
                         return true
                     else
                         return false
        }
        DefaultPage {
            width: parent.width
            height: parent.height
            source: "images/pic02.png"
            visible: if (pageIndex == 3)
                         return true
                     else
                         return false
        }
        DefaultPage {
            width: parent.width
            height: parent.height
            source: "images/pic03.png"
            visible: if (pageIndex == 4)
                         return true
                     else
                         return false
        }
        DefaultPage {
            width: parent.width
            height: parent.height
            source: "images/pic04.png"
            visible: if (pageIndex == 5)
                         return true
                     else
                         return false
        }
        DefaultPage {
            width: parent.width
            height: parent.height
            source: "images/pic05.png"
            visible: if (pageIndex == 6)
                         return true
                     else
                         return false
        }
//        DefaultPage {
//            width: parent.width
//            height: parent.height
//            source: "images/test07.png"
//            visible: if (pageIndex == 6)
//                         return true
//                     else
//                         return false
//        }
//        MouseArea{
//            anchors.fill: parent
//            onClicked: {
//                pageIndex++
//                if(pageIndex >6)
//                    pageIndex = 0
//            }
//        }
    }
    CppToQmlData{
        id:cpp
    }
//    onPageIndexChanged: {
//        if(pageIndex == 1)
//        {
//            isClicked = true
//        }
//        if(pageIndex == 0)
//        {
//            cpp.qmlValue(true)
//            paintPage.canvas.context.clearRect(0,0,paintPage.canvas.width,paintPage.canvas.height)
//            paintPage.canvas.requestPaint()
//            console.log("pageIndex:",pageIndex)
//        }
//        else

//            cpp.qmlValue(false)

//    }

    Timer {
        id: timer
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            pageIndex = cpp.getUartValue()
        }
    }

}
