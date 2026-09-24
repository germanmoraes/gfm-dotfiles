import Quickshell
import QtQuick

Rectangle {
    id: weather

    width: 100
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

        onClicked: {
            weatherPopup.visible = !weatherPopup.visible
        }
    }

    Text {
        anchors.centerIn: parent

        text: "☁ 22°C"

        color: "#00e5ff"

        font.family: "sans-serif"
        font.pixelSize: 14
    }

    PopupWindow {
        id: weatherPopup

        anchor.item: weather

        anchor.edges: Edges.Bottom | Edges.Left
        anchor.gravity: Edges.Bottom | Edges.Left

        implicitWidth: 280
        implicitHeight: 180

        visible: false

        color: "transparent"

        grabFocus: true

        Rectangle {
            anchors.fill: parent

            radius: 3

            color: "#e6000000"

            border.width: 1
            border.color: "#35303d"

            Text {
                anchors.centerIn: parent

                text: "☁  Clima"

                color: "#00e5ff"

                font.family: "sans-serif"
                font.pixelSize: 18
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                anchors.verticalCenter: parent.verticalCenter

                anchors.verticalCenterOffset: 28

                text: "22°C"

                color: "#ff79c6"

                font.family: "sans-serif"
                font.pixelSize: 28
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                anchors.verticalCenter: parent.verticalCenter

                anchors.verticalCenterOffset: 58

                text: "Previsão meteorológica"

                color: "#b0a8b8"

                font.family: "sans-serif"
                font.pixelSize: 13
            }
        }
    }
}
