import Quickshell
import QtQuick
import QtQuick.Window

Window {
    visible: true
    width: 900
    height: 500
    color: "#15151b"
    title: "Material Symbols Rounded — Teste"

    Column {
        anchors.centerIn: parent
        spacing: 24

        Text {
            text: "Material Symbols Rounded"
            color: "white"
            font.family: "sans-serif"
            font.pixelSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Row {
            spacing: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: String.fromCodePoint(0xEBE1)
                color: "#00e5ff"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xEBD6)
                color: "#00e5ff"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xEBE4)
                color: "#00e5ff"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xE648)
                color: "#666666"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }
        }

        Row {
            spacing: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: String.fromCodePoint(0xE1A7)
                color: "#00aaff"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xE1A8)
                color: "#00aaff"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xE050)
                color: "#ff79c6"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xE04D)
                color: "#ff79c6"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xE04C)
                color: "#ff79c6"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xE04F)
                color: "#ff79c6"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }
        }

        Row {
            spacing: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: String.fromCodePoint(0xEBDC)
                color: "#50fa7b"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xEBD9)
                color: "#50fa7b"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xEBDD)
                color: "#50fa7b"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xEBE2)
                color: "#50fa7b"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xE1A4)
                color: "#50fa7b"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }
        }

        Row {
            spacing: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: String.fromCodePoint(0xE1AD)
                color: "#f1fa8c"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xE1AE)
                color: "#f1fa8c"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xE1AC)
                color: "#f1fa8c"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }

            Text {
                text: String.fromCodePoint(0xE8AC)
                color: "white"
                font.family: "Material Symbols Rounded"
                font.pixelSize: 48
            }
        }
    }
}
