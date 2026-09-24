import QtQuick

Item {
    id: page

    property string categoryTitle: "Sistema"

    property int categoryIndex: 0

    readonly property var sections: [
        [
            "Informações do sistema",
            "Data e hora",
            "Idioma/região",
            "Sessão"
        ],
        [
            "Wi-Fi",
            "Ethernet",
            "VPN",
            "DNS",
            "Bluetooth"
        ],
        [
            "Saída de áudio",
            "Entrada/microfone",
            "Volume",
            "Dispositivo padrão",
            "Perfil de áudio"
        ],
        [
            "Monitor",
            "Resolução",
            "Taxa de atualização",
            "Escala",
            "Orientação",
            "Monitores múltiplos"
        ],
        [
            "Papel de parede",
            "Tema",
            "Cores",
            "Transparência",
            "Barra",
            "Ícones"
        ],
        [
            "Bateria",
            "Economia de energia",
            "Suspensão",
            "Tela desligada"
        ],
        [
            "Teclado",
            "Mouse",
            "Touchpad",
            "Gamepad",
            "Outros dispositivos de entrada"
        ],
        [
            "Workspaces",
            "Atalhos",
            "Janelas",
            "Animações",
            "Regras",
            "Comportamento da área de trabalho"
        ]
    ]

    property string selectedSection: ""

    Text {
        id: title

        x: 30
        y: 28

        text: page.categoryTitle

        color: "#e6e1f0"

        font.family: "sans-serif"
        font.pixelSize: 20
        font.bold: true
    }

    Text {
        x: 30
        y: 60

        text: "Configurações de " + page.categoryTitle.toLowerCase()

        color: "#66616d"

        font.family: "sans-serif"
        font.pixelSize: 10
    }

    Rectangle {
        x: 30
        y: 92

        width: parent.width - 60
        height: 1

        color: "#242129"
    }

    Column {
        x: 30
        y: 116

        width: parent.width - 60

        spacing: 6

        Repeater {
            model:
                page.sections[
                    Math.max(
                        0,
                        Math.min(
                            page.categoryIndex,
                            page.sections.length - 1
                        )
                    )
                ]

            delegate: Rectangle {
                width: parent.width
                height: 58

                radius: 4

                color:
                    sectionMouse.containsMouse
                    ? "#161318"
                    : "#101010"

                border.width: 1

                border.color:
                    sectionMouse.containsMouse
                    ? "#302b35"
                    : "#211e25"

                Behavior on color {
                    ColorAnimation {
                        duration: 120
                    }
                }

                Text {
                    x: 16

                    anchors.verticalCenter:
                        parent.verticalCenter

                    text: modelData

                    color: "#bdb6c6"

                    font.family: "sans-serif"
                    font.pixelSize: 11
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 16

                    anchors.verticalCenter:
                        parent.verticalCenter

                    text: ""

                    color: "#55505c"

                    font.family:
                        "Font Awesome 7 Free Solid"

                    font.pixelSize: 11
                }

                MouseArea {
                    id: sectionMouse

                    anchors.fill: parent

                    hoverEnabled: true

                    onClicked: {
                        page.selectedSection =
                            modelData
                    }
                }
            }
        }
    }

    Rectangle {
        visible:
            page.selectedSection !== ""

        x: 30

        y: parent.height - 92

        width: parent.width - 60
        height: 58

        radius: 4

        color: "#101010"

        border.width: 1
        border.color: "#29252f"

        Text {
            x: 16
            y: 10

            text: page.selectedSection

            color: "#e6e1f0"

            font.family: "sans-serif"
            font.pixelSize: 11
            font.bold: true
        }

        Text {
            x: 16
            y: 31

            text: "Esta configuração será implementada nesta seção."

            color: "#55505c"

            font.family: "sans-serif"
            font.pixelSize: 9
        }
    }
}
