import QtQuick
import QtQuick.Window
import QtQuick.Controls

Item {
    id: main

    signal loginclicked()

    property alias plugin: plugin.text
    property alias database: database.text
    property alias hostname: hostname.text
    property alias port: port.text
    property alias username: username.text
    property alias password: password.text

    anchors.fill: parent

    Text {
        id: loginTxt

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 10
        }
        text: qsTr("Login To Database")
        color: "lightblue"
        font.family: "MV Boli"
        style: Text.Raised
        styleColor: "#db2020"
        font.pointSize: 14
    }

    Column {
        id: column

        anchors {
            left: parent.left
            top: loginTxt.bottom
            right: parent.right
            rightMargin: 90
            topMargin: 30
            leftMargin: 5
        }
        spacing: 15

        Text {
            id: pluginTxt

            text: "Plugin: "
            color: "#ffffff"
            font.family: "Sitka Small Semibold"
            font.bold: true
            styleColor: "#db2020"
            font.pointSize: 12

            ToolTip.text: qsTr("Qt Plugins For Sql See (https://doc.qt.io/qt-6/sql-driver.html)")
            ToolTip.visible: mouseArea1.containsMouse
            MouseArea {
                id: mouseArea1
                hoverEnabled: true
                anchors.fill: parent
            }

            TextField {
                id: plugin

                width: column.width
                anchors {
                    left: parent.right
                    verticalCenter: parent.verticalCenter
                }
                font.pixelSize: 15
                text: qsTr("QPSQL")
            }
        }
        Text {
            id: databaseTxt

            text: "Database: "
            color: "#ffffff"
            font.family: "Sitka Small Semibold"
            font.bold: true
            styleColor: "#db2020"
            font.pointSize: 12

            TextField {
                id: database

                width: column.width - 22
                anchors {
                    left: parent.right
                    verticalCenter: parent.verticalCenter
                }
                font.pixelSize: 15
            }
        }
        Text {
            id: hostnameTxt

            text: "HostName: "
            color: "#ffffff"
            font.family: "Sitka Small Semibold"
            font.bold: true
            styleColor: "#db2020"
            font.pointSize: 12

            TextField {
                id: hostname

                width: column.width - 33
                anchors {
                    left: parent.right
                    verticalCenter: parent.verticalCenter
                }
                font.pixelSize: 15
                text: qsTr("localhost")
            }
        }
        Text {
            id: portTxt

            text: "Port: "
            color: "#ffffff"
            font.family: "Sitka Small Semibold"
            font.bold: true
            styleColor: "#db2020"
            font.pointSize: 12
            anchors {
                left: parent.left
                leftMargin: 53
            }

            TextField {
                id: port

                width: column.width - 150
                anchors {
                    left: parent.right
                    verticalCenter: parent.verticalCenter
                }
                font.pixelSize: 15
                text: qsTr("5432")
            }
        }

        Text {
            id: usernameTxt

            text: "Username: "
            color: "#ffffff"
            font.family: "Sitka Small Semibold"
            font.bold: true
            styleColor: "#db2020"
            font.pointSize: 12

            TextField {
                id: username

                width: column.width - 33
                anchors {
                    left: parent.right
                    verticalCenter: parent.verticalCenter
                    leftMargin: 3
                }
                font.pixelSize: 15
                text: qsTr("postgres")
            }
        }
        Text {
            id: passwordTxt

            text: "Password: "
            color: "#ffffff"
            font.family: "Sitka Small Semibold"
            font.bold: true
            styleColor: "#db2020"
            font.pointSize: 12

            TextField {
                id: password

                width: column.width - 33
                anchors {
                    left: parent.right
                    verticalCenter: parent.verticalCenter
                    leftMargin: 7
                }
                font.pixelSize: 15
            }
        }

        Button {
            id: loginBtn

            width: 140
            height: 30
            transform: Translate {x: 70}

            text: "Connect"
            font.pixelSize: 20
            background: Rectangle {
                gradient: Gradient {
                    GradientStop { position: 0; color: "#ffffff" }
                    GradientStop { position: 1; color: "#c1bbf9" }
                }
                radius: 4
            }
            onReleased: loginclicked()
        }
    }
}
