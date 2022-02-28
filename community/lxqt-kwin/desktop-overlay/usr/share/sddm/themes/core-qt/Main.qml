import QtQuick 2.0
import SddmComponents 2.0
import "SimpleControls" as Simple

Rectangle {
    
    width: 640
    height: 480
    
    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    TextConstants { id: textConstants }
    
    Connections {
        target: sddm
        
        onLoginSucceeded: {}
        
        onLoginFailed: {
            pw_entry.text = ""
            pw_entry.focus = true
            
            errorMsgContainer.visible = true
        }
    }
    
    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        
        Simple.SimpleUserComboBox {
            id: user_entry
            width: 250
            color: Qt.rgba(0, 0, 0, 0.2)
            dropDownColor: Qt.rgba(0, 0, 0, 0.2)
            borderColor: "transparent"
            textColor: "white"
            arrowIcon: "images/arrow_down.svg"
            arrowColor: "transparent"
            model: userModel
            index: userModel.lastIndex
            font.pointSize: 11
            KeyNavigation.backtab: session
            KeyNavigation.tab: pw_entry
        }

        PasswordBox {
            id: pw_entry
            width: 250
            color: Qt.rgba(0, 0, 0, 0.2)
            borderColor: "transparent"
            focusColor: Qt.rgba(0, 0, 0, 0.3)
            hoverColor: Qt.rgba(0, 0, 0, 0.3)
            textColor: "white"
            font.pointSize: 11
            focus: true
            KeyNavigation.backtab: user_entry
            KeyNavigation.tab: loginButton

            Keys.onPressed: {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    sddm.login(user_entry.currentText, pw_entry.text, session.index)
                    event.accepted = true
                }
            }
        }

        Button {
            id: loginButton
            text: textConstants.login
            width: 250
            color: Qt.rgba(0, 0, 0, 0.2)
            activeColor: Qt.rgba(0, 0, 0, 0.3)
            pressedColor: Qt.rgba(0, 0, 0, 0.3)
            font.pointSize: 11
            font.bold: false
            onClicked: sddm.login(user_entry.currentText, pw_entry.text, session.index)
            KeyNavigation.backtab: pw_entry
            KeyNavigation.tab: suspend
        }
        
        Rectangle {
            id: errorMsgContainer
            width: 250
            height: loginButton.height
            color: "#F44336"
            clip: true
            visible: false
            
            Text {
                anchors.centerIn: parent
                text: textConstants.loginFailed
                width: 240
                color: "white"
                font.pointSize: 11
                font.bold: true
                font.capitalization: Font.AllUppercase
                elide: Qt.locale().textDirection == Qt.RightToLeft ? Text.ElideLeft : Text.ElideRight
                horizontalAlignment: Qt.AlignHCenter
            }
        }

    }

    Row {
        anchors {
            bottom: parent.bottom
            bottomMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
        
        Button {
            id: suspend
            text: textConstants.suspend
            color: Qt.rgba(0, 0, 0, 0.2)
            pressedColor: Qt.rgba(0, 0, 0, 0.3)
            activeColor: Qt.rgba(0, 0, 0, 0.3)
            font.pointSize: 11
            font.bold: false
            onClicked: sddm.suspend()
            KeyNavigation.backtab: loginButton
            KeyNavigation.tab: restart
        }
        
        Button {
            id: restart
            text: textConstants.reboot
            color: Qt.rgba(0, 0, 0, 0.2)
            pressedColor: Qt.rgba(0, 0, 0, 0.3)
            activeColor: Qt.rgba(0, 0, 0, 0.3)
            font.pointSize: 11
            font.bold: false
            onClicked: sddm.reboot()
            KeyNavigation.backtab: suspend; KeyNavigation.tab: shutdown
        }
        
        Button {
            id: shutdown
            text: textConstants.shutdown
            color: Qt.rgba(0, 0, 0, 0.2)
            pressedColor: Qt.rgba(0, 0, 0, 0.3)
            activeColor: Qt.rgba(0, 0, 0, 0.3)
            font.pointSize: 11
            font.bold: false
            onClicked: sddm.powerOff()
            KeyNavigation.backtab: restart; KeyNavigation.tab: session
        }
    }

    Simple.SimpleComboBox {
        id: session
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 200
        color: Qt.rgba(0, 0, 0, 0.2)
        dropDownColor: Qt.rgba(0, 0, 0, 0.2)
        borderColor: "transparent"
        textColor: "White"
        font.pointSize: 11
        arrowIcon: "images/arrow_down.svg"
        arrowColor: "transparent"
        model: sessionModel
        index: sessionModel.lastIndex
        KeyNavigation.backtab: shutdown
        KeyNavigation.tab: user_entry
    }

    Rectangle {
        id: timeContainer
        color: Qt.rgba(0, 0, 0, 0.2)
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.rightMargin: 10
        width: timelb.width + 7
        height: session.height

        Text {
            id: timelb
            anchors.centerIn: parent
            text: Qt.formatDateTime(new Date(), "HH:mm")
            color: "white"
            font.pointSize: 11
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Timer {
        id: timetr
        interval: 500
        repeat: true
        onTriggered: {
            timelb.text = Qt.formatDateTime(new Date(), "HH:mm")
        }
    }
    
    Component.onCompleted: {
        /*if (user_entry.text === "")
            user_entry.focus = true
        else
            pw_entry.focus = true*/
        timetr.start()
        pw_entry.focus = true
    }
}
