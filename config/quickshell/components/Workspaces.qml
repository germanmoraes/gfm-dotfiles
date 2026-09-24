import Quickshell
import Quickshell.Hyprland
import QtQuick

Rectangle {
    id: workspaces

    width: 130
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

    Row {
        anchors.centerIn: parent

        spacing: 6

        Repeater {
            model: 4

            Rectangle {
                required property int index

                width: {
                    let ws = Hyprland.workspaces.values.find(
                        workspace => workspace.id === index + 1
                    )

                    return ws && ws.active ? 28 : 16
                }

                height: 12

                radius: 6

                color: {
                    let ws = Hyprland.workspaces.values.find(
                        workspace => workspace.id === index + 1
                    )

                    return ws && ws.active
                        ? "#707070"
                        : "#3a3a3a"
                }

                border.width: 0

                Behavior on width {
                    NumberAnimation {
                        duration: 150
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 150
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        let workspaceId = index + 1

                        let ws = Hyprland.workspaces.values.find(
                            workspace => workspace.id === workspaceId
                        )

                        if (ws) {
                            ws.activate()
                        } else {
                            Quickshell.execDetached([
                                "hyprctl",
                                "dispatch",
                                "workspace",
                                workspaceId.toString()
                            ])
                        }
                    }
                }
            }
        }
    }
}
