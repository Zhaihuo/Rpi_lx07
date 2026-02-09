import QtQuick

Rectangle {
    property int calibrationNum: 0
    color: "#50202020"
    Image {
        id: img
        x: parent.width * Math.random()
        y: parent.height * Math.random()
        source: "images/calibration.png"
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        onClicked: {
            if (((mouseX < img.x + img.width*1.5) && (mouseX > img.x-img.width/2))
                    && ((mouseY < img.y + img.height*1.5) && (mouseY > img.y-img.height/2))) {
                img.x = (parent.width - img.width) * Math.random()
                img.y = (parent.height - img.height) * Math.random()
                calibrationNum ++
            }
            if(calibrationNum>=5)
            {
                isClicked = true
            }
        }
    }
}
