import Quickshell
import QtQuick

Rectangle {
    id: power

    width: 36
    height: 32

    radius: 6

    color: "transparent"

    Text {
        anchors.centerIn: parent

        text: ""

        color: "#ff5577"

        font.family: "Font Awesome 7 Free Solid"
        font.pixelSize: 16
        font.weight: Font.Normal
    }

    MouseArea {
        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor

        onClicked: {
            powerMenu.visible = !powerMenu.visible
        }
    }

    PopupWindow {
        id: powerMenu

        anchor.item: power

        anchor.edges: Edges.Bottom | Edges.Right
        anchor.gravity: Edges.Bottom | Edges.Right

        implicitWidth: 220
        implicitHeight: 190

        visible: false

        color: "transparent"

        grabFocus: true

        Rectangle {
            anchors.fill: parent

            radius: 3

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#33ccff"
                }

                GradientStop {
                    position: 1.0
                    color: "#00ff99"
                }
            }

            Rectangle {
                anchors.fill: parent
                anchors.margins: 2

                radius: 1

                color: "#e6000000"

                Column {
                    anchors.fill: parent
                    anchors.margins: 12

                    spacing: 8

                    Text {
                        width: parent.width
                        height: 28

                        text: "Energia"

                        color: "#ff79c6"

                        font.pixelSize: 16
                        font.weight: Font.Normal

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Rectangle {
                        width: parent.width
                        height: 32

                        radius: 6

                        color: "#b3000000"

                        Text {
                            anchors.centerIn: parent

                            text: "  Desligar"

                            color: "#ff5577"

                            font.family: "Font Awesome 7 Free Solid"
                            font.pixelSize: 13
                            font.weight: Font.Normal
                        }

                        MouseArea {
                            anchors.fill: parent

                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                Quickshell.execDetached([
                                    "systemctl",
                                    "poweroff"
                                ])
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 32

                        radius: 6

                        color: "#b3000000"

                        Text {
                            anchors.centerIn: parent

                            text: "  Reiniciar"

                            color: "#ffb86c"

                            font.family: "Font Awesome 7 Free Solid"
                            font.pixelSize: 13
                            font.weight: Font.Normal
                        }

                        MouseArea {
                            anchors.fill: parent

                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                Quickshell.execDetached([
                                    "systemctl",
                                    "reboot"
                                ])
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 32

                        radius: 6

                        color: "#b3000000"

                        Text {
                            anchors.centerIn: parent

                            text: "  Recarregar DE"

                            color: "#00e5ff"

                            font.family: "Font Awesome 7 Free Solid"
                            font.pixelSize: 13
                            font.weight: Font.Normal
                        }

                        MouseArea {
                            anchors.fill: parent

                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                Quickshell.execDetached([
                                    "hyprctl",
                                    "reload"
                                ])

                                powerMenu.visible = false
                            }
                        }
                    }
                }
            }
        }
    }
}
