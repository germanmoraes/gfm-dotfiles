import Quickshell
import Quickshell.Io
import QtQuick

Item {
    id: root

    // ============================================================
    // ÍCONE
    // ============================================================

    readonly property string updateIcon:
        "\uf303"

    readonly property int updateIconSize:
        18

    readonly property int updateIconSlotSize:
        20

    readonly property int updateIconHorizontalOffset:
        -2

    readonly property color updateActiveColor:
        "#4da6ff"

    readonly property color updateInactiveColor:
        "#8b8b92"

    // ============================================================
    // CONTADOR
    // ============================================================

    readonly property string updateCountFontFamily:
        "sans-serif"
        //"JetBrainsMono Nerd Font"

    readonly property int updateCountFontSize:
        12

    readonly property color updateCountColor:
        "#ffffff"

    // ============================================================
    // CÁPSULA
    // ============================================================

    readonly property int capsuleHorizontalPadding:
        10

    readonly property color capsuleColor:
        "#e6151518"

    readonly property color borderColor:
        "#29252f"

    // ============================================================
    // ESTADO
    // ============================================================

    property int updateCount:
        0

    // Indica se o Pacman está executando uma transação.
    property bool pacmanBusy:
        false

    // ============================================================
    // ARQUIVO DE CONTROLE
    // ============================================================

    readonly property string refreshFile:
        Quickshell.cachePath("arch-updates-refresh")

    // ============================================================
    // PROCESSO DE ATUALIZAÇÃO
    // ============================================================

    Process {
        id: updateLauncher

        command: [
            "/usr/bin/kitty",
            "--",
            "/usr/bin/bash",
            Quickshell.shellPath("components/system-update.sh")
        ]

        onRunningChanged: {
            if (!running)
                root.checkUpdates()
        }
    }

    // ============================================================
    // VERIFICAÇÃO DE ATUALIZAÇÕES
    // ============================================================

    Process {
        id: updateProcess

        command: [
            "sh",
            "-c",
            "pacman_count=$(/usr/bin/checkupdates 2>/dev/null | wc -l); " +
            "flatpak_count=$(/usr/bin/flatpak remote-ls --updates 2>/dev/null | wc -l); " +
            "echo $((pacman_count + flatpak_count))"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                const count =
                    parseInt(this.text.trim())

                if (!isNaN(count))
                    root.updateCount = count
            }
        }
    }

    // ============================================================
    // VERIFICAÇÃO DO LOCK DO PACMAN
    // ============================================================

    Process {
        id: pacmanLockProcess

        command: [
            "sh",
            "-c",
            "if [ -e /var/lib/pacman/db.lck ]; then echo 1; else echo 0; fi"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                const lockActive =
                    this.text.trim() === "1"

                if (root.pacmanBusy && !lockActive) {
                    root.checkUpdates()
                }

                root.pacmanBusy =
                    lockActive
            }
        }
    }

    // ============================================================
    // FUNÇÃO DE VERIFICAÇÃO
    // ============================================================

    function checkUpdates() {
        if (updateProcess.running)
            return

        updateProcess.running = true
    }

    // ============================================================
    // TEMPORIZADOR — VERIFICAÇÃO A CADA 5 MINUTOS
    // ============================================================

    Timer {
        interval:
            5 * 60 * 1000

        running:
            true

        repeat:
            true

        onTriggered: {
            root.checkUpdates()
        }
    }

    // ============================================================
    // TEMPORIZADOR — MONITORAMENTO DO PACMAN
    // ============================================================

    Timer {
        interval:
            2000

        running:
            true

        repeat:
            true

        onTriggered: {
            if (!pacmanLockProcess.running)
                pacmanLockProcess.running = true
        }
    }

    // ============================================================
    // PRIMEIRA VERIFICAÇÃO
    // ============================================================

    Component.onCompleted: {
        root.checkUpdates()

        pacmanLockProcess.running = true
    }

    // ============================================================
    // LAYOUT
    // ============================================================

    implicitWidth:
        updateRow.implicitWidth +
        root.capsuleHorizontalPadding * 2

    implicitHeight:
        36

    // ============================================================
    // CÁPSULA
    // ============================================================

    Rectangle {
        anchors.fill:
            parent

        radius:
            height / 2

        color:
            root.capsuleColor

        border.width:
            1

        border.color:
            root.borderColor

        MouseArea {
            anchors.fill:
                parent

            onClicked: {
                if (!updateLauncher.running)
                    updateLauncher.running = true
            }
        }
    }

    // ============================================================
    // CONTEÚDO
    // ============================================================

    Row {
        id: updateRow

        anchors.centerIn:
            parent

        height:
            20

        spacing:
            6

        // ========================================================
        // SLOT DO ÍCONE ARCH
        // ========================================================

        Item {
            width:
                root.updateIconSlotSize

            height:
                parent.height

            Text {
                width:
                    root.updateIconSize

                height:
                    parent.height

                x:
                    (parent.width - width) / 2 +
                    root.updateIconHorizontalOffset

                y:
                    0

                text:
                    root.updateIcon

                font.family:
                    "JetBrainsMono Nerd Font"

                font.pixelSize:
                    root.updateIconSize

                font.weight:
                    Font.Medium

                color:
                    root.updateCount > 0
                        ? root.updateActiveColor
                        : root.updateInactiveColor

                verticalAlignment:
                    Text.AlignVCenter

                horizontalAlignment:
                    Text.AlignHCenter

                renderType:
                    Text.NativeRendering
            }
        }

        // ========================================================
        // QUANTIDADE
        // ========================================================

        Text {
            visible:
                root.updateCount > 0

            height:
                parent.height

            text:
                root.updateCount

            font.family:
                root.updateCountFontFamily

            font.pixelSize:
                root.updateCountFontSize

            font.weight:
                Font.Medium

            color:
                root.updateCountColor

            verticalAlignment:
                Text.AlignVCenter

            horizontalAlignment:
                Text.AlignHCenter

            renderType:
                Text.NativeRendering
        }
    }
}
