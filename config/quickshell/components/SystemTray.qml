import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick

Item {
    id: systemTray

    implicitWidth:
        trayRow.implicitWidth

    implicitHeight:
        32

    readonly property int capsuleHeight: 32
    readonly property int capsuleRadius: 16
    readonly property int horizontalPadding: 6
    readonly property int itemSpacing: 4
    readonly property int itemWidth: 28
    readonly property int iconSize: 20

    Rectangle {
        id: capsule

        anchors.fill:
            parent

        radius:
            systemTray.capsuleRadius

        color:
            "#000000"

        Row {
            id: trayRow

            anchors {
                left:
                    parent.left

                right:
                    parent.right

                verticalCenter:
                    parent.verticalCenter
            }

            anchors.leftMargin:
                systemTray.horizontalPadding

            anchors.rightMargin:
                systemTray.horizontalPadding

            spacing:
                systemTray.itemSpacing

            Repeater {

                model:
                    SystemTray.items

                delegate:
                    Item {

                        required property var modelData

                        width:
                            systemTray.itemWidth

                        height:
                            systemTray.capsuleHeight

                        IconImage {

                            id: trayIcon

                            anchors.centerIn:
                                parent

                            width:
                                systemTray.iconSize

                            height:
                                systemTray.iconSize

                            source:
                                modelData.icon
                        }

                        MouseArea {

                            id: trayMouseArea

                            anchors.fill:
                                parent

                            acceptedButtons:
                                Qt.LeftButton |
                                Qt.MiddleButton |
                                Qt.RightButton

                            onClicked: {

                                // ========================================
                                // BOTÃO ESQUERDO
                                // ========================================

                                if (
                                    mouse.button ===
                                    Qt.LeftButton
                                ) {

                                    if (
                                        modelData.onlyMenu &&
                                        modelData.hasMenu
                                    ) {

                                        trayMenu.menu =
                                            modelData.menu

                                        trayMenu.open()

                                    } else {

                                        modelData.activate()
                                    }

                                    return
                                }

                                // ========================================
                                // BOTÃO DIREITO
                                // ========================================

                                if (
                                    mouse.button ===
                                    Qt.RightButton
                                ) {

                                    if (
                                        modelData.hasMenu
                                    ) {

                                        trayMenu.menu =
                                            modelData.menu

                                        trayMenu.open()
                                    }

                                    return
                                }

                                // ========================================
                                // BOTÃO DO MEIO
                                // ========================================

                                if (
                                    mouse.button ===
                                    Qt.MiddleButton
                                ) {

                                    modelData.secondaryActivate()
                                }
                            }

                            onWheel: function(wheel) {

                                modelData.scroll(
                                    wheel.angleDelta.y,
                                    wheel.angleDelta.x !== 0
                                )
                            }
                        }

                        // ====================================================
                        // MENU DE CONTEXTO
                        // ====================================================

                        QsMenuAnchor {

                            id: trayMenu

                            menu:
                                null

                            anchor.window:
                                systemTrayWindow

                            anchor.item:
                                parent

                            anchor.edges:
                                Edges.Bottom

                            anchor.gravity:
                                Edges.Top | Edges.Right
                        }
                    }
            }
        }
    }

    // ============================================================
    // JANELA PAI
    //
    // Será preenchida pelo PanelWindow que contém o SystemTray.
    // ============================================================

    property var systemTrayWindow:
        null
}
