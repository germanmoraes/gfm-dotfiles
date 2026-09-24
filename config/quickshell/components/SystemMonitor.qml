import Quickshell
import Quickshell.Io
import QtQuick
import qs.services

Item {
    id: root

    // ============================================================
    // FONTES DOS ÍCONES
    // ============================================================

    readonly property string cpuIconFont:
        "Symbols Nerd Font"
        //"Material Symbols Rounded"

    readonly property string temperatureIconFont:
        "Symbols Nerd Font"
        //"Material Symbols Rounded"

    readonly property string memoryIconFont:
        "Symbols Nerd Font"

    readonly property string gpuIconFont:
        "Symbols Nerd Font"
        //"Material Symbols Rounded"

    readonly property string downloadIconFont:
        "Symbols Nerd Font"
        //"Material Symbols Rounded"

    readonly property string uploadIconFont:
        "Symbols Nerd Font"
        //"Material Symbols Rounded"

    // ============================================================
    // FONTES DOS VALORES
    // ============================================================

    readonly property string cpuValueFont:
        "sans-serif"
        //"JetBrainsMono Nerd Font"

    readonly property string temperatureValueFont:
        "sans-serif"
        //"JetBrainsMono Nerd Font"

    readonly property string memoryValueFont:
        "sans-serif"
        //"JetBrainsMono Nerd Font"

    readonly property string gpuValueFont:
        "sans-serif"
        //"JetBrainsMono Nerd Font"

    readonly property string downloadValueFont:
        "sans-serif"
        //"JetBrainsMono Nerd Font"

    readonly property string uploadValueFont:
        "sans-serif"
        //"JetBrainsMono Nerd Font"

    // ============================================================
    // FONTES DOS RÓTULOS
    // ============================================================

    readonly property string cpuLabelFont:
        "JetBrainsMono Nerd Font"

    readonly property string temperatureLabelFont:
        "JetBrainsMono Nerd Font"

    readonly property string memoryLabelFont:
        "JetBrainsMono Nerd Font"

    readonly property string gpuLabelFont:
        "JetBrainsMono Nerd Font"

    readonly property string downloadLabelFont:
        "JetBrainsMono Nerd Font"

    readonly property string uploadLabelFont:
        "JetBrainsMono Nerd Font"

    // ============================================================
    // ÍCONES
    // ============================================================

    readonly property string cpuIcon:
        String.fromCodePoint(0xf4bc)

    readonly property string temperatureIcon:
        String.fromCodePoint(0xef2b)

    readonly property string memoryIcon:
        String.fromCodePoint(0xefc5)

    readonly property string gpuIcon:
        String.fromCodePoint(0xF1104)

    readonly property string downloadIcon:
        String.fromCodePoint(0xf0047)

    readonly property string uploadIcon:
        String.fromCodePoint(0xf005f)

    // ============================================================
    // TEXTOS
    // ============================================================

    readonly property string cpuLabel:
        "CPU"

    readonly property string temperatureLabel:
        "CPU"

    readonly property string memoryLabel:
        "RAM"

    readonly property string gpuLabel:
        "GPU"

    readonly property string downloadLabel:
        "DOWN"

    readonly property string uploadLabel:
        "UP"

    readonly property string percentSuffix:
        "%"

    readonly property string temperatureSuffix:
        "°C"

    // ============================================================
    // TAMANHO DOS ÍCONES
    // ============================================================

    readonly property int cpuIconSize: 17
    readonly property int temperatureIconSize: 17
    readonly property int memoryIconSize: 17
    readonly property int gpuIconSize: 17
    readonly property int downloadIconSize: 17
    readonly property int uploadIconSize: 17

    // ============================================================
    // TAMANHO DOS VALORES
    // ============================================================

    readonly property int cpuValueSize: 9
    readonly property int temperatureValueSize: 9
    readonly property int memoryValueSize: 9
    readonly property int gpuValueSize: 9
    readonly property int downloadValueSize: 9
    readonly property int uploadValueSize: 9

    // ============================================================
    // TAMANHO DOS RÓTULOS
    // ============================================================

    readonly property int cpuLabelSize: 7
    readonly property int temperatureLabelSize: 7
    readonly property int memoryLabelSize: 7
    readonly property int gpuLabelSize: 7
    readonly property int downloadLabelSize: 7
    readonly property int uploadLabelSize: 7

    // ============================================================
    // CORES NORMAIS
    // ============================================================

    readonly property color cpuNormalIconColor:
        "#dddd00"
        //"#8b8b92"

    readonly property color cpuNormalValueColor:
        "#ffffff"
        //"#d8d8dc"

    readonly property color cpuNormalLabelColor:
        "#77777e"

    readonly property color temperatureNormalIconColor:
        "#ff4444"
        //"#8b8b92"

    readonly property color temperatureNormalValueColor:
        "#ffffff"
        //"#d8d8dc"

    readonly property color temperatureNormalLabelColor:
        "#77777e"

    readonly property color memoryNormalIconColor:
        "#ee33ff"
        //"#bd00ff"
        //"#8b8b92"

    readonly property color memoryNormalValueColor:
        "#ffffff"
        //"#d8d8dc"

    readonly property color memoryNormalLabelColor:
        "#77777e"

    readonly property color gpuNormalIconColor:
        "#00f0ff"
        //"#8b8b92"

    readonly property color gpuNormalValueColor:
        "#ffffff"
        //"#d8d8dc"

    readonly property color gpuNormalLabelColor:
        "#77777e"

    readonly property color downloadNormalIconColor:
        "#00ff66"
        //"#8b8b92"

    readonly property color downloadNormalValueColor:
        "#ffffff"
        //"#d8d8dc"

    readonly property color downloadNormalLabelColor:
        "#77777e"

    readonly property color uploadNormalIconColor:
        "#ff9900"
        //"#8b8b92"

    readonly property color uploadNormalValueColor:
        "#ffffff"
        //"#d8d8dc"

    readonly property color uploadNormalLabelColor:
        "#77777e"

    // ============================================================
    // CORES DE ALERTA
    // ============================================================

    readonly property color cpuAlertIconColor:
        "#ff3b30"

    readonly property color cpuAlertValueColor:
        "#ff3b30"

    readonly property color cpuAlertLabelColor:
        "#b52b25"

    readonly property color temperatureAlertIconColor:
        "#ff3b30"

    readonly property color temperatureAlertValueColor:
        "#ff3b30"

    readonly property color temperatureAlertLabelColor:
        "#b52b25"

    readonly property color memoryAlertIconColor:
        "#ff3b30"

    readonly property color memoryAlertValueColor:
        "#ff3b30"

    readonly property color memoryAlertLabelColor:
        "#b52b25"

    readonly property color gpuAlertIconColor:
        "#ff3b30"

    readonly property color gpuAlertValueColor:
        "#ff3b30"

    readonly property color gpuAlertLabelColor:
        "#b52b25"

    readonly property color downloadAlertIconColor:
        "#ff3b30"

    readonly property color downloadAlertValueColor:
        "#ff3b30"

    readonly property color downloadAlertLabelColor:
        "#b52b25"

    readonly property color uploadAlertIconColor:
        "#ff3b30"

    readonly property color uploadAlertValueColor:
        "#ff3b30"

    readonly property color uploadAlertLabelColor:
        "#b52b25"

    // ============================================================
    // LIMITES DE ALERTA
    // ============================================================

    readonly property real cpuAlertThreshold:
        90

    readonly property real temperatureAlertThreshold:
        80

    readonly property real memoryAlertThreshold:
        90

    readonly property real gpuAlertThreshold:
        90

    readonly property real downloadAlertThreshold:
        0

    readonly property real uploadAlertThreshold:
        0

    // ============================================================
    // GEOMETRIA
    // ============================================================

    readonly property int capsuleHeight:
        36

    readonly property int capsuleRadius:
        18

    readonly property int capsuleHorizontalPadding:
        9

    readonly property int itemSpacing:
        7

    readonly property int iconTextSpacing:
        3

    readonly property int columnSpacing:
        -3

    readonly property int iconSlotWidth:
        18

    // ============================================================
    // CAPSULA
    // ============================================================

    readonly property color capsuleColor:
        "#242428"

    readonly property color capsuleBorderColor:
        "#29252f"

    readonly property int capsuleBorderWidth:
        1

    // ============================================================
    // SERVIÇO
    // ============================================================

    SystemMonitorService {
        id: service
    }

    // ============================================================
    // TASK MANAGER
    // ============================================================

    Process {
        id: taskManagerProcess

        command: [
            Quickshell.env("HOME") + "/.local/bin/TaskManagerOG-1.0.0-x86_64.AppImage"
        ]
    }

    // ============================================================
    // ESTADOS DE ALERTA
    // ============================================================

    readonly property bool cpuAlert:
        service.cpuUsage >= root.cpuAlertThreshold

    readonly property bool temperatureAlert:
        service.cpuTemperature >= root.temperatureAlertThreshold

    readonly property bool memoryAlert:
        service.memoryUsage >= root.memoryAlertThreshold

    readonly property bool gpuAlert:
        service.gpuUsage >= root.gpuAlertThreshold

    // ============================================================
    // COMPONENTE DE MÉTRICA
    // ============================================================

    component MonitorValue: Item {
        id: metric

        property string icon: ""
        property string iconFont: ""

        property string value: ""
        property string label: ""

        property string valueFont: ""
        property string labelFont: ""

        property int iconSize: 17
        property int valueSize: 10
        property int labelSize: 7

        property color normalIconColor:
            "#8b8b92"

        property color normalValueColor:
            "#d8d8dc"

        property color normalLabelColor:
            "#77777e"

        property color alertIconColor:
            "#ff3b30"

        property color alertValueColor:
            "#ff3b30"

        property color alertLabelColor:
            "#b52b25"

        property bool alert:
            false

        implicitWidth:
            contentRow.implicitWidth

        implicitHeight:
            root.capsuleHeight

        Row {
            id: contentRow

            anchors.verticalCenter:
                parent.verticalCenter

            spacing:
                root.iconTextSpacing

            Item {
                width:
                    root.iconSlotWidth

                height:
                    metric.iconSize

                Text {
                    anchors.centerIn:
                        parent

                    text:
                        metric.icon

                    font.family:
                        metric.iconFont

                    font.pixelSize:
                        metric.iconSize

                    font.weight:
                        Font.Normal

                    color:
                        metric.alert
                        ? metric.alertIconColor
                        : metric.normalIconColor

                    horizontalAlignment:
                        Text.AlignHCenter

                    verticalAlignment:
                        Text.AlignVCenter

                    renderType:
                        Text.NativeRendering
                }
            }

            Column {
                spacing:
                    root.columnSpacing

                Text {
                    text:
                        metric.value

                    font.family:
                        metric.valueFont

                    font.pixelSize:
                        metric.valueSize

                    font.weight:
                        Font.DemiBold

                    color:
                        metric.alert
                        ? metric.alertValueColor
                        : metric.normalValueColor

                    verticalAlignment:
                        Text.AlignVCenter
                }

                Text {
                    text:
                        metric.label

                    font.family:
                        metric.labelFont

                    font.pixelSize:
                        metric.labelSize

                    font.weight:
                        Font.Normal

                    color:
                        metric.alert
                        ? metric.alertLabelColor
                        : metric.normalLabelColor

                    verticalAlignment:
                        Text.AlignVCenter
                }
            }
        }
    }

    // ============================================================
    // CAPSULA
    // ============================================================

    Rectangle {
        id: capsule

        width:
            metricsRow.implicitWidth +
            root.capsuleHorizontalPadding * 2

        height:
            root.capsuleHeight

        radius:
            root.capsuleRadius

        color:
            root.capsuleColor

        border.width:
            root.capsuleBorderWidth

        border.color:
            root.capsuleBorderColor

        Row {
            id: metricsRow

            anchors.centerIn:
                parent

            spacing:
                root.itemSpacing

            // ----------------------------------------------------
            // CPU
            // ----------------------------------------------------

            MonitorValue {
                icon:
                    root.cpuIcon

                iconFont:
                    root.cpuIconFont

                iconSize:
                    root.cpuIconSize

                value:
                    Math.round(service.cpuUsage) +
                    root.percentSuffix

                label:
                    root.cpuLabel

                valueFont:
                    root.cpuValueFont

                labelFont:
                    root.cpuLabelFont

                valueSize:
                    root.cpuValueSize

                labelSize:
                    root.cpuLabelSize

                normalIconColor:
                    root.cpuNormalIconColor

                normalValueColor:
                    root.cpuNormalValueColor

                normalLabelColor:
                    root.cpuNormalLabelColor

                alertIconColor:
                    root.cpuAlertIconColor

                alertValueColor:
                    root.cpuAlertValueColor

                alertLabelColor:
                    root.cpuAlertLabelColor

                alert:
                    root.cpuAlert
            }

            // ----------------------------------------------------
            // TEMPERATURA
            // ----------------------------------------------------

            MonitorValue {
                icon:
                    root.temperatureIcon

                iconFont:
                    root.temperatureIconFont

                iconSize:
                    root.temperatureIconSize

                value:
                    Math.round(service.cpuTemperature) +
                    root.temperatureSuffix

                label:
                    root.temperatureLabel

                valueFont:
                    root.temperatureValueFont

                labelFont:
                    root.temperatureLabelFont

                valueSize:
                    root.temperatureValueSize

                labelSize:
                    root.temperatureLabelSize

                normalIconColor:
                    root.temperatureNormalIconColor

                normalValueColor:
                    root.temperatureNormalValueColor

                normalLabelColor:
                    root.temperatureNormalLabelColor

                alertIconColor:
                    root.temperatureAlertIconColor

                alertValueColor:
                    root.temperatureAlertValueColor

                alertLabelColor:
                    root.temperatureAlertLabelColor

                alert:
                    root.temperatureAlert
            }

            // ----------------------------------------------------
            // RAM
            // ----------------------------------------------------

            MonitorValue {
                icon:
                    root.memoryIcon

                iconFont:
                    root.memoryIconFont

                iconSize:
                    root.memoryIconSize

                value:
                    Math.round(service.memoryUsage) +
                    root.percentSuffix

                label:
                    root.memoryLabel

                valueFont:
                    root.memoryValueFont

                labelFont:
                    root.memoryLabelFont

                valueSize:
                    root.memoryValueSize

                labelSize:
                    root.memoryLabelSize

                normalIconColor:
                    root.memoryNormalIconColor

                normalValueColor:
                    root.memoryNormalValueColor

                normalLabelColor:
                    root.memoryNormalLabelColor

                alertIconColor:
                    root.memoryAlertIconColor

                alertValueColor:
                    root.memoryAlertValueColor

                alertLabelColor:
                    root.memoryAlertLabelColor

                alert:
                    root.memoryAlert
            }

            // ----------------------------------------------------
            // GPU
            // ----------------------------------------------------

            MonitorValue {
                icon:
                    root.gpuIcon

                iconFont:
                    root.gpuIconFont

                iconSize:
                    root.gpuIconSize

                value:
                    Math.round(service.gpuUsage) +
                    root.percentSuffix

                label:
                    root.gpuLabel

                valueFont:
                    root.gpuValueFont

                labelFont:
                    root.gpuLabelFont

                valueSize:
                    root.gpuValueSize

                labelSize:
                    root.gpuLabelSize

                normalIconColor:
                    root.gpuNormalIconColor

                normalValueColor:
                    root.gpuNormalValueColor

                normalLabelColor:
                    root.gpuNormalLabelColor

                alertIconColor:
                    root.gpuAlertIconColor

                alertValueColor:
                    root.gpuAlertValueColor

                alertLabelColor:
                    root.gpuAlertLabelColor

                alert:
                    root.gpuAlert
            }

            // ----------------------------------------------------
            // DOWNLOAD
            // ----------------------------------------------------

            MonitorValue {
                icon:
                    root.downloadIcon

                iconFont:
                    root.downloadIconFont

                iconSize:
                    root.downloadIconSize

                value:
                    service.downloadSpeed

                label:
                    root.downloadLabel

                valueFont:
                    root.downloadValueFont

                labelFont:
                    root.downloadLabelFont

                valueSize:
                    root.downloadValueSize

                labelSize:
                    root.downloadLabelSize

                normalIconColor:
                    root.downloadNormalIconColor

                normalValueColor:
                    root.downloadNormalValueColor

                normalLabelColor:
                    root.downloadNormalLabelColor

                alertIconColor:
                    root.downloadAlertIconColor

                alertValueColor:
                    root.downloadAlertValueColor

                alertLabelColor:
                    root.downloadAlertLabelColor

                alert:
                    false
            }

            // ----------------------------------------------------
            // UPLOAD
            // ----------------------------------------------------

            MonitorValue {
                icon:
                    root.uploadIcon

                iconFont:
                    root.uploadIconFont

                iconSize:
                    root.uploadIconSize

                value:
                    service.uploadSpeed

                label:
                    root.uploadLabel

                valueFont:
                    root.uploadValueFont

                labelFont:
                    root.uploadLabelFont

                valueSize:
                    root.uploadValueSize

                labelSize:
                    root.uploadLabelSize

                normalIconColor:
                    root.uploadNormalIconColor

                normalValueColor:
                    root.uploadNormalValueColor

                normalLabelColor:
                    root.uploadNormalLabelColor

                alertIconColor:
                    root.uploadAlertIconColor

                alertValueColor:
                    root.uploadAlertValueColor

                alertLabelColor:
                    root.uploadAlertLabelColor

                alert:
                    false
            }
        }

        MouseArea {
            anchors.fill:
                parent

//            cursorShape:
//              Qt.PointingHandCursor

            onClicked: {
                taskManagerProcess.running = true
            }
        }
    }

    implicitWidth:
        capsule.width

    implicitHeight:
        capsule.height
}
