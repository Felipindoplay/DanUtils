# 🐾 DanUtils — Central de Ferramentas & Ativação

<p align="center">
  <img src="https://img.shields.io/badge/PowerShell-5.1%2B-blue?style=for-the-badge&logo=powershell" alt="PowerShell">
  <img src="https://img.shields.io/badge/Tema-Catppuccin%20Mocha-cba6f7?style=for-the-badge" alt="Catppuccin Mocha">
  <img src="https://img.shields.io/badge/Licença-MIT-a6e3a1?style=for-the-badge" alt="License">
</p>

O **DanUtils** é uma central unificada com interface gráfica (WPF/XAML) projetada em PowerShell que reúne as melhores ferramentas de pós-formatação para Windows: **WinUtil** *(Chris Titus Tech Suite)* e **MAS AIO** *(Microsoft Activation Scripts)*. Tudo isso construído sob a belíssima paleta de cores **Catppuccin Mocha**.

---

## ⚡ Execução Online Rápida (Recomendado)
Você pode rodar o **DanUtils** diretamente pelo PowerShell sem precisar baixar nenhum arquivo no seu computador!

Abra o **PowerShell como Administrador** e execute:

```powershell
irm [https://raw.githubusercontent.com/Felipindoplay/DanUtils/main/DanUtils.ps1](https://raw.githubusercontent.com/Felipindoplay/DanUtils/main/DanUtils.ps1) | iex
(Ou simplesmente execute o arquivo wrapper local Ferramenta-On.ps1 disponibilizado neste repositório).

🛠️ Recursos Principais
1. Suporte a WinUtil (Chris Titus Suite)
Lançamento Otimizado: Executa a ferramenta sem janelas pretas de terminal abertas em segundo plano.

Automação via .json: Detecção automática de um arquivo de perfil (.json) na raiz do programa ou escolha manual através do Explorador de Arquivos para aplicação de perfis silenciosos.

2. Suporte a MAS AIO (Microsoft Activation Scripts)
Ativação Permanente: Windows 10/11 por HWID (Licença Digital) e Microsoft Office por Ohook.

Opções Avançadas: Ativações KMS38 (até 2038), Online KMS (Renovação 180 dias) e troca fácil de Edição do Windows.

Diagnósticos: Verificação em tempo real do status de ativação (slmgr) e botões de reparo de serviços corrompidos (sppsvc).

🎨 Paleta de Cores: Catppuccin Mocha
A interface foi programada sob medida utilizando os tons oficiais da paleta Mocha:

Fundo: #1e1e2e (Base) & #181825 (Mantle)

Cartões: #313244 (Surface0)

Destaques: #cba6f7 (Mauve - Roxo Principal), #f5c2e7 (Pink), #89b4fa (Blue) & #a6e3a1 (Green).

🚀 Integração com autounattend.xml
O DanUtils pode ser incorporado na instalação do Windows para abrir automaticamente na sua primeira inicialização da Área de Trabalho. Consulte o arquivo guia.txt para instruções de configuração no Unattend Generator (Schneegans).