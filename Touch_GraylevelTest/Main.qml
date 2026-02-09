import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import CppData
Window {
    id: mainWindow
    width: 1280
    height: 412
    visible: true
    property int pageIndex: 0
    readonly property int totalImages: 261 // 总共260张
    // 根据序号生成图片路径的函数（根据你的实际文件名修改）
    function getImageSource(index) {
    // 假设文件名是 test001.png ~ test260.png

    if(index == 4)
    {
        return "images/test" + (index).toString().padStart(3, '0') + ".bmp";
    }
    else
    {
        return "images/test" + (index).toString().padStart(3, '0') + ".png";

    }
    // 或者如果是 pic00.png ~ pic259.png
    // return "images/pic" + index.toString().padStart(2, '0') + ".png";
    // 再或者如果是 image_0001.png ~ image_0260.png
    // return "images/image_" + (index + 1).toString().padStart(4, '0') + ".png";
}
Item {
    anchors.fill: parent
    Repeater {
    model: totalImages // 0 ~ 260
    DefaultPage {
    width: parent.width
    height: parent.height
    source: getImageSource(index)
    visible: (index === pageIndex)
        }
    }
}
CppToQmlData {
    id: cpp
}

Timer {
    interval: 500
    running: true
    repeat: true
        onTriggered: {
        pageIndex = cpp.getUartValue()
        }
    }
}