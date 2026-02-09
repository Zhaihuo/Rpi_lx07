import QtQuick
import QtQuick.Controls

Image {
    id: root
    property int imgNum: 0
    property int clickNum: 0
    source: "images/pic00.png"
    Item {
        id: mouseArea
        width: mainWindow.width
        height: mainWindow.height
        anchors.bottom: parent.bottom
        MouseArea {
            anchors.bottom: parent.bottom
            height: parent.height
            width: parent.width
            preventStealing: true
            property real velocity: 0.0
            property int xStart: 0
            property int xPrev: 0
            onPressed: {
                xStart = mouseX
                xPrev = mouseX
                velocity = 0
            }
            onPositionChanged: {
                var currVel = (mouseX - xPrev)
                velocity = (velocity + currVel) / 2.0
                xPrev = mouseX
            }
            onReleased: {
                if (velocity < 0) {
                    imgNum++
                    clickNum++
                    if (imgNum > 5) {
                        imgNum = 0
                    }
                    if(imgNum >= 5)
                    {
                        isClicked = true
                    }
                    root.source = "images/pic0" + imgNum + ".png"
                    // SWIPE DETECTED !! EMIT SIGNAL or DO your action
                }
                /*else if (velocity < 0) {
                    imgNum--
                    if (imgNum < 0) {
                        imgNum = 5
                    }
                    root.source = "images/pic0" + imgNum + ".png"
                }*/
            }
        }
    }
//    onImgNumChanged: {
//        console.log("imgNum: ",imgNum)
//    }
} //Rectangle {//    ListModel {//        id: model
//        ListElement {
//            color: "#121212"
//        }
//        ListElement {
//            color: "#232323"
//        }
//        ListElement {
//            color: "#343434"
//        }
//    }
//    Component {
//        id: delegate
//        Rectangle {
//            id: wrapper
//            width: view.width
//            height: view.height
//            color: model.color
//        }
//    }
//    PathView {
//        id: view
//        anchors.fill: parent
//        snapMode: PathView.SnapOneItem
//        highlightRangeMode: PathView.StrictlyEnforceRange
//        highlightMoveDuration: 10
//        maximumFlickVelocity: 50000
//        currentIndex: -1
//        model: model
//        delegate: delegate
//        path: Path {
//            startX: -view.width / 2 // let the first item in left
//            startY: view.height / 2 // item's vertical center is the same as line's
//            PathLine {
//                relativeX: view.width * view.model.count // all items in lines
//                relativeY: 0
//            }
//        }
//    }
//    PageIndicator {
//        id: indicator

//        count: view.count
//        currentIndex: view.currentIndex+1

//        anchors.bottom: view.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
//    }
//}
//Rectangle {
//    SwipeView {
//        id: view

//        currentIndex: 0
//        anchors.fill: parent
//        interactive: true
//        Rectangle {
//            id: firstPage
//            color: "#121212"
//        }
//        Rectangle {
//            id: secondPage
//            color: "#232323"
//        }
//        Rectangle {
//            id: thirdPage
//            color: "#343434"
//        }
//    }

//    PageIndicator {
//        id: indicator

//        count: view.count
//        currentIndex: view.currentIndex

//        anchors.bottom: view.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
//    }

////    MouseArea {
////        anchors.fill: parent
////        onClicked: {
////            parent.color = Qt.rgba(Math.random(), Math.random(),
////                                       Math.random(), 1)
////        }
////    }
//}

