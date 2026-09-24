import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick

Item {
    id: activeApps

    // ============================================================
    // CONFIGURAÇÃO
    // ============================================================

    readonly property int itemSize: 32
    readonly property int itemRadius: 16
    readonly property int itemSpacing: 4
    readonly property int iconSize: 18

    readonly property int indicatorWidth: 14
    readonly property int indicatorHeight: 2
    readonly property int indicatorBottomMargin: 4

    // ============================================================
    // CORES
    // ============================================================

    readonly property color normalColor: "#000000"
    readonly property color hoverColor: "#303030"
    readonly property color indicatorColor: "#707070"

    readonly property color popupColor: "#18181c"
    readonly property color popupBorderColor: "#29252f"
    readonly property color popupHoverColor: "#303030"

    readonly property color popupTextColor: "#e6e6e6"
    readonly property color popupSecondaryTextColor: "#8b8b92"

    // ============================================================
    // POPUP
    // ============================================================

    readonly property int popupWidth: 300
    readonly property int popupItemHeight: 38
    readonly property int popupRadius: 10
    readonly property int popupPadding: 6

    property string selectedAppId: ""
    property Item selectedItem: null

    // ============================================================
    // LISTA DE APP IDs ATUAIS
    //
    // SOMENTE aplicações com appId válido entram na lista.
    //
    // Não existe fallback para address.
    // ============================================================

    function applicationIds() {

        var result = []

        var toplevels =
            Hyprland.toplevels.values

        for (
            var i = 0;
            i < toplevels.length;
            ++i
        ) {

            var toplevel =
                toplevels[i]

            if (!toplevel)
                continue

            if (!toplevel.wayland)
                continue

            var appId =
                toplevel.wayland.appId || ""

            if (appId === "")
                continue

            if (
                result.indexOf(appId) === -1
            ) {
                result.push(appId)
            }
        }

        return result
    }

    // ============================================================
    // JANELAS ATUAIS DE UMA APLICAÇÃO
    // ============================================================

    function windowsForApp(appId) {

        var result = []

        if (appId === "")
            return result

        var toplevels =
            Hyprland.toplevels.values

        for (
            var i = 0;
            i < toplevels.length;
            ++i
        ) {

            var toplevel =
                toplevels[i]

            if (!toplevel)
                continue

            if (!toplevel.wayland)
                continue

            var currentAppId =
                toplevel.wayland.appId || ""

            if (
                currentAppId === appId
            ) {

                result.push(toplevel)
            }
        }

        return result
    }

    // ============================================================
    // MODELO VISUAL
    //
    // É uma expressão direta.
    //
    // Se o conjunto de aplicações mudar, o Repeater recria
    // os delegates a partir da lista ATUAL.
    //
    // Não existe ScriptModel mantendo delegates antigos.
    // ============================================================

    implicitWidth:
        applicationRow.implicitWidth

    implicitHeight:
        itemSize

    // ============================================================
    // BARRA
    // ============================================================

    Row {
        id: applicationRow

        spacing:
            activeApps.itemSpacing

        Repeater {

            model:
                activeApps.applicationIds()

            delegate:
                Rectangle {

                    required property string modelData

                    width:
                        activeApps.itemSize

                    height:
                        activeApps.itemSize

                    radius:
                        activeApps.itemRadius

                    color:
                        mouseArea.containsMouse
                        ? activeApps.hoverColor
                        : activeApps.normalColor

                    // ====================================================
                    // APP ID
                    // ====================================================

                    property string appId:
                        modelData

                    // ====================================================
                    // JANELAS ATUAIS
                    // ====================================================

                    property var windows:
                        activeApps.windowsForApp(
                            appId
                        )

                    // ====================================================
                    // JANELA ATIVA
                    // ====================================================

                    property var activeWindow: {

                        var currentWindows =
                            windows

                        for (
                            var i = 0;
                            i < currentWindows.length;
                            ++i
                        ) {

                            if (
                                currentWindows[i] &&
                                currentWindows[i].activated
                            ) {

                                return currentWindows[i]
                            }
                        }

                        return null
                    }

                    // ====================================================
                    // ÍCONE
                    // ====================================================

                    IconImage {

                        id: appIcon

                        anchors.centerIn:
                            parent

                        width:
                            activeApps.iconSize

                        height:
                            activeApps.iconSize

                        source: {

                            if (
                                appId ===
                                "dev.zed.Zed"
                            ) {

                                return Quickshell.iconPath(
                                    "zed",
                                    true
                                )
                            }

                            return Quickshell.iconPath(
                                appId,
                                true
                            )
                        }
                    }

                    // ====================================================
                    // INDICADOR DE ATIVO
                    // ====================================================

                    Rectangle {

                        anchors.horizontalCenter:
                            parent.horizontalCenter

                        anchors.bottom:
                            parent.bottom

                        anchors.bottomMargin:
                            activeApps.indicatorBottomMargin

                        width:
                            activeWindow
                            ? activeApps.indicatorWidth
                            : 0

                        height:
                            activeApps.indicatorHeight

                        radius:
                            activeApps.indicatorHeight / 2

                        color:
                            activeApps.indicatorColor

                        Behavior on width {

                            NumberAnimation {
                                duration: 150
                            }
                        }
                    }

                    // ====================================================
                    // CONTADOR
                    // ====================================================

                    Rectangle {

                        visible:
                            windows.length > 1

                        anchors {
                            right:
                                parent.right

                            top:
                                parent.top

                            rightMargin:
                                2

                            topMargin:
                                2
                        }

                        width: 12
                        height: 12
                        radius: 6

                        color:
                            "#707070"

                        Text {

                            anchors.centerIn:
                                parent

                            text:
                                windows.length

                            color:
                                "#ffffff"

                            font.family:
                                "JetBrainsMono Nerd Font"

                            font.pixelSize:
                                8

                            horizontalAlignment:
                                Text.AlignHCenter

                            verticalAlignment:
                                Text.AlignVCenter
                        }
                    }

                    // ====================================================
                    // CLIQUE
                    // ====================================================

                    MouseArea {

                        id: mouseArea

                        anchors.fill:
                            parent

                        hoverEnabled:
                            true

                        onClicked: {

                            var currentWindows =
                                activeApps.windowsForApp(
                                    appId
                                )

                            // --------------------------------------------
                            // UMA JANELA
                            // --------------------------------------------

                            if (
                                currentWindows.length === 1
                            ) {

                                if (
                                    currentWindows[0].wayland
                                ) {

                                    currentWindows[0]
                                        .wayland
                                        .activate()
                                }

                                return
                            }

                            // --------------------------------------------
                            // MAIS DE UMA JANELA
                            // --------------------------------------------

                            if (
                                currentWindows.length > 1
                            ) {

                                activeApps.selectedAppId =
                                    appId

                                activeApps.selectedItem =
                                    parent

                                windowSelector.visible =
                                    true
                            }
                        }
                    }
                }
        }
    }

    // ============================================================
    // POPUP DE JANELAS
    // ============================================================

    PopupWindow {

        id: windowSelector

        visible:
            false

        implicitWidth:
            activeApps.popupWidth

        implicitHeight: {

            var currentWindows =
                activeApps.windowsForApp(
                    activeApps.selectedAppId
                )

            return activeApps.popupPadding * 2 +
                currentWindows.length *
                activeApps.popupItemHeight
        }

        color:
            "transparent"

        anchor.item:
            activeApps.selectedItem

        anchor.edges:
            Edges.Bottom | Edges.Left

        anchor.gravity:
            Edges.Bottom | Edges.Right

        grabFocus:
            true

        Rectangle {

            anchors.fill:
                parent

            radius:
                activeApps.popupRadius

            color:
                activeApps.popupColor

            border.width:
                1

            border.color:
                activeApps.popupBorderColor

            Column {

                anchors.fill:
                    parent

                anchors.margins:
                    activeApps.popupPadding

                spacing:
                    2

                Repeater {

                    model:
                        activeApps.windowsForApp(
                            activeApps.selectedAppId
                        )

                    delegate:
                        Rectangle {

                            required property var modelData

                            width:
                                parent.width

                            height:
                                activeApps.popupItemHeight

                            radius:
                                7

                            color:
                                windowMouseArea.containsMouse
                                ? activeApps.popupHoverColor
                                : "transparent"

                            // ============================================
                            // ÍCONE
                            // ============================================

                            IconImage {

                                id: windowIcon

                                anchors {
                                    left:
                                        parent.left

                                    leftMargin:
                                        8

                                    verticalCenter:
                                        parent.verticalCenter
                                }

                                width: 20
                                height: 20

                                source: {

                                    if (
                                        !modelData ||
                                        !modelData.wayland
                                    ) {
                                        return ""
                                    }

                                    var appId =
                                        modelData.wayland.appId ||
                                        ""

                                    if (
                                        appId ===
                                        "dev.zed.Zed"
                                    ) {

                                        return Quickshell.iconPath(
                                            "zed",
                                            true
                                        )
                                    }

                                    if (
                                        appId !== ""
                                    ) {

                                        return Quickshell.iconPath(
                                            appId,
                                            true
                                        )
                                    }

                                    return ""
                                }
                            }

                            // ============================================
                            // TÍTULO
                            // ============================================

                            Text {

                                anchors {
                                    left:
                                        windowIcon.right

                                    leftMargin:
                                        10

                                    right:
                                        parent.right

                                    rightMargin:
                                        8

                                    verticalCenter:
                                        parent.verticalCenter
                                }

                                text:
                                    modelData &&
                                    modelData.title
                                    ? modelData.title
                                    : "Janela"

                                color:
                                    modelData &&
                                    modelData.activated
                                    ? activeApps.popupTextColor
                                    : activeApps.popupSecondaryTextColor

                                font.family:
                                    "JetBrainsMono Nerd Font"

                                font.pixelSize:
                                    11

                                elide:
                                    Text.ElideRight
                            }

                            // ============================================
                            // CLIQUE
                            // ============================================

                            MouseArea {

                                id: windowMouseArea

                                anchors.fill:
                                    parent

                                hoverEnabled:
                                    true

                                onClicked: {

                                    if (
                                        modelData &&
                                        modelData.wayland
                                    ) {

                                        modelData
                                            .wayland
                                            .activate()
                                    }

                                    windowSelector.visible =
                                        false
                                }
                            }
                        }
                }
            }
        }
    }

    // ============================================================
    // FECHAMENTO DO POPUP QUANDO A APLICAÇÃO DESAPARECE
    // ============================================================

    Connections {

        target:
            Hyprland.toplevels

        function onObjectRemovedPost() {

            if (
                activeApps.selectedAppId === ""
            ) {
                return
            }

            var currentWindows =
                activeApps.windowsForApp(
                    activeApps.selectedAppId
                )

            if (
                currentWindows.length === 0
            ) {

                windowSelector.visible =
                    false

                activeApps.selectedAppId =
                    ""
            }
        }
    }
}
