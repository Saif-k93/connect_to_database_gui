import QtQuick
import QtQuick.Window
import QtQuick.Controls
import sql.h

Window {
    id: root

    width: 500
    height: 500

    visible: true
    title: qsTr("My Database")

    Component {
        id: loadingScreen

        Rectangle {

            anchors.fill: parent
            border.color: "black"
            border.width: 3
            color: "lightblue"

            BusyIndicator {
                id: busy

                anchors.centerIn: parent
                running: true
            }
        }
    }

    Popup {
        id: error

        property alias setText: errortext.text
        anchors.centerIn: parent
        width: 250
        height: 250
        modal: true
        focus: true
        clip: true
        closePolicy: Popup.CloseOnEscape

        Text {
            id: errortext

            elide: Text.ElideLeft
            anchors.fill: parent
            anchors.bottomMargin: 30
            font.pixelSize: 12
            wrapMode: Text.Wrap
            color: "red"
        }
        RoundButton {
            id:close

            width: 50
            anchors {
                top: errortext.bottom
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            text: "Close"
            onClicked: error.close()
        }
    }

    Sql {
        id: sql

        onDataChanged:{
            queryView.__result = data
            clear()
        }
    }

    MainView {
        id: mainView

        Timer {
            id: timer
            interval: 1000
            running: false
            repeat: false
            onTriggered: {
                if(sql.connect(mainView.plugin, mainView.database, mainView.hostname, mainView.port, mainView.username, mainView.password)) {
                    stackView.pop()
                    stackView.push(queryView)
                }
                else
                {
                    error.setText = sql.error
                    error.open()
                    stackView.pop()
                }
            }
        }
        onLoginclicked: {

            if(database === ""){
                error.setText = "Database Name Cannot Be Empty!"
                error.open()
                return
            }

            stackView.push(loadingScreen)

            timer.start()

        }
    }
    QueryView {
        id: queryView

        onBackClicked: {
            sql.close()
            stackView.pop()
        }
        onRunClicked: {
           sql.run(table_name)
        }
    }

    Rectangle {
        id:mainFrame

        anchors.fill: parent
        gradient: Gradient {
            GradientStop {position: 0.0 ;color: "#15171e"}
            GradientStop {position: 0.1 ;color: "#141922"}
            GradientStop {position: 1.0 ;color: "#13222d"}
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        onCurrentItemChanged: {
            if(currentItem == mainView) {
                root.setWidth(300)
                root.setHeight(300)
                root.setMaximumHeight(300)
                root.setMinimumHeight(300)
                root.setMaximumWidth(300)
                root.setMinimumWidth(300)
            }else
            {
                root.setWidth(500)
                root.setHeight(500)
                root.setMaximumHeight(1000)
                root.setMinimumHeight(500)
                root.setMaximumWidth(1500)
                root.setMinimumWidth(500)
            }
        }

        initialItem: mainView
    }


}
