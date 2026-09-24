pragma Singleton

import Quickshell

Singleton {

    // ============================================================
    // FONTES
    // ============================================================

    // Fonte principal dos ícones de REDE
    readonly property string networkFont:
        "Material Symbols Rounded"

    // Fonte dos ícones de SISTEMA
    readonly property string systemFont:
        "Material Symbols Rounded"

    // Fonte dos ícones de NOTIFICAÇÕES
    readonly property string notificationFont:
        "Material Symbols Rounded"

    // Fonte dos ícones de ÁUDIO
    readonly property string audioFont:
        "Material Symbols Rounded"

    // Fonte dos ícones de DISPOSITIVOS
    readonly property string deviceFont:
        "Material Symbols Rounded"

    // Fonte dos ícones de CONTROLES
    readonly property string controlFont:
        "Material Symbols Rounded"


    // ============================================================
    // REDE — GERAL
    // ============================================================

    readonly property string networkConnected:
        String.fromCodePoint(0xE322)

    readonly property string networkDisconnected:
        String.fromCodePoint(0xE648)

    readonly property string networkDisabled:
        String.fromCodePoint(0xE5C9)

    readonly property string networkNoConnection:
        String.fromCodePoint(0xE648)


    // ============================================================
    // REDE — CABEADA / ETHERNET
    // ============================================================

    // Ethernet conectada
    readonly property string ethernetConnected:
        String.fromCodePoint(0xE322)

    // Sem conexão
    readonly property string ethernetDisconnected:
        String.fromCodePoint(0xE648)

    // Ethernet conectada mas sem internet
    readonly property string ethernetDisabled:
        String.fromCodePoint(0xE5C9)

    // Cabo conectado
    readonly property string ethernetCableConnected:
        String.fromCodePoint(0xE322)

    // Cabo desconectado
    readonly property string ethernetCableDisconnected:
        String.fromCodePoint(0xE648)


    // ============================================================
    // REDE — WI-FI
    // ============================================================

    // Wi-Fi ligado, sem conexão
    readonly property string wifiEnabled:
        String.fromCodePoint(0xEBE4)

    // Wi-Fi desligado
    readonly property string wifiDisabled:
        String.fromCodePoint(0xE5C9)

    // Wi-Fi conectado — sinal muito fraco
    readonly property string wifi0:
        String.fromCodePoint(0xEBE4)

    // Wi-Fi conectado — sinal fraco
    readonly property string wifi1:
        String.fromCodePoint(0xEBD6)

    // Wi-Fi conectado — sinal médio
    readonly property string wifi2:
        String.fromCodePoint(0xEBD6)

    // Wi-Fi conectado — sinal forte
    readonly property string wifi3:
        String.fromCodePoint(0xEBE1)

    // Wi-Fi conectado — sinal cheio
    readonly property string wifi4:
        String.fromCodePoint(0xEBE1)

    // Wi-Fi conectado — sinal muito fraco com alerta
    readonly property string wifi0a:
        String.fromCodePoint(0xEBE4)

    // Wi-Fi conectado — sinal fraco com alerta
    readonly property string wifi1a:
        String.fromCodePoint(0xEBE4)

    // Wi-Fi conectado — sinal médio com alerta
    readonly property string wifi2a:
        String.fromCodePoint(0xEBD6)

    // Wi-Fi conectado — sinal forte com alerta
    readonly property string wifi3a:
        String.fromCodePoint(0xEBE1)

    // Wi-Fi conectado — sinal cheio com alerta
    readonly property string wifi4a:
        String.fromCodePoint(0xEBE1)

    // Wi-Fi sem conexão
    readonly property string wifiDisconnected:
        String.fromCodePoint(0xE648)

    // Wi-Fi procurando redes
    readonly property string wifiSearching:
        String.fromCodePoint(0xEBE4)

    // Wi-Fi com problema / alerta
    readonly property string wifiWarning:
        String.fromCodePoint(0xE5C9)


    // ============================================================
    // BATERIA
    // ============================================================

    // Mantidos como aliases semânticos.
    // O SystemControls utiliza as faixas principais abaixo.

    readonly property string battery0:
        String.fromCodePoint(0xEBDC)

    readonly property string battery1:
        String.fromCodePoint(0xEBDC)

    readonly property string battery2:
        String.fromCodePoint(0xEBD9)

    readonly property string battery3:
        String.fromCodePoint(0xEBDD)

    readonly property string battery4:
        String.fromCodePoint(0xEBDD)

    readonly property string battery5:
        String.fromCodePoint(0xEBE2)

    readonly property string battery6:
        String.fromCodePoint(0xEBE2)

    readonly property string battery7:
        String.fromCodePoint(0xEBE2)

    readonly property string battery8:
        String.fromCodePoint(0xE1A4)

    readonly property string battery9:
        String.fromCodePoint(0xE1A4)

    readonly property string battery10:
        String.fromCodePoint(0xE1A4)

    readonly property string battery0c:
        String.fromCodePoint(0xEBDC)

    readonly property string battery1c:
        String.fromCodePoint(0xEBDC)

    readonly property string battery2c:
        String.fromCodePoint(0xEBD9)

    readonly property string battery3c:
        String.fromCodePoint(0xEBDD)

    readonly property string battery4c:
        String.fromCodePoint(0xEBDD)

    readonly property string battery5c:
        String.fromCodePoint(0xEBE2)

    readonly property string battery6c:
        String.fromCodePoint(0xEBE2)

    readonly property string battery7c:
        String.fromCodePoint(0xEBE2)

    readonly property string battery8c:
        String.fromCodePoint(0xE1A4)

    readonly property string battery9c:
        String.fromCodePoint(0xE1A4)

    readonly property string battery10c:
        String.fromCodePoint(0xE1A4)

    readonly property string batteryWarning:
        String.fromCodePoint(0xE5C9)


    // ============================================================
    // GERENCIAMENTO DE SISTEMA — CPU
    // ============================================================

    readonly property string cpu:
        String.fromCodePoint(0xF4BC)


    // ============================================================
    // GERENCIAMENTO DE SISTEMA — TEMPERATURA
    // ============================================================

    readonly property string temperature100:
        String.fromCodePoint(0xF2C7)

    readonly property string temperature75:
        String.fromCodePoint(0xF2C8)

    readonly property string temperature50:
        String.fromCodePoint(0xF2C9)

    readonly property string temperature25:
        String.fromCodePoint(0xF2CA)

    readonly property string temperature0:
        String.fromCodePoint(0xF2CB)


    // ============================================================
    // GERENCIAMENTO DE SISTEMA — MEMÓRIA
    // ============================================================

    readonly property string memory:
        String.fromCodePoint(0xEFC5)


    // ============================================================
    // GERENCIAMENTO DE SISTEMA — GPU / VGA
    // ============================================================

    readonly property string gpu:
        String.fromCodePoint(0xF1104)


    // ============================================================
    // GERENCIAMENTO DE SISTEMA — TRANSFERÊNCIA
    // ============================================================

    readonly property string download:
        String.fromCodePoint(0xF0533)

    readonly property string upload:
        String.fromCodePoint(0xF0535)


    // ============================================================
    // NOTIFICAÇÕES
    // ============================================================

    readonly property string notification:
        ""

    readonly property string notificationNew:
        ""

    readonly property string notificationRead:
        ""

    readonly property string notificationDisabled:
        ""

    readonly property string notificationImportant:
        ""

    readonly property string alert:
        ""

    readonly property string information:
        ""

    readonly property string success:
        ""

    readonly property string error:
        ""

    readonly property string warning:
        ""


    // ============================================================
    // ÁREA DE TRANSFERÊNCIA — CLIPBOARD
    // ============================================================

    readonly property string clipboardText:
        ""

    readonly property string clipboardImage:
        ""

    readonly property string clipboardFile:
        ""

    readonly property string clipboard:
        ""

    readonly property string clipboardClear:
        ""


    // ============================================================
    // LIMPEZA / MANUTENÇÃO DO SISTEMA
    // ============================================================

    readonly property string systemClean:
        String.fromCodePoint(0xF00E2)

    readonly property string cacheClean:
        ""

    readonly property string trash:
        ""

    readonly property string trashEmpty:
        ""

    readonly property string fileClean:
        ""

    readonly property string systemMaintenance:
        ""


    // ============================================================
    // ATUALIZAÇÕES DO SISTEMA
    // ============================================================

    readonly property string updateAvailable:
        String.fromCodePoint(0xF303)

    readonly property string updateNone:
        String.fromCodePoint(0xF303)


    // ============================================================
    // MODO AVIÃO
    // ============================================================

    readonly property string airplaneEnabled:
        String.fromCodePoint(0xF001D)

    readonly property string airplaneDisabled:
        String.fromCodePoint(0xF001E)


    // ============================================================
    // ÁUDIO — VOLUME
    // ============================================================

    readonly property string volume3:
        String.fromCodePoint(0xE050)

    readonly property string volume2:
        String.fromCodePoint(0xE04D)

    readonly property string volume1:
        String.fromCodePoint(0xE04C)

    readonly property string volume0:
        String.fromCodePoint(0xE04C)

    readonly property string audioMuted:
        String.fromCodePoint(0xE04F)

    readonly property string audioDisabled:
        String.fromCodePoint(0xE04F)

    readonly property string speaker:
        String.fromCodePoint(0xE050)

    readonly property string headphones:
        String.fromCodePoint(0xE04F)


    // ============================================================
    // ÁUDIO — MICROFONE
    // ============================================================

    readonly property string microphoneEnabled:
        String.fromCodePoint(0xF130)

    readonly property string microphoneDisabled:
        String.fromCodePoint(0xF131)


    // ============================================================
    // BRILHO DA TELA
    // ============================================================

    // Tela brilho baixo
    readonly property string brightLow:
        String.fromCodePoint(0xE1AD)

    // Compatibilidade com a grafia anterior
    readonly property string brighLow:
        brightLow

    // Tela brilho médio
    readonly property string brightMedium:
        String.fromCodePoint(0xE1AE)

    // Tela brilho alto
    readonly property string brightHigh:
        String.fromCodePoint(0xE1AC)

    // Tela brilho automático
    readonly property string brightAuto:
        String.fromCodePoint(0xE1AC)


    // ============================================================
    // TECLADO
    // ============================================================

    readonly property string keyboard:
        String.fromCodePoint(0xF11C)


    // ============================================================
    // GAMEPAD / CONTROLE
    // ============================================================

    readonly property string gamepad:
        String.fromCodePoint(0xF02B4)

    readonly property string gamepadEnabled:
        String.fromCodePoint(0xF02B4)

    readonly property string gamepadDisabled:
        String.fromCodePoint(0xF02B5)


    // ============================================================
    // BLUETOOTH
    // ============================================================

    readonly property string bluetooth:
        String.fromCodePoint(0xE1A7)

    readonly property string bluetoothEnabled:
        String.fromCodePoint(0xE1A7)

    readonly property string bluetoothDisabled:
        String.fromCodePoint(0xE1A7)

    readonly property string bluetoothConnected:
        String.fromCodePoint(0xE1A8)

    readonly property string bluetoothDisconnected:
        String.fromCodePoint(0xE1A7)

    readonly property string bluetoothSearching:
        String.fromCodePoint(0xE1A7)

    readonly property string bluetoothWarning:
        String.fromCodePoint(0xE1A7)


    // ============================================================
    // CONTROLES / AÇÕES GERAIS
    // ============================================================

    readonly property string settings:
        ""

    readonly property string menu:
        String.fromCodePoint(0xF359)

    readonly property string close:
        ""

    readonly property string back:
        ""

    readonly property string forward:
        ""

    readonly property string add:
        ""

    readonly property string remove:
        ""

    readonly property string confirm:
        ""

    readonly property string cancel:
        ""

    readonly property string powerOn:
        ""

    readonly property string powerOff:
        String.fromCodePoint(0xE8AC)

    readonly property string restart:
        String.fromCodePoint(0xF01E)

    readonly property string lock:
        String.fromCodePoint(0xF023)


    // ============================================================
    // ARQUIVOS / APLICAÇÕES
    // ============================================================

    readonly property string file:
        ""

    readonly property string folder:
        ""

    readonly property string application:
        ""

    readonly property string hyprland:
        String.fromCodePoint(0xF359)

    readonly property string terminal:
        String.fromCodePoint(0xF489)

    readonly property string browser:
        ""

    readonly property string fileManager:
        ""


    // ============================================================
    // IMAGENS / MÍDIA
    // ============================================================

    readonly property string image:
        ""

    readonly property string video:
        ""

    readonly property string music:
        ""

    readonly property string play:
        ""

    readonly property string pause:
        ""

    readonly property string stop:
        ""


    // ============================================================
    // OUTROS
    // ============================================================

    readonly property string help:
        ""

    readonly property string info:
        ""

    readonly property string loading:
        ""

    readonly property string done:
        ""
}
