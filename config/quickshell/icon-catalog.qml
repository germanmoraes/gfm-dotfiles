import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

PanelWindow {
    id: window

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: "transparent"

    property var categories: [

        // ========================================================
        // FONTES
        // ========================================================

        {
            name: "FONTES",
            items: [
                ["networkFont", IconRegistry.networkFont],
                ["systemFont", IconRegistry.systemFont],
                ["notificationFont", IconRegistry.notificationFont],
                ["audioFont", IconRegistry.audioFont],
                ["deviceFont", IconRegistry.deviceFont],
                ["controlFont", IconRegistry.controlFont]
            ]
        },

        // ========================================================
        // REDE — GERAL
        // ========================================================

        {
            name: "REDE — GERAL",
            items: [
                ["networkConnected", IconRegistry.networkConnected],
                ["networkDisconnected", IconRegistry.networkDisconnected],
                ["networkDisabled", IconRegistry.networkDisabled],
                ["networkNoConnection", IconRegistry.networkNoConnection]
            ]
        },

        // ========================================================
        // ETHERNET
        // ========================================================

        {
            name: "REDE — ETHERNET",
            items: [
                ["ethernetConnected", IconRegistry.ethernetConnected],
                ["ethernetDisconnected", IconRegistry.ethernetDisconnected],
                ["ethernetDisabled", IconRegistry.ethernetDisabled],
                ["ethernetCableConnected", IconRegistry.ethernetCableConnected],
                ["ethernetCableDisconnected", IconRegistry.ethernetCableDisconnected]
            ]
        },

        // ========================================================
        // WI-FI
        // ========================================================

        {
            name: "REDE — WI-FI",
            items: [
                ["wifiEnabled", IconRegistry.wifiEnabled],
                ["wifiDisabled", IconRegistry.wifiDisabled],
                ["wifi0", IconRegistry.wifi0],
                ["wifi1", IconRegistry.wifi1],
                ["wifi2", IconRegistry.wifi2],
                ["wifi3", IconRegistry.wifi3],
                ["wifi4", IconRegistry.wifi4],
                ["wifi0a", IconRegistry.wifi0a],
                ["wifi1a", IconRegistry.wifi1a],
                ["wifi2a", IconRegistry.wifi2a],
                ["wifi3a", IconRegistry.wifi3a],
                ["wifi4a", IconRegistry.wifi4a],
                ["wifiDisconnected", IconRegistry.wifiDisconnected],
                ["wifiSearching", IconRegistry.wifiSearching],
                ["wifiWarning", IconRegistry.wifiWarning]
            ]
        },

        // ========================================================
        // BATERIA
        // ========================================================

        {
            name: "BATERIA",
            items: [
                ["battery0", IconRegistry.battery0],
                ["battery1", IconRegistry.battery1],
                ["battery2", IconRegistry.battery2],
                ["battery3", IconRegistry.battery3],
                ["battery4", IconRegistry.battery4],
                ["battery5", IconRegistry.battery5],
                ["battery6", IconRegistry.battery6],
                ["battery7", IconRegistry.battery7],
                ["battery8", IconRegistry.battery8],
                ["battery9", IconRegistry.battery9],
                ["battery10", IconRegistry.battery10],
                ["battery0c", IconRegistry.battery0c],
                ["battery1c", IconRegistry.battery1c],
                ["battery2c", IconRegistry.battery2c],
                ["battery3c", IconRegistry.battery3c],
                ["battery4c", IconRegistry.battery4c],
                ["battery5c", IconRegistry.battery5c],
                ["battery6c", IconRegistry.battery6c],
                ["battery7c", IconRegistry.battery7c],
                ["battery8c", IconRegistry.battery8c],
                ["battery9c", IconRegistry.battery9c],
                ["battery10c", IconRegistry.battery10c],
                ["batteryWarning", IconRegistry.batteryWarning]
            ]
        },

        // ========================================================
        // CPU
        // ========================================================

        {
            name: "GERENCIAMENTO — CPU",
            items: [
                ["cpu", IconRegistry.cpu]
            ]
        },

        // ========================================================
        // TEMPERATURA
        // ========================================================

        {
            name: "GERENCIAMENTO — TEMPERATURA",
            items: [
                ["temperature100", IconRegistry.temperature100],
                ["temperature75", IconRegistry.temperature75],
                ["temperature50", IconRegistry.temperature50],
                ["temperature25", IconRegistry.temperature25],
                ["temperature0", IconRegistry.temperature0]
            ]
        },

        // ========================================================
        // MEMORIA
        // ========================================================

        {
            name: "GERENCIAMENTO — MEMÓRIA",
            items: [
                ["memory", IconRegistry.memory]
            ]
        },

        // ========================================================
        // GPU
        // ========================================================

        {
            name: "GERENCIAMENTO — GPU / VGA",
            items: [
                ["gpu", IconRegistry.gpu]
            ]
        },

        // ========================================================
        // TRANSFERENCIA
        // ========================================================

        {
            name: "GERENCIAMENTO — TRANSFERÊNCIA",
            items: [
                ["download", IconRegistry.download],
                ["upload", IconRegistry.upload]
            ]
        },

        // ========================================================
        // NOTIFICACOES
        // ========================================================

        {
            name: "NOTIFICAÇÕES",
            items: [
                ["notification", IconRegistry.notification],
                ["notificationNew", IconRegistry.notificationNew],
                ["notificationRead", IconRegistry.notificationRead],
                ["notificationDisabled", IconRegistry.notificationDisabled],
                ["notificationImportant", IconRegistry.notificationImportant],
                ["alert", IconRegistry.alert],
                ["information", IconRegistry.information],
                ["success", IconRegistry.success],
                ["error", IconRegistry.error],
                ["warning", IconRegistry.warning]
            ]
        },

        // ========================================================
        // CLIPBOARD
        // ========================================================

        {
            name: "ÁREA DE TRANSFERÊNCIA — CLIPBOARD",
            items: [
                ["clipboardText", IconRegistry.clipboardText],
                ["clipboardImage", IconRegistry.clipboardImage],
                ["clipboardFile", IconRegistry.clipboardFile],
                ["clipboard", IconRegistry.clipboard],
                ["clipboardClear", IconRegistry.clipboardClear]
            ]
        },

        // ========================================================
        // LIMPEZA
        // ========================================================

        {
            name: "LIMPEZA / MANUTENÇÃO",
            items: [
                ["systemClean", IconRegistry.systemClean],
                ["cacheClean", IconRegistry.cacheClean],
                ["trash", IconRegistry.trash],
                ["trashEmpty", IconRegistry.trashEmpty],
                ["fileClean", IconRegistry.fileClean],
                ["systemMaintenance", IconRegistry.systemMaintenance]
            ]
        },

        // ========================================================
        // ATUALIZACOES
        // ========================================================

        {
            name: "ATUALIZAÇÕES",
            items: [
                ["updateAvailable", IconRegistry.updateAvailable],
                ["updateNone", IconRegistry.updateNone]
            ]
        },

        // ========================================================
        // MODO AVIAO
        // ========================================================

        {
            name: "MODO AVIÃO",
            items: [
                ["airplaneEnabled", IconRegistry.airplaneEnabled],
                ["airplaneDisabled", IconRegistry.airplaneDisabled]
            ]
        },

        // ========================================================
        // AUDIO
        // ========================================================

        {
            name: "ÁUDIO — VOLUME",
            items: [
                ["volume3", IconRegistry.volume3],
                ["volume2", IconRegistry.volume2],
                ["volume1", IconRegistry.volume1],
                ["volume0", IconRegistry.volume0],
                ["audioMuted", IconRegistry.audioMuted],
                ["audioDisabled", IconRegistry.audioDisabled],
                ["speaker", IconRegistry.speaker],
                ["headphones", IconRegistry.headphones]
            ]
        },

        // ========================================================
        // MICROFONE
        // ========================================================

        {
            name: "ÁUDIO — MICROFONE",
            items: [
                ["microphoneEnabled", IconRegistry.microphoneEnabled],
                ["microphoneDisabled", IconRegistry.microphoneDisabled]
            ]
        },

        // ========================================================
        // BRILHO
        // ========================================================

        {
            name: "BRILHO DA TELA",
            items: [
                ["brighLow", IconRegistry.brighLow],
                ["brightMedium", IconRegistry.brightMedium],
                ["brightHigh", IconRegistry.brightHigh],
                ["brightAuto", IconRegistry.brightAuto]
            ]
        },

        // ========================================================
        // TECLADO
        // ========================================================

        {
            name: "TECLADO",
            items: [
                ["keyboard", IconRegistry.keyboard]
            ]
        },

        // ========================================================
        // GAMEPAD
        // ========================================================

        {
            name: "GAMEPAD / CONTROLE",
            items: [
                ["gamepad", IconRegistry.gamepad],
                ["gamepadEnabled", IconRegistry.gamepadEnabled],
                ["gamepadDisabled", IconRegistry.gamepadDisabled]
            ]
        },

        // ========================================================
        // BLUETOOTH
        // ========================================================

        {
            name: "BLUETOOTH",
            items: [
                ["bluetooth", IconRegistry.bluetooth],
                ["bluetoothEnabled", IconRegistry.bluetoothEnabled],
                ["bluetoothDisabled", IconRegistry.bluetoothDisabled],
                ["bluetoothConnected", IconRegistry.bluetoothConnected],
                ["bluetoothDisconnected", IconRegistry.bluetoothDisconnected],
                ["bluetoothSearching", IconRegistry.bluetoothSearching],
                ["bluetoothWarning", IconRegistry.bluetoothWarning]
            ]
        },

        // ========================================================
        // CONTROLES
        // ========================================================

        {
            name: "CONTROLES / AÇÕES",
            items: [
                ["settings", IconRegistry.settings],
                ["menu", IconRegistry.menu],
                ["close", IconRegistry.close],
                ["back", IconRegistry.back],
                ["forward", IconRegistry.forward],
                ["add", IconRegistry.add],
                ["remove", IconRegistry.remove],
                ["confirm", IconRegistry.confirm],
                ["cancel", IconRegistry.cancel],
                ["powerOn", IconRegistry.powerOn],
                ["powerOff", IconRegistry.powerOff],
                ["restart", IconRegistry.restart],
                ["lock", IconRegistry.lock]
            ]
        },

        // ========================================================
        // ARQUIVOS / APLICACOES
        // ========================================================

        {
            name: "ARQUIVOS / APLICAÇÕES",
            items: [
                ["file", IconRegistry.file],
                ["folder", IconRegistry.folder],
                ["application", IconRegistry.application],
                ["hyprland", IconRegistry.hyprland],
                ["terminal", IconRegistry.terminal],
                ["browser", IconRegistry.browser],
                ["fileManager", IconRegistry.fileManager]
            ]
        },

        // ========================================================
        // MIDIA
        // ========================================================

        {
            name: "IMAGENS / MÍDIA",
            items: [
                ["image", IconRegistry.image],
                ["video", IconRegistry.video],
                ["music", IconRegistry.music],
                ["play", IconRegistry.play],
                ["pause", IconRegistry.pause],
                ["stop", IconRegistry.stop]
            ]
        },

        // ========================================================
        // OUTROS
        // ========================================================

        {
            name: "OUTROS",
            items: [
                ["help", IconRegistry.help],
                ["info", IconRegistry.info],
                ["loading", IconRegistry.loading],
                ["done", IconRegistry.done]
            ]
        }
    ]


    // ============================================================
    // JANELA
    // ============================================================

    Rectangle {
        anchors.centerIn: parent

        width: Math.min(parent.width - 80, 1200)
        height: Math.min(parent.height - 80, 850)

        radius: 20

        color: "#151518"

        border.width: 1
        border.color: "#29252f"


        ScrollView {
            anchors.fill: parent
            anchors.margins: 28

            clip: true


            Column {
                width: parent.width

                spacing: 28


                // ====================================================
                // TITULO
                // ====================================================

                Text {
                    width: parent.width

                    text: "ICON REGISTRY"

                    color: "#ffffff"

                    font.family: "sans-serif"
                    font.pixelSize: 24
                    font.bold: true
                }


                Text {
                    width: parent.width

                    text: "Catálogo dos ícones atualmente definidos"

                    color: "#8b8b92"

                    font.family: "sans-serif"
                    font.pixelSize: 13
                }


                // ====================================================
                // CATEGORIAS
                // ====================================================

                Repeater {
                    model: window.categories


                    delegate: Column {
                        width: parent.width

                        spacing: 10

                        required property var modelData


                        Text {
                            text: modelData.name

                            color: "#4da6ff"

                            font.family: "sans-serif"
                            font.pixelSize: 14
                            font.bold: true
                        }


                        Grid {
                            width: parent.width

                            columns: Math.max(
                                1,
                                Math.floor(width / 220)
                            )

                            columnSpacing: 10
                            rowSpacing: 10


                            Repeater {
                                model: modelData.items


                                delegate: Rectangle {
                                    width: 210
                                    height: 82

                                    radius: 10

                                    color: "#1c1c21"

                                    border.width: 1
                                    border.color: "#29252f"


                                    required property var modelData


                                    // ============================================
                                    // ICONE
                                    // ============================================

                                    Text {
                                        id: iconText

                                        anchors.left: parent.left
                                        anchors.leftMargin: 10

                                        anchors.verticalCenter: parent.verticalCenter

                                        width: 52

                                        horizontalAlignment:
                                            Text.AlignHCenter

                                        text: modelData[1] || "□"

                                        color: modelData[1]
                                            ? "#ffffff"
                                            : "#55555d"

                                        font.family: "Symbols Nerd Font"

                                        font.pixelSize: 32
                                    }


                                    // ============================================
                                    // INFORMACOES
                                    // ============================================

                                    Column {
                                        anchors.left: iconText.right
                                        anchors.leftMargin: 8

                                        anchors.right: parent.right
                                        anchors.rightMargin: 8

                                        anchors.verticalCenter: parent.verticalCenter

                                        spacing: 3


                                        Text {
                                            width: parent.width

                                            text: modelData[0]

                                            color: modelData[1]
                                                ? "#d0d0d5"
                                                : "#66666f"

                                            font.family: "sans-serif"

                                            font.pixelSize: 10

                                            elide:
                                                Text.ElideRight
                                        }


                                        Text {
                                            width: parent.width

                                            text: {
                                                if (!modelData[1])
                                                    return "VAZIO"

                                                var code =
                                                    modelData[1]
                                                        .codePointAt(0)

                                                return "U+" +
                                                    code
                                                        .toString(16)
                                                        .toUpperCase()
                                            }

                                            color: "#66666f"

                                            font.family: "monospace"

                                            font.pixelSize: 9
                                        }


                                        Text {
                                            width: parent.width

                                            text: modelData[1]
                                                ? "String válida"
                                                : "Sem código definido"

                                            color: modelData[1]
                                                ? "#77777f"
                                                : "#4d4d55"

                                            font.family: "sans-serif"

                                            font.pixelSize: 8
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
