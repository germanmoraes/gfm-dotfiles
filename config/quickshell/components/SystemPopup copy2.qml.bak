import Quickshell
import Quickshell.Io
import QtQuick

PopupWindow {
    id: systemPopup

    signal settingsRequested()

    property var systemControlsAnchor

    anchor.item: systemControlsAnchor

    anchor.edges: Edges.Bottom | Edges.Right
    anchor.gravity: Edges.Bottom | Edges.Right

    implicitWidth: 380

    /*
     * ALTURA DINÂMICA
     *
     * Cabeçalho:              50
     * Rede:                   72
     * Espaçamento:            10
     * Áudio:                 158
     * Espaçamento:            10
     * Brilho:                82 se disponível
     * Espaçamento:            10
     * Energia:               82 se disponível
     * Espaçamento:            10
     * Sessão:                 72
     * Margem inferior:        16
     */

    implicitHeight:
        50
        + 72
        + 10
        + 158
        + (brightnessAvailable ? 10 + 82 : 0)
        + (batteryAvailable ? 10 + 82 : 0)
        + 10
        + 72
        + 16

    visible: systemControlsAnchor
        ? systemControlsAnchor.parent.visible
        : false

    color: "transparent"

    grabFocus: true

    // =========================================================
    // HARDWARE
    // =========================================================

    property bool batteryAvailable: false
    property bool brightnessAvailable: false

    property bool wifiEnabled: true
    property bool bluetoothEnabled: true
    property bool nightModeEnabled: false

    property real volumeLevel: 0.0
    property real microphoneLevel: 0.0
    property real brightnessLevel: 0.5
    property real batteryLevel: 0.0

    // =========================================================
    // FONTE DA INTERFACE
    // =========================================================

    property string uiFont: "sans-serif"

    // =========================================================
    // DETECÇÃO DE BATERIA
    // =========================================================

    Process {
        id: batteryDetector

        command: [
            "sh",
            "-c",
            "ls /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n 1"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                systemPopup.batteryAvailable =
                    text.trim().length > 0
            }
        }
    }

    Process {
        id: batteryReader

        command: [
            "sh",
            "-c",
            "cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n 1"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let value = parseFloat(text.trim())

                if (!isNaN(value)) {
                    systemPopup.batteryLevel =
                        value / 100
                }
            }
        }
    }

    // =========================================================
    // DETECÇÃO DE BRILHO
    // =========================================================

    Process {
        id: brightnessDetector

        command: [
            "sh",
            "-c",
            "brightnessctl -m 2>/dev/null"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let output = text.trim()

                systemPopup.brightnessAvailable =
                    output.length > 0
            }
        }
    }

    Process {
        id: brightnessReader

        command: [
            "brightnessctl",
            "-m"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let output = text.trim()
                let parts = output.split(",")

                if (parts.length >= 5) {
                    let percent =
                        parseFloat(
                            parts[3].replace("%", "")
                        )

                    if (!isNaN(percent)) {
                        systemPopup.brightnessLevel =
                            percent / 100
                    }
                }
            }
        }
    }

    // =========================================================
    // ÁUDIO
    // =========================================================

    Process {
        id: volumeReader

        command: [
            "wpctl",
            "get-volume",
            "@DEFAULT_AUDIO_SINK@"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let output = text.trim()

                let match =
                    output.match(
                        /Volume:\s*([0-9.]+)/
                    )

                if (match) {
                    let value =
                        parseFloat(match[1])

                    if (!isNaN(value)) {
                        systemPopup.volumeLevel =
                            Math.min(1.0, value)
                    }
                }
            }
        }
    }

    Process {
        id: microphoneReader

        command: [
            "wpctl",
            "get-volume",
            "@DEFAULT_AUDIO_SOURCE@"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let output = text.trim()

                let match =
                    output.match(
                        /Volume:\s*([0-9.]+)/
                    )

                if (match) {
                    let value =
                        parseFloat(match[1])

                    if (!isNaN(value)) {
                        systemPopup.microphoneLevel =
                            Math.min(1.0, value)
                    }
                }
            }
        }
    }

    // =========================================================
    // ATUALIZAÇÃO
    // =========================================================

    Timer {
        interval: 500

        running: systemPopup.visible

        repeat: true

        onTriggered: {
            volumeReader.running = false
            volumeReader.running = true

            microphoneReader.running = false
            microphoneReader.running = true

            if (systemPopup.batteryAvailable) {
                batteryReader.running = false
                batteryReader.running = true
            }

            if (systemPopup.brightnessAvailable) {
                brightnessReader.running = false
                brightnessReader.running = true
            }
        }
    }

    Component.onCompleted: {
        batteryDetector.running = true
        brightnessDetector.running = true

        volumeReader.running = true
        microphoneReader.running = true
    }

    // =========================================================
    // PAINEL PRINCIPAL
    // =========================================================

    Rectangle {
        id: panel

        anchors.fill: parent

        radius: 3

        color: "#e6000000"

        border.width: 1
        border.color: "#35303d"

        // =====================================================
        // CABEÇALHO
        // =====================================================

        Text {
            x: 16
            y: 14

            text: "Controles do sistema"

            color: "#e6e1f0"

            font.family: systemPopup.uiFont
            font.pixelSize: 13
            font.bold: true
        }

        // =====================================================
        // BOTÃO DE CONFIGURAÇÕES
        // =====================================================

        Item {
            anchors.right: parent.right
            anchors.rightMargin: 10

            anchors.top: parent.top
            anchors.topMargin: 8

            width: 28
            height: 28

            Rectangle {
                anchors.fill: parent

                radius: 4

                color:
                    settingsMouse.containsMouse
                    ? "#211d25"
                    : "transparent"

                Behavior on color {
                    ColorAnimation {
                        duration: 120
                    }
                }
            }

            Text {
                anchors.centerIn: parent

                text: ""

                color:
                    settingsMouse.containsMouse
                    ? "#00e5ff"
                    : "#707070"

                font.family:
                    "Font Awesome 7 Free Solid"

                font.pixelSize: 13

                Behavior on color {
                    ColorAnimation {
                        duration: 120
                    }
                }
            }

            MouseArea {
                id: settingsMouse

                anchors.fill: parent

                hoverEnabled: true

                onClicked: {
                    systemPopup.visible = false
                    systemPopup.settingsRequested()
                }
            }
        }

        // =====================================================
        // REDE
        // =====================================================

        Rectangle {
            id: networkBox

            x: 16
            y: 50

            width: parent.width - 32
            height: 72

            radius: 3

            color: "#101010"

            border.width: 1
            border.color: "#29252f"

            Text {
                x: 12
                y: 10

                text: "Rede"

                color: "#e6e1f0"

                font.family: systemPopup.uiFont
                font.pixelSize: 12
                font.bold: true
            }

            Item {
                x: 12
                y: 34

                width: 166
                height: 34

                Text {
                    x: 0
                    y: 2

                    text: ""

                    color: "#00e5ff"

                    font.family:
                        "Font Awesome 7 Free Solid"

                    font.pixelSize: 15
                }

                Text {
                    x: 26
                    y: 0

                    text: "Wi-Fi"

                    color: "#b0a8b8"

                    font.family: systemPopup.uiFont
                    font.pixelSize: 10
                    font.bold: true
                }

                Text {
                    x: 26
                    y: 16

                    text: systemPopup.wifiEnabled
                        ? "Conectado"
                        : "Desativado"

                    color: "#66616d"

                    font.family: systemPopup.uiFont
                    font.pixelSize: 8
                }

                Rectangle {
                    x: 116
                    y: 0

                    width: 38
                    height: 20

                    radius: 10

                    color:
                        systemPopup.wifiEnabled
                        ? "#00e5ff"
                        : "#303030"

                    border.width: 1

                    border.color:
                        systemPopup.wifiEnabled
                        ? "#00e5ff"
                        : "#505050"

                    Rectangle {
                        width: 14
                        height: 14

                        radius: 7

                        anchors.verticalCenter:
                            parent.verticalCenter

                        x:
                            systemPopup.wifiEnabled
                            ? parent.width - width - 3
                            : 3

                        color: "#e6e1f0"

                        Behavior on x {
                            NumberAnimation {
                                duration: 150
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            systemPopup.wifiEnabled =
                                !systemPopup.wifiEnabled
                        }
                    }
                }
            }

            Item {
                x: 190
                y: 34

                width: 166
                height: 34

                Text {
                    x: 0
                    y: 2

                    text: ""

                    color: "#00e5ff"

                    font.family:
                        "Font Awesome 7 Free Solid"

                    font.pixelSize: 15
                }

                Text {
                    x: 26
                    y: 0

                    text: "Bluetooth"

                    color: "#b0a8b8"

                    font.family: systemPopup.uiFont
                    font.pixelSize: 10
                    font.bold: true
                }

                Text {
                    x: 26
                    y: 16

                    text:
                        systemPopup.bluetoothEnabled
                        ? "2 dispositivos"
                        : "Desativado"

                    color: "#66616d"

                    font.family: systemPopup.uiFont
                    font.pixelSize: 8
                }

                Rectangle {
                    x: 116
                    y: 0

                    width: 38
                    height: 20

                    radius: 10

                    color:
                        systemPopup.bluetoothEnabled
                        ? "#00e5ff"
                        : "#303030"

                    border.width: 1

                    border.color:
                        systemPopup.bluetoothEnabled
                        ? "#00e5ff"
                        : "#505050"

                    Rectangle {
                        width: 14
                        height: 14

                        radius: 7

                        anchors.verticalCenter:
                            parent.verticalCenter

                        x:
                            systemPopup.bluetoothEnabled
                            ? parent.width - width - 3
                            : 3

                        color: "#e6e1f0"

                        Behavior on x {
                            NumberAnimation {
                                duration: 150
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            systemPopup.bluetoothEnabled =
                                !systemPopup.bluetoothEnabled
                        }
                    }
                }
            }

            MouseArea {
                anchors.right: parent.right
                anchors.top: parent.top

                width: 28
                height: 28

                onClicked: {
                    // FUTURO:
                    // gerenciamento de redes
                    // e Bluetooth
                }

                Text {
                    anchors.centerIn: parent

                    text: ""

                    color: "#55505c"

                    font.family:
                        "Font Awesome 7 Free Solid"

                    font.pixelSize: 11
                }
            }
        }

        // =====================================================
        // ÁUDIO
        // =====================================================

        Rectangle {
            id: audioBox

            x: 16
            y: 132

            width: parent.width - 32
            height: 158

            radius: 3

            color: "#101010"

            border.width: 1
            border.color: "#29252f"

            Text {
                x: 12
                y: 10

                text: "Áudio"

                color: "#e6e1f0"

                font.family: systemPopup.uiFont
                font.pixelSize: 12
                font.bold: true
            }

            MouseArea {
                anchors.right: parent.right
                anchors.top: parent.top

                width: 28
                height: 28

                onClicked: {
                    // FUTURO:
                    // gerenciador de dispositivos
                    // de áudio
                }

                Text {
                    anchors.centerIn: parent

                    text: ""

                    color: "#55505c"

                    font.family:
                        "Font Awesome 7 Free Solid"

                    font.pixelSize: 11
                }
            }

            Text {
                x: 12
                y: 42

                text: {
                    let volume =
                        systemPopup.volumeLevel

                    if (volume <= 0.01) {
                        return ""
                    }

                    if (volume <= 0.30) {
                        return ""
                    }

                    return ""
                }

                color: "#ff79c6"

                font.family:
                    "Font Awesome 7 Free Solid"

                font.pixelSize: 16
            }

            Text {
                x: 42
                y: 39

                text: "Saída"

                color: "#b0a8b8"

                font.family: systemPopup.uiFont
                font.pixelSize: 10
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: 12

                y: 39

                text:
                    Math.round(
                        systemPopup.volumeLevel * 100
                    ) + "%"

                color: "#777777"

                font.family: systemPopup.uiFont
                font.pixelSize: 10
            }

            Rectangle {
                x: 42
                y: 59

                width: parent.width - 78
                height: 6

                radius: 3

                color: "#302a36"

                Rectangle {
                    width:
                        parent.width *
                        systemPopup.volumeLevel

                    height: parent.height

                    radius: 3

                    color: "#ff79c6"
                }

                MouseArea {
                    x: 0
                    y: -9

                    width: parent.width
                    height: 24

                    onClicked: {
                        let value =
                            mouseX / width

                        value =
                            Math.max(
                                0,
                                Math.min(1, value)
                            )

                        systemPopup.volumeLevel =
                            value

                        Quickshell.execDetached([
                            "wpctl",
                            "set-volume",
                            "@DEFAULT_AUDIO_SINK@",
                            value.toString()
                        ])
                    }

                    onPositionChanged: {
                        if (pressed) {
                            let value =
                                mouseX / width

                            value =
                                Math.max(
                                    0,
                                    Math.min(1, value)
                                )

                            systemPopup.volumeLevel =
                                value

                            Quickshell.execDetached([
                                "wpctl",
                                "set-volume",
                                "@DEFAULT_AUDIO_SINK@",
                                value.toString()
                            ])
                        }
                    }
                }
            }

            Text {
                x: 12
                y: 88

                text: ""

                color: "#ff79c6"

                font.family:
                    "Font Awesome 7 Free Solid"

                font.pixelSize: 15
            }

            Text {
                x: 42
                y: 85

                text: "Microfone"

                color: "#b0a8b8"

                font.family: systemPopup.uiFont
                font.pixelSize: 10
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: 12

                y: 85

                text:
                    Math.round(
                        systemPopup.microphoneLevel * 100
                    ) + "%"

                color: "#777777"

                font.family: systemPopup.uiFont
                font.pixelSize: 10
            }

            Rectangle {
                x: 42
                y: 105

                width: parent.width - 78
                height: 6

                radius: 3

                color: "#302a36"

                Rectangle {
                    width:
                        parent.width *
                        systemPopup.microphoneLevel

                    height: parent.height

                    radius: 3

                    color: "#00e5ff"
                }

                MouseArea {
                    x: 0
                    y: -9

                    width: parent.width
                    height: 24

                    onClicked: {
                        let value =
                            mouseX / width

                        value =
                            Math.max(
                                0,
                                Math.min(1, value)
                            )

                        systemPopup.microphoneLevel =
                            value

                        Quickshell.execDetached([
                            "wpctl",
                            "set-volume",
                            "@DEFAULT_AUDIO_SOURCE@",
                            value.toString()
                        ])
                    }

                    onPositionChanged: {
                        if (pressed) {
                            let value =
                                mouseX / width

                            value =
                                Math.max(
                                    0,
                                    Math.min(1, value)
                                )

                            systemPopup.microphoneLevel =
                                value

                            Quickshell.execDetached([
                                "wpctl",
                                "set-volume",
                                "@DEFAULT_AUDIO_SOURCE@",
                                value.toString()
                            ])
                        }
                    }
                }
            }

            Text {
                x: 42
                y: 128

                text:
                    "Dispositivo de saída / entrada padrão"

                color: "#4f4a55"

                font.family: systemPopup.uiFont
                font.pixelSize: 9
            }
        }

        // =====================================================
        // BRILHO
        // =====================================================

        Rectangle {
            id: brightnessBox

            visible:
                systemPopup.brightnessAvailable

            x: 16

            y: 300

            width: parent.width - 32
            height: 82

            radius: 3

            color: "#101010"

            border.width: 1
            border.color: "#29252f"

            Text {
                x: 12
                y: 10

                text: "Brilho"

                color: "#e6e1f0"

                font.family: systemPopup.uiFont
                font.pixelSize: 12
                font.bold: true
            }

            MouseArea {
                anchors.right: parent.right
                anchors.top: parent.top

                width: 28
                height: 28

                onClicked: {
                    // FUTURO:
                    // gerenciamento de perfil
                    // de brilho
                }

                Text {
                    anchors.centerIn: parent

                    text: ""

                    color: "#55505c"

                    font.family:
                        "Font Awesome 7 Free Solid"

                    font.pixelSize: 11
                }
            }

            Text {
                x: 12
                y: 39

                text: ""

                color: "#f1fa8c"

                font.family:
                    "Font Awesome 7 Free Solid"

                font.pixelSize: 15
            }

            Rectangle {
                x: 42
                y: 45

                width: parent.width - 105
                height: 6

                radius: 3

                color: "#302a36"

                Rectangle {
                    width:
                        parent.width *
                        systemPopup.brightnessLevel

                    height: parent.height

                    radius: 3

                    color: "#f1fa8c"
                }

                MouseArea {
                    x: 0
                    y: -9

                    width: parent.width
                    height: 24

                    onClicked: {
                        let value =
                            mouseX / width

                        value =
                            Math.max(
                                0,
                                Math.min(1, value)
                            )

                        systemPopup.brightnessLevel =
                            value

                        let percent =
                            Math.round(value * 100)

                        Quickshell.execDetached([
                            "brightnessctl",
                            "set",
                            percent + "%"
                        ])
                    }

                    onPositionChanged: {
                        if (pressed) {
                            let value =
                                mouseX / width

                            value =
                                Math.max(
                                    0,
                                    Math.min(1, value)
                                )

                            systemPopup.brightnessLevel =
                                value

                            let percent =
                                Math.round(value * 100)

                            Quickshell.execDetached([
                                "brightnessctl",
                                "set",
                                percent + "%"
                            ])
                        }
                    }
                }
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: 12

                y: 38

                text:
                    Math.round(
                        systemPopup.brightnessLevel * 100
                    ) + "%"

                color: "#777777"

                font.family: systemPopup.uiFont
                font.pixelSize: 10
            }

            MouseArea {
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                width: 92
                height: 28

                onClicked: {
                    systemPopup.nightModeEnabled =
                        !systemPopup.nightModeEnabled
                }

                Text {
                    anchors.centerIn: parent

                    text:
                        systemPopup.nightModeEnabled
                        ? "  Noturno"
                        : "  Normal"

                    color:
                        systemPopup.nightModeEnabled
                        ? "#8be9fd"
                        : "#777777"

                    font.family:
                        systemPopup.uiFont

                    font.pixelSize: 9
                }
            }
        }

        // =====================================================
        // ENERGIA
        // =====================================================

        Rectangle {
            id: batteryBox

            visible:
                systemPopup.batteryAvailable

            x: 16

            y:
                systemPopup.brightnessAvailable
                ? 392
                : 300

            width: parent.width - 32
            height: 82

            radius: 3

            color: "#101010"

            border.width: 1
            border.color: "#29252f"

            Text {
                x: 12
                y: 10

                text: "Energia"

                color: "#e6e1f0"

                font.family: systemPopup.uiFont
                font.pixelSize: 12
                font.bold: true
            }

            MouseArea {
                anchors.right: parent.right
                anchors.top: parent.top

                width: 28
                height: 28

                onClicked: {
                    // FUTURO:
                    // gerenciamento de energia
                }

                Text {
                    anchors.centerIn: parent

                    text: ""

                    color: "#55505c"

                    font.family:
                        "Font Awesome 7 Free Solid"

                    font.pixelSize: 11
                }
            }

            Text {
                x: 12
                y: 39

                text: ""

                color: "#50fa7b"

                font.family:
                    "Font Awesome 7 Free Solid"

                font.pixelSize: 15
            }

            Rectangle {
                x: 42
                y: 45

                width: parent.width - 105
                height: 6

                radius: 3

                color: "#302a36"

                Rectangle {
                    width:
                        parent.width *
                        systemPopup.batteryLevel

                    height: parent.height

                    radius: 3

                    color: "#50fa7b"
                }
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: 12

                y: 38

                text:
                    Math.round(
                        systemPopup.batteryLevel * 100
                    ) + "%"

                color: "#777777"

                font.family: systemPopup.uiFont
                font.pixelSize: 10
            }

            Text {
                x: 42
                y: 61

                text: "5h 24min restantes"

                color: "#777777"

                font.family: systemPopup.uiFont
                font.pixelSize: 9
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: 12

                y: 61

                text: "Completa 14:30"

                color: "#777777"

                font.family: systemPopup.uiFont
                font.pixelSize: 9
            }
        }

        // =====================================================
        // SESSÃO
        // =====================================================

        Rectangle {
            id: actionsBox

            x: 16

            y: {
                let value = 300

                if (systemPopup.brightnessAvailable) {
                    value += 92
                }

                if (systemPopup.batteryAvailable) {
                    value += 92
                }

                return value
            }

            width: parent.width - 32
            height: 72

            radius: 3

            color: "#101010"

            border.width: 1
            border.color: "#29252f"

            Text {
                x: 12
                y: 10

                text: "Sessão"

                color: "#e6e1f0"

                font.family: systemPopup.uiFont
                font.pixelSize: 12
                font.bold: true
            }

            Row {
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.leftMargin: 12
                anchors.rightMargin: 12

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10

                height: 28

                spacing: 6

                Rectangle {
                    width: 112
                    height: 28

                    radius: 3

                    color: "#17151a"

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            Quickshell.execDetached([
                                "loginctl",
                                "lock-session"
                            ])
                        }
                    }

                    Text {
                        anchors.centerIn: parent

                        text: "  Bloquear"

                        color: "#b0a8b8"

                        font.family:
                            systemPopup.uiFont

                        font.pixelSize: 10
                    }
                }

                Rectangle {
                    width: 112
                    height: 28

                    radius: 3

                    color: "#17151a"

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            Quickshell.execDetached([
                                "systemctl",
                                "reboot"
                            ])
                        }
                    }

                    Text {
                        anchors.centerIn: parent

                        text: "  Reiniciar"

                        color: "#b0a8b8"

                        font.family:
                            systemPopup.uiFont

                        font.pixelSize: 10
                    }
                }

                Rectangle {
                    width: 112
                    height: 28

                    radius: 3

                    color: "#17151a"

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            Quickshell.execDetached([
                                "systemctl",
                                "poweroff"
                            ])
                        }
                    }

                    Text {
                        anchors.centerIn: parent

                        text: "  Desligar"

                        color: "#ff5577"

                        font.family:
                            systemPopup.uiFont

                        font.pixelSize: 10
                    }
                }
            }
        }
    }
}
