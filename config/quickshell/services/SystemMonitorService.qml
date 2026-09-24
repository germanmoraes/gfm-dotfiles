import Quickshell
import Quickshell.Io
import QtQuick

Item {
    id: root

    // ============================================================
    // VALORES
    // ============================================================

    property real cpuUsage: 0
    property real cpuTemperature: 0
    property real memoryUsage: 0
    property real gpuUsage: 0

    property real downloadBytesPerSecond: 0
    property real uploadBytesPerSecond: 0

    // ============================================================
    // CAMINHO DO SCRIPT
    // ============================================================

    readonly property string scriptPath:
        Quickshell.env("HOME") +
        "/.config/quickshell/services/system-monitor.sh"

    // ============================================================
    // FORMATAÇÃO DE VELOCIDADE
    // ============================================================

    function formatSpeed(bytesPerSecond) {
        var value = Math.max(0, bytesPerSecond)
        var unit = "B/s"

        var KB = 1024
        var MB = 1024 * KB
        var GB = 1024 * MB
        var TB = 1024 * GB

        if (value >= 100 * GB) {
            value /= TB
            unit = "TB/s"
        } else if (value >= 100 * MB) {
            value /= GB
            unit = "GB/s"
        } else if (value >= 100 * KB) {
            value /= MB
            unit = "MB/s"
        } else if (value >= 100) {
            value /= KB
            unit = "KB/s"
        }

        var formatted = value.toFixed(1)

        // Separador decimal brasileiro
        formatted = formatted.replace(".", ",")

        // Mantém sempre pelo menos dois algarismos antes da vírgula
        var commaIndex = formatted.indexOf(",")

        if (commaIndex === 1)
            formatted = "0" + formatted

        if (commaIndex === -1 && formatted.length === 1)
            formatted = "0" + formatted

        return formatted + " " + unit
    }

    readonly property string downloadSpeed:
        formatSpeed(root.downloadBytesPerSecond)

    readonly property string uploadSpeed:
        formatSpeed(root.uploadBytesPerSecond)

    // ============================================================
    // PARSER
    // ============================================================

    function parseLine(line) {
        if (!line)
            return

        var parts = line.split("|")

        if (parts.length === 0)
            return

        var type = parts[0]

        if (type === "CPU") {
            if (parts.length < 3)
                return

            var cpu = parseFloat(parts[1])
            var temperature = parseFloat(parts[2])

            if (!isNaN(cpu))
                root.cpuUsage = cpu

            if (!isNaN(temperature))
                root.cpuTemperature = temperature

            return
        }

        if (type === "MEM") {
            if (parts.length < 2)
                return

            var memory = parseFloat(parts[1])

            if (!isNaN(memory))
                root.memoryUsage = memory

            return
        }

        if (type === "GPU") {
            if (parts.length < 2)
                return

            var gpu = parseFloat(parts[1])

            if (!isNaN(gpu))
                root.gpuUsage = gpu

            return
        }

        if (type === "NET") {
            if (parts.length < 3)
                return

            var download = parseFloat(parts[1])
            var upload = parseFloat(parts[2])

            if (!isNaN(download))
                root.downloadBytesPerSecond = download

            if (!isNaN(upload))
                root.uploadBytesPerSecond = upload

            return
        }
    }

    // ============================================================
    // PROCESSO
    // ============================================================

    Process {
        id: monitorProcess

        command: [
            "bash",
            root.scriptPath
        ]

        running: true

        stdout: SplitParser {
            splitMarker: "\n"

            onRead: function(data) {
                root.parseLine(data.trim())
            }
        }
    }

    Component.onDestruction: {
        if (monitorProcess.running)
            monitorProcess.running = false
    }
}
