import Quickshell
import QtQuick

FloatingWindow {
    id: settingsWindow

    title: "Configurações"

    implicitWidth: 1050
    implicitHeight: 680

    minimumSize.width: 900
    minimumSize.height: 560

    color: "#0d0d0f"

    signal requestClose()

    property int selectedCategory: 0

    property var categories: [
        {
            title: "Sistema",
            icon: "",
            description: "Informações do sistema, data, hora e sessão."
        },
        {
            title: "Rede",
            icon: "",
            description: "Wi-Fi, Ethernet, VPN, DNS e Bluetooth."
        },
        {
            title: "Áudio",
            icon: "",
            description: "Dispositivos de saída, entrada, volume e perfis."
        },
        {
            title: "Tela",
            icon: "",
            description: "Monitores, resolução, frequência e escala."
        },
        {
            title: "Aparência",
            icon: "",
            description: "Papel de parede, tema, cores e transparência."
        },
        {
            title: "Energia",
            icon: "",
            description: "Bateria, economia de energia e suspensão."
        },
        {
            title: "Dispositivos",
            icon: "",
            description: "Teclado, mouse, touchpad e outros dispositivos."
        },
        {
            title: "Hyprland",
            icon: "",
            description: "Áreas de trabalho, atalhos, janelas e animações."
        }
    ]

    // =========================================================
    // FECHAMENTO DA JANELA
    // =========================================================

    onClosed: {
        settingsWindow.requestClose()
    }

    Rectangle {
        anchors.fill: parent

        color: "#0d0d0f"

        // =====================================================
        // BARRA LATERAL
        // =====================================================

        Rectangle {
            id: sidebar

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            width: 230

            color: "#0b0b0d"

            // ---------------------------------------------
            // TÍTULO
            // ---------------------------------------------

            Text {
                x: 22
                y: 24

                text: "Configurações"

                color: "#e6e1f0"

                font.family: "sans-serif"
                font.pixelSize: 15
                font.bold: true
            }

            Text {
                x: 22
                y: 48

                text: "Sistema"

                color: "#55505c"

                font.family: "sans-serif"
                font.pixelSize: 9
            }

            // ---------------------------------------------
            // CATEGORIAS
            // ---------------------------------------------

            Column {
                x: 12
                y: 78

                width: parent.width - 24

                spacing: 3

                Repeater {
                    model: settingsWindow.categories

                    delegate: Rectangle {
                        required property var modelData
                        required property int index

                        width: parent.width
                        height: 44

                        radius: 3

                        color:
                            settingsWindow.selectedCategory === index
                            ? "#17151a"
                            : "transparent"

                        border.width:
                            settingsWindow.selectedCategory === index
                            ? 1
                            : 0

                        border.color: "#29252f"

                        Rectangle {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom

                            width: 2

                            radius: 1

                            color:
                                settingsWindow.selectedCategory === index
                                ? "#00e5ff"
                                : "transparent"
                        }

                        Text {
                            x: 14
                            anchors.verticalCenter: parent.verticalCenter

                            text: modelData.icon

                            color:
                                settingsWindow.selectedCategory === index
                                ? "#00e5ff"
                                : "#706a78"

                            font.family:
                                "Font Awesome 7 Free Solid"

                            font.pixelSize: 14
                        }

                        Text {
                            x: 43
                            anchors.verticalCenter: parent.verticalCenter

                            text: modelData.title

                            color:
                                settingsWindow.selectedCategory === index
                                ? "#e6e1f0"
                                : "#8b8591"

                            font.family: "sans-serif"
                            font.pixelSize: 10
                            font.bold:
                                settingsWindow.selectedCategory === index
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                settingsWindow.selectedCategory = index
                            }
                        }
                    }
                }
            }

            // ---------------------------------------------
            // DIVISÓRIA
            // ---------------------------------------------

            Rectangle {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                width: 1

                color: "#29252f"
            }
        }

        // =====================================================
        // ÁREA PRINCIPAL
        // =====================================================

        Rectangle {
            anchors.left: sidebar.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            color: "#101010"

            // ---------------------------------------------
            // CABEÇALHO DA PÁGINA
            // ---------------------------------------------

            Text {
                x: 32
                y: 28

                text:
                    settingsWindow.categories[
                        settingsWindow.selectedCategory
                    ].title

                color: "#e6e1f0"

                font.family: "sans-serif"
                font.pixelSize: 18
                font.bold: true
            }

            Text {
                x: 32
                y: 58

                width: parent.width - 64

                text:
                    settingsWindow.categories[
                        settingsWindow.selectedCategory
                    ].description

                color: "#66616d"

                font.family: "sans-serif"
                font.pixelSize: 10
            }

            Rectangle {
                x: 32
                y: 88

                width: parent.width - 64
                height: 1

                color: "#29252f"
            }

            // =================================================
            // SISTEMA
            // =================================================

            Item {
                visible:
                    settingsWindow.selectedCategory === 0

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                anchors.topMargin: 110

                Text {
                    x: 32
                    y: 10

                    text: "Sistema"

                    color: "#e6e1f0"

                    font.family: "sans-serif"
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    x: 32
                    y: 40

                    text: "As configurações do sistema serão adicionadas aqui."

                    color: "#66616d"

                    font.family: "sans-serif"
                    font.pixelSize: 10
                }
            }

            // =================================================
            // REDE
            // =================================================

            Item {
                visible:
                    settingsWindow.selectedCategory === 1

                anchors.fill: parent

                anchors.topMargin: 110

                Text {
                    x: 32
                    y: 10

                    text: "Rede"

                    color: "#e6e1f0"

                    font.family: "sans-serif"
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    x: 32
                    y: 40

                    text: "Wi-Fi, Ethernet, VPN, DNS e Bluetooth."

                    color: "#66616d"

                    font.family: "sans-serif"
                    font.pixelSize: 10
                }
            }

            // =================================================
            // ÁUDIO
            // =================================================

            Item {
                visible:
                    settingsWindow.selectedCategory === 2

                anchors.fill: parent

                anchors.topMargin: 110

                Text {
                    x: 32
                    y: 10

                    text: "Áudio"

                    color: "#e6e1f0"

                    font.family: "sans-serif"
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    x: 32
                    y: 40

                    text: "Dispositivos de saída e entrada, volume e perfis."

                    color: "#66616d"

                    font.family: "sans-serif"
                    font.pixelSize: 10
                }
            }

            // =================================================
            // TELA
            // =================================================

            Item {
                visible:
                    settingsWindow.selectedCategory === 3

                anchors.fill: parent

                anchors.topMargin: 110

                Text {
                    x: 32
                    y: 10

                    text: "Tela"

                    color: "#e6e1f0"

                    font.family: "sans-serif"
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    x: 32
                    y: 40

                    text: "Monitores, resolução, frequência, escala e orientação."

                    color: "#66616d"

                    font.family: "sans-serif"
                    font.pixelSize: 10
                }
            }

            // =================================================
            // APARÊNCIA
            // =================================================

            Item {
                visible:
                    settingsWindow.selectedCategory === 4

                anchors.fill: parent

                anchors.topMargin: 110

                Text {
                    x: 32
                    y: 10

                    text: "Aparência"

                    color: "#e6e1f0"

                    font.family: "sans-serif"
                    font.pixelSize: 12
                    font.bold: true
                }

                Rectangle {
                    x: 32
                    y: 48

                    width: 260
                    height: 110

                    radius: 3

                    color: "#0b0b0d"

                    border.width: 1
                    border.color: "#29252f"

                    Text {
                        x: 16
                        y: 15

                        text: "Papel de parede"

                        color: "#e6e1f0"

                        font.family: "sans-serif"
                        font.pixelSize: 11
                        font.bold: true
                    }

                    Text {
                        x: 16
                        y: 40

                        text: "Escolher imagem, GIF ou vídeo."

                        color: "#66616d"

                        font.family: "sans-serif"
                        font.pixelSize: 9
                    }

                    Rectangle {
                        x: 16
                        y: 68

                        width: 120
                        height: 26

                        radius: 3

                        color: "#17151a"

                        border.width: 1
                        border.color: "#35303d"

                        Text {
                            anchors.centerIn: parent

                            text: "Abrir"

                            color: "#b0a8b8"

                            font.family: "sans-serif"
                            font.pixelSize: 9
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                // A página de papel de parede
                                // será conectada aqui.
                            }
                        }
                    }
                }
            }

            // =================================================
            // ENERGIA
            // =================================================

            Item {
                visible:
                    settingsWindow.selectedCategory === 5

                anchors.fill: parent

                anchors.topMargin: 110

                Text {
                    x: 32
                    y: 10

                    text: "Energia"

                    color: "#e6e1f0"

                    font.family: "sans-serif"
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    x: 32
                    y: 40

                    text: "Bateria, economia de energia, suspensão e desligamento."

                    color: "#66616d"

                    font.family: "sans-serif"
                    font.pixelSize: 10
                }
            }

            // =================================================
            // DISPOSITIVOS
            // =================================================

            Item {
                visible:
                    settingsWindow.selectedCategory === 6

                anchors.fill: parent

                anchors.topMargin: 110

                Text {
                    x: 32
                    y: 10

                    text: "Dispositivos"

                    color: "#e6e1f0"

                    font.family: "sans-serif"
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    x: 32
                    y: 40

                    text: "Teclado, mouse, touchpad e outros dispositivos."

                    color: "#66616d"

                    font.family: "sans-serif"
                    font.pixelSize: 10
                }
            }

            // =================================================
            // HYPRLAND
            // =================================================

            Item {
                visible:
                    settingsWindow.selectedCategory === 7

                anchors.fill: parent

                anchors.topMargin: 110

                Text {
                    x: 32
                    y: 10

                    text: "Hyprland"

                    color: "#e6e1f0"

                    font.family: "sans-serif"
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    x: 32
                    y: 40

                    text: "Áreas de trabalho, atalhos, janelas, animações e regras."

                    color: "#66616d"

                    font.family: "sans-serif"
                    font.pixelSize: 10
                }
            }
        }
    }
}
