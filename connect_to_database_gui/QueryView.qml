import QtQuick
import QtQuick.Window
import QtQuick.Controls

Item {
    id: main

    signal runClicked()
    signal backClicked()

    property alias table_name: table_name.text
    property var __result: result

    anchors.fill: parent

    Rectangle {
        id:frame

        anchors.fill: parent
        color: "transparent"
        border.color: "black"
        border.width: 3
        radius: 4

        ToolBar {
            id:toolbar

            height: 20
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            background: Rectangle {
                implicitHeight: 20
                implicitWidth: 200
                color: "lightgray"
            }
            Rectangle {
                id: run
                width: 20
                height: 20
                anchors {
                    centerIn: parent
                }
                Image {
                    id: name
                    source: "qrc:/img/play.png"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    id:area

                    anchors.fill: parent
                    onReleased: {result.clear(); runClicked()}
                }
            }
            Button {
                id: back

                width: 65
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                }
                text: "Go Back >"
                font.bold: true
                flat: true

                MouseArea {
                    id: m_area

                    anchors.fill: parent
                    onReleased: backClicked()
                }
            }

        }

        TextField {
            id:table_name

            height:40
            anchors {
                top: toolbar.bottom
                right: toolbar.right
                left: toolbar.left
                topMargin: 4
            }
            background: Rectangle {
                implicitHeight: 200
                implicitWidth: 200
                color: "#eeeeee"
            }
            font {
                pixelSize: 20
                bold: true
            }
            placeholderText: "Enter Table Name And Click Run Icon Above"
        }

        ScrollView {
            id: scrollView

            anchors {
                top: table_name.bottom
                right: parent.right
                left: parent.left
                bottom: parent.bottom
                topMargin: 5
            }
            ScrollBar.vertical.interactive: true
            ScrollBar.horizontal.interactive: true

            TextArea {
                id:result

               anchors.fill: parent
                font.pixelSize: 15
                text: __result
                readOnly: true
            }
        }
    }
}
