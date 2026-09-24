import QtQuick

Rectangle {
    id: clock

    width: 210
    height: 32

    radius: 16

    color: mouseArea.containsMouse
        ? "#303030"
        : "#000000"

    Behavior on color {
        ColorAnimation {
            duration: 150
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        hoverEnabled: true
    }

    Text {
        id: clockText

        anchors.centerIn: parent

        text: Qt.formatDateTime(
            new Date(),
            "ddd d 'de' MMM HH:mm:ss"
        )

        color: "#ff79c6"

        font.pixelSize: 14
    }

    Timer {
        interval: 1000

        running: true

        repeat: true

        onTriggered: {
            clockText.text = Qt.formatDateTime(
                new Date(),
                "ddd d 'de' MMM HH:mm:ss"
            )
        }
    }
}
