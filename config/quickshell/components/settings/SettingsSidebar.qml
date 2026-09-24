import QtQuick

Rectangle {
    id: sidebar

    width: 230

    color: "#0b0b0d"

    property int selectedIndex: 0

    signal categorySelected(int index, string title)

    readonly property var categories: [
        {
            title: "Sistema",
            icon: ""
        },
        {
            title: "Rede",
            icon: ""
        },
        {
            title: "Som",
            icon: ""
        },
        {
            title: "Tela",
            icon: ""
        },
        {
            title: "Aparência",
            icon: ""
        },
        {
            title: "Energia",
            icon: ""
        },
        {
            title: "Dispositivos",
            icon: ""
        },
        {
            title: "Hyprland / Desktop",
            icon: ""
        }
    ]

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        anchors.leftMargin: 14
        anchors.rightMargin: 14
        anchors.topMargin: 22

        spacing: 4

        Text {
            x: 12

            text: "CONFIGURAÇÕES"

            color: "#55505c"

            font.family: "sans-serif"
            font.pixelSize: 9
            font.bold: true

            bottomPadding: 10
        }

        Repeater {
            model: sidebar.categories

            delegate: Rectangle {
                width: sidebar.width - 28
                height: 40

                radius: 4

                color:
                    sidebar.selectedIndex === index
                    ? "#1d1a20"
                    : mouseArea.containsMouse
                        ? "#141216"
                        : "transparent"

                Behavior on color {
                    ColorAnimation {
                        duration: 120
                    }
                }

                Rectangle {
                    width: 3
                    height: 22

                    radius: 1.5

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    color: "#00e5ff"

                    visible:
                        sidebar.selectedIndex === index
                }

                Text {
                    x: 16

                    anchors.verticalCenter:
                        parent.verticalCenter

                    text: modelData.icon

                    color:
                        sidebar.selectedIndex === index
                        ? "#00e5ff"
                        : "#77717d"

                    font.family:
                        "Font Awesome 7 Free Solid"

                    font.pixelSize: 14
                }

                Text {
                    x: 46

                    anchors.verticalCenter:
                        parent.verticalCenter

                    text: modelData.title

                    color:
                        sidebar.selectedIndex === index
                        ? "#e6e1f0"
                        : "#8a8490"

                    font.family: "sans-serif"
                    font.pixelSize: 11
                    font.bold:
                        sidebar.selectedIndex === index
                }

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent

                    hoverEnabled: true

                    onClicked: {
                        sidebar.selectedIndex = index

                        sidebar.categorySelected(
                            index,
                            modelData.title
                        )
                    }
                }
            }
        }
    }
}
