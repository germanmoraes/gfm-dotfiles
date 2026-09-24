import Quickshell
import QtQuick
import QtQuick.Controls
import Qt.labs.folderlistmodel

Item {
    id: picker

    width: 1000
    height: 700

    // ============================================================
    // CONFIGURAÇÕES
    // ============================================================

    property string wallpaperDirectory:
        Quickshell.env("HOME") + "/Imagens/Wallpapers"

    property string wallpaperCommand:
        "pkill mpvpaper 2>/dev/null; " +
        "sleep 0.2; " +
        "exec mpvpaper -l background Virtual-1 \"$1\""

    // ============================================================
    // MODELO DOS ARQUIVOS
    // ============================================================

    FolderListModel {
        id: wallpaperModel

        folder: "file://" + picker.wallpaperDirectory

        showDirs: false
        showFiles: true

        nameFilters: [
            "*.jpg",
            "*.jpeg",
            "*.png",
            "*.webp",
            "*.gif",
            "*.bmp",
            "*.mp4",
            "*.mkv",
            "*.webm",
            "*.mov",
            "*.avi"
        ]

        sortField: FolderListModel.Name
        sortReversed: false
    }

    // ============================================================
    // FUNÇÃO PARA APLICAR WALLPAPER
    // ============================================================

    function setWallpaper(path) {
        Quickshell.execDetached([
            "sh",
            "-c",
            picker.wallpaperCommand,
            "wallpaper",
            path
        ])
    }

    // ============================================================
    // FUNÇÃO PARA FECHAR
    // ============================================================

    function closePicker() {
        Quickshell.execDetached([
            "qs",
            "ipc",
            "call",
            "wallpaperPicker",
            "close"
        ])
    }

    // ============================================================
    // FUNDO
    // ============================================================

    Rectangle {
        anchors.fill: parent

        color: "#202020"
        radius: 14

        border.width: 1
        border.color: "#505050"
    }

    // ============================================================
    // CABEÇALHO
    // ============================================================

    Rectangle {
        id: header

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        height: 58

        color: "#292929"

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            height: 1
            color: "#505050"
        }

        Text {
            anchors {
                left: parent.left
                leftMargin: 22
                verticalCenter: parent.verticalCenter
            }

            text: "WALLPAPERS"

            color: "#eeeeee"

            font.pixelSize: 18
            font.bold: true
        }

        Text {
            anchors {
                left: parent.left
                leftMargin: 22
                bottom: parent.bottom
                bottomMargin: 7
            }

            text: wallpaperModel.count + " arquivos"

            color: "#888888"

            font.pixelSize: 11
        }

        Rectangle {
            id: closeButton

            anchors {
                right: parent.right
                rightMargin: 14
                verticalCenter: parent.verticalCenter
            }

            width: 32
            height: 32

            radius: 7

            color: closeMouse.containsMouse
                   ? "#454545"
                   : "#353535"

            border.width: 1
            border.color: "#555555"

            Text {
                anchors.centerIn: parent

                text: "×"

                color: "#dddddd"

                font.pixelSize: 22
                font.bold: true
            }

            MouseArea {
                id: closeMouse

                anchors.fill: parent

                hoverEnabled: true

                onClicked: picker.closePicker()
            }
        }
    }

    // ============================================================
    // ÁREA DOS WALLPAPERS
    // ============================================================

    ScrollView {
        id: scrollView

        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom

            margins: 14
        }

        clip: true

        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        GridView {
            id: wallpaperGrid

            width: scrollView.availableWidth

            cellWidth: 230
            cellHeight: 150

            model: wallpaperModel

            clip: true

            boundsBehavior: Flickable.StopAtBounds

            delegate: Item {
                id: wallpaperItem

                width: wallpaperGrid.cellWidth
                height: wallpaperGrid.cellHeight

                property string filePath:
                    fileUrl.toString().replace("file://", "")

                property bool isVideo:
                    /\.(mp4|mkv|webm|mov|avi)$/i.test(fileName)

                Rectangle {
                    id: card

                    anchors {
                        fill: parent
                        margins: 7
                    }

                    radius: 10

                    color: "#292929"

                    border.width: 1

                    border.color:
                        mouseArea.containsMouse
                        ? "#777777"
                        : "#414141"

                    clip: true

                    Image {
                        id: preview

                        anchors.fill: parent

                        visible: !wallpaperItem.isVideo

                        source: wallpaperItem.isVideo
                                ? ""
                                : wallpaperItem.filePath

                        fillMode: Image.PreserveAspectCrop

                        asynchronous: true

                        cache: true

                        mipmap: true
                    }

                    // ====================================================
                    // REPRESENTAÇÃO DE VÍDEO
                    // ====================================================

                    Rectangle {
                        anchors.fill: parent

                        visible: wallpaperItem.isVideo

                        color: "#171717"

                        Text {
                            anchors.centerIn: parent

                            text: "▶"

                            color: "#eeeeee"

                            font.pixelSize: 38
                        }

                        Text {
                            anchors {
                                horizontalCenter: parent.horizontalCenter
                                top: parent.verticalCenter
                                topMargin: 28
                            }

                            text: "VIDEO"

                            color: "#aaaaaa"

                            font.pixelSize: 11
                            font.bold: true
                        }
                    }

                    // ====================================================
                    // GRADIENTE INFERIOR
                    // ====================================================

                    Rectangle {
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }

                        height: 42

                        gradient: Gradient {
                            GradientStop {
                                position: 0.0
                                color: "#00000000"
                            }

                            GradientStop {
                                position: 1.0
                                color: "#cc000000"
                            }
                        }
                    }

                    Text {
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom

                            leftMargin: 10
                            rightMargin: 10
                            bottomMargin: 9
                        }

                        text: fileName

                        color: "#eeeeee"

                        font.pixelSize: 11

                        elide: Text.ElideMiddle
                    }

                    // ====================================================
                    // INDICADOR DE VÍDEO
                    // ====================================================

                    Rectangle {
                        anchors {
                            top: parent.top
                            right: parent.right

                            topMargin: 8
                            rightMargin: 8
                        }

                        width: 28
                        height: 22

                        radius: 6

                        visible: wallpaperItem.isVideo

                        color: "#aa000000"

                        Text {
                            anchors.centerIn: parent

                            text: "▶"

                            color: "#ffffff"

                            font.pixelSize: 11
                        }
                    }

                    // ====================================================
                    // ÁREA DE CLIQUE
                    // ====================================================

                    MouseArea {
                        id: mouseArea

                        anchors.fill: parent

                        hoverEnabled: true

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            picker.setWallpaper(wallpaperItem.filePath)
                            picker.closePicker()
                        }
                    }

                    // ====================================================
                    // EFEITO DE HOVER
                    // ====================================================

                    Rectangle {
                        anchors.fill: parent

                        radius: 10

                        color: "#ffffff"

                        opacity: mouseArea.containsMouse ? 0.07 : 0

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 100
                            }
                        }

                        z: 10
                    }
                }
            }
        }
    }

    // ============================================================
    // ESC FECHA
    // ============================================================

    Shortcut {
        sequence: "Escape"

        onActivated: picker.closePicker()
    }
}
