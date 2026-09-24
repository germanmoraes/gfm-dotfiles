import Quickshell
import QtQuick

Rectangle {
    id: appLauncher

    // ============================================================
    // ÍCONE
    // ============================================================

    readonly property string launcherIcon:
        String.fromCodePoint(0x08c7)//"󰣇"

    readonly property string launcherIconFont:
        "Symbols Nerd Font"

    readonly property int launcherIconSize:
        20

    // ============================================================
    // CORES DO ÍCONE
    // ============================================================

    readonly property color launcherIconColor:
        "#00e5ff"

    readonly property color launcherIconHoverColor:
        "#00ffff"

    // ============================================================
    // CORES DA CÁPSULA
    // ============================================================

    readonly property color launcherNormalColor:
        "#000000"

    readonly property color launcherHoverColor:
        "#303030"

    readonly property color launcherBorderColor:
        "transparent"

    // ============================================================
    // GEOMETRIA
    // ============================================================

    readonly property int launcherWidth:
        50

    readonly property int launcherHeight:
        32

    readonly property int launcherRadius:
        16

    // ============================================================
    // ANIMAÇÃO
    // ============================================================

    readonly property int launcherColorAnimationDuration:
        150

    // ============================================================
    // CÁPSULA
    // ============================================================

    width:
        launcherWidth

    height:
        launcherHeight

    radius:
        launcherRadius

    color:
        mouseArea.containsMouse
        ? launcherHoverColor
        : launcherNormalColor

    border.color:
        launcherBorderColor

    // ============================================================
    // ÍCONE
    // ============================================================

    Text {
        anchors.centerIn:
            parent

        text:
            appLauncher.launcherIcon

        color:
            mouseArea.containsMouse
            ? appLauncher.launcherIconHoverColor
            : appLauncher.launcherIconColor

        font.family:
            appLauncher.launcherIconFont

        font.pixelSize:
            appLauncher.launcherIconSize

        horizontalAlignment:
            Text.AlignHCenter

        verticalAlignment:
            Text.AlignVCenter

        renderType:
            Text.NativeRendering

        Behavior on color {
            ColorAnimation {
                duration:
                    appLauncher.launcherColorAnimationDuration
            }
        }
    }

    // ============================================================
    // ANIMAÇÃO DA CÁPSULA
    // ============================================================

    Behavior on color {
        ColorAnimation {
            duration:
                appLauncher.launcherColorAnimationDuration
        }
    }

    // ============================================================
    // INTERAÇÃO
    // ============================================================

    MouseArea {
        id: mouseArea

        anchors.fill:
            parent

        hoverEnabled:
            true

        onClicked: {
            Quickshell.execDetached([
                "hyprlauncher"
            ])
        }
    }
}
