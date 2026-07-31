# ==============================================================================
# DANUTILS.PS1 - CENTRAL DE FERRAMENTAS (THEME: CATPPUCCIN MOCHA)
# ==============================================================================
[console]::InputEncoding = [System.Text.Encoding]::UTF8
[console]::OutputEncoding = [System.Text.Encoding]::UTF8

# --- AUTO-ELEVAÇÃO E EXECUÇÃO SILENCIOSA ---
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Esconder janela de terminal preta de fundo
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
if ($consolePtr -ne [IntPtr]::Zero) {
    [Console.Window]::ShowWindow($consolePtr, 0) # 0 = SW_HIDE
}

# ==============================================================================
# CARREGAMENTO DE ASSETS DO WPF
# ==============================================================================
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Windows.Forms

# Procura arquivo .json automaticamente no diretório atual
$ScriptDir = Split-Path -Parent $PSCommandPath
$DefaultJson = Get-ChildItem -Path $ScriptDir -Filter "*.json" | Select-Object -First 1
$SelectedJsonPath = if ($DefaultJson) { $DefaultJson.FullName } else { "Nenhum arquivo .json detectado automaticamente." }

# ==============================================================================
# INTERFACE GRÁFICA (XAML) - TEMA CATPPUCCIN MOCHA + ABAS INTEGRADAS
# ==============================================================================
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="DanUtils - Central de Ferramentas &amp; Ativação" Height="680" Width="960"
        WindowStartupLocation="CenterScreen" Background="#1e1e2e"
        FontFamily="Segoe UI" ResizeMode="CanMinimize">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>

        <!-- BARRA DE CABEÇALHO SUPERIOR (CATPPUCCIN MOCHA) -->
        <Border Grid.Row="0" Background="#181825" BorderBrush="#313244" BorderThickness="0,0,0,1" Padding="15,12">
            <Grid>
                <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                    <TextBlock Text="🐾" Foreground="#f5c2e7" FontSize="18" Margin="5,0,8,0"/>
                    <TextBlock Text="DANUTILS • CENTRAL DE FERRAMENTAS" Foreground="#cba6f7" FontSize="16" FontWeight="Bold"/>
                </StackPanel>
            </Grid>
        </Border>

        <!-- ============================================================== -->
        <!-- VIEW 1: HOME (CARDS DE ESCOLHA) -->
        <!-- ============================================================== -->
        <Grid Name="ViewHome" Grid.Row="1" Margin="30" Visibility="Visible">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>

            <!-- CABEÇALHO DA HOME -->
            <StackPanel Grid.Row="0" Margin="0,15,0,25">
                <TextBlock Text="Selecione uma ferramenta abaixo" Foreground="#cdd6f4" FontSize="24" FontWeight="Bold" HorizontalAlignment="Center"/>
                <TextBlock Text="Acesse rapidamente os utilitários para otimização ou licenciamento do sistema" Foreground="#a6adc8" FontSize="14" HorizontalAlignment="Center" Margin="0,6,0,0"/>
            </StackPanel>

            <!-- CARDS DE ESCOLHA -->
            <Grid Grid.Row="1" VerticalAlignment="Center" Margin="20,0">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="30"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- CARD 1: WINUTIL -->
                <Border Grid.Column="0" Background="#313244" BorderBrush="#45475a" BorderThickness="1" CornerRadius="10" Padding="25">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>
                        <StackPanel Grid.Row="0" VerticalAlignment="Center" Margin="0,10">
                            <TextBlock Text="🛠️ WinUtil" Foreground="#cdd6f4" FontSize="22" FontWeight="Bold" HorizontalAlignment="Center" Margin="0,0,0,6"/>
                            <TextBlock Text="Chris Titus Tech Suite" Foreground="#cba6f7" FontSize="13" FontWeight="SemiBold" HorizontalAlignment="Center" Margin="0,0,0,16"/>
                            <TextBlock Text="Tweaks de sistema, instalação de programas (WinGet), otimização do Windows, atualizações e personalização avançada." Foreground="#a6adc8" FontSize="13" TextWrapping="Wrap" TextAlignment="Center" LineHeight="20"/>
                        </StackPanel>
                        <Button Name="BtnOpenWinUtilCard" Grid.Row="1" Content="ABRIR WINUTIL" Height="44" Background="#cba6f7" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" FontSize="13" Cursor="Hand" Margin="0,20,0,0"/>
                    </Grid>
                </Border>

                <!-- CARD 2: MAS AIO -->
                <Border Grid.Column="2" Background="#313244" BorderBrush="#45475a" BorderThickness="1" CornerRadius="10" Padding="25">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>
                        <StackPanel Grid.Row="0" VerticalAlignment="Center" Margin="0,10">
                            <TextBlock Text="⚡ MAS AIO" Foreground="#cdd6f4" FontSize="22" FontWeight="Bold" HorizontalAlignment="Center" Margin="0,0,0,6"/>
                            <TextBlock Text="Microsoft Activation Suite" Foreground="#f5c2e7" FontSize="13" FontWeight="SemiBold" HorizontalAlignment="Center" Margin="0,0,0,16"/>
                            <TextBlock Text="Ativação permanente para Windows (HWID) e Office (Ohook), conversão de edição e ferramentas de correção." Foreground="#a6adc8" FontSize="13" TextWrapping="Wrap" TextAlignment="Center" LineHeight="20"/>
                        </StackPanel>
                        <Button Name="BtnOpenMASCard" Grid.Row="1" Content="ABRIR MAS AIO" Height="44" Background="#f5c2e7" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" FontSize="13" Cursor="Hand" Margin="0,20,0,0"/>
                    </Grid>
                </Border>
            </Grid>

            <!-- RODAPÉ DA HOME -->
            <StackPanel Grid.Row="2" Orientation="Horizontal" HorizontalAlignment="Right" Margin="0,20,0,0">
                <Button Name="BtnExit" Content="Sair do DanUtils" Width="130" Height="36" Background="#45475a" Foreground="#cdd6f4" BorderThickness="0" FontWeight="SemiBold" Cursor="Hand"/>
            </StackPanel>
        </Grid>

        <!-- ============================================================== -->
        <!-- VIEW 2: WINUTIL EMBUTIDO NA ABA -->
        <!-- ============================================================== -->
        <Grid Name="ViewWinUtil" Grid.Row="1" Visibility="Collapsed">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="230"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <!-- SIDEBAR DO WINUTIL -->
            <Border Background="#181825" Grid.Column="0" BorderBrush="#313244" BorderThickness="0,0,1,0">
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <StackPanel Grid.Row="0" Margin="15,25,15,20">
                        <TextBlock Text="🛠️ WINUTIL" Foreground="#cba6f7" FontSize="18" FontWeight="Bold" HorizontalAlignment="Center"/>
                        <TextBlock Text="Chris Titus Suite" Foreground="#a6adc8" FontSize="11" HorizontalAlignment="Center" Margin="0,3,0,0"/>
                    </StackPanel>

                    <StackPanel Grid.Row="1" Margin="10,0,10,0">
                        <Button Name="TabWinUtilInfo" Content="🚀 Sobre &amp; Executar" Height="42" Background="#313244" Foreground="#cdd6f4" BorderThickness="0" Margin="0,0,0,8" FontSize="13" FontWeight="SemiBold" HorizontalContentAlignment="Left" Padding="15,0,0,0" Cursor="Hand"/>
                    </StackPanel>

                    <StackPanel Grid.Row="2" Margin="10,10,10,20">
                        <Button Name="BtnRunWinUtilFast" Content="⚡ Lançar Padrão" Height="40" Background="#cba6f7" Foreground="#11111b" BorderThickness="0" Margin="0,0,0,8" FontSize="13" FontWeight="Bold" Cursor="Hand"/>
                        <Button Name="BtnVoltarHomeWinUtil" Content="⬅️ Voltar ao Início" Height="38" Background="#45475a" Foreground="#cdd6f4" BorderThickness="0" FontSize="13" FontWeight="SemiBold" Cursor="Hand"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- PAINEL PRINCIPAL DO WINUTIL -->
            <Grid Grid.Column="1" Margin="30">
                <StackPanel>
                    <TextBlock Text="Chris Titus Tech - Windows Utility" Foreground="#cdd6f4" FontSize="22" FontWeight="SemiBold" Margin="0,0,0,5"/>
                    <TextBlock Text="O utilitário mais completo para limpar, otimizar e gerenciar o Windows." Foreground="#a6adc8" FontSize="13" Margin="0,0,0,25"/>

                    <Border Background="#313244" CornerRadius="8" Padding="20" Margin="0,0,0,15" BorderBrush="#45475a" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="⚡ Execução Padrão (Otimizada)" Foreground="#cba6f7" FontSize="16" FontWeight="Bold" Margin="0,0,0,8"/>
                            <TextBlock Text="Carregue a interface oficial do WinUtil de forma otimizada, com redução no tempo de inicialização e sem janelas pretas em segundo plano." Foreground="#cdd6f4" FontSize="13" TextWrapping="Wrap" LineHeight="20" Margin="0,0,0,15"/>
                            <Button Name="BtnLaunchWinUtilMain" Content="🚀 ABRIR WINUTIL AGORA" Width="200" Height="42" Background="#cba6f7" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" HorizontalAlignment="Left" Cursor="Hand"/>
                        </StackPanel>
                    </Border>

                    <!-- OPÇÃO DE CONFIGURAÇÃO JSON AUTOMÁTICA OU MANUAL -->
                    <Border Background="#313244" CornerRadius="8" Padding="20" Margin="0,0,0,15" BorderBrush="#45475a" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="📁 Execução com Perfil Customizado (.JSON)" Foreground="#f5c2e7" FontSize="16" FontWeight="Bold" Margin="0,0,0,8"/>
                            <TextBlock Text="O WinUtil permite aplicar um arquivo JSON exportado previamente para automatizar tweaks e instalações de programas." Foreground="#cdd6f4" FontSize="13" TextWrapping="Wrap" LineHeight="20" Margin="0,0,0,12"/>
                            
                            <TextBlock Text="Arquivo detectado / selecionado:" Foreground="#a6adc8" FontSize="11" Margin="0,0,0,4"/>
                            <TextBox Name="TxtJsonPath" Text="$SelectedJsonPath" Background="#181825" Foreground="#a6e3a1" FontSize="12" Padding="8" IsReadOnly="True" BorderThickness="0" Margin="0,0,0,15"/>

                            <StackPanel Orientation="Horizontal">
                                <Button Name="BtnChooseJson" Content="📁 Escolher JSON Manualmente" Width="190" Height="38" Background="#45475a" Foreground="#cdd6f4" BorderThickness="0" FontWeight="SemiBold" Cursor="Hand" Margin="0,0,10,0"/>
                                <Button Name="BtnRunWinUtilJson" Content="⚡ EXECUTAR COM JSON" Width="180" Height="38" Background="#a6e3a1" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" Cursor="Hand"/>
                            </StackPanel>
                        </StackPanel>
                    </Border>
                </StackPanel>
            </Grid>
        </Grid>

        <!-- ============================================================== -->
        <!-- VIEW 3: MAS AIO EMBUTIDO NA ABA -->
        <!-- ============================================================== -->
        <Grid Name="ViewMAS" Grid.Row="1" Visibility="Collapsed">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="230"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <!-- SIDEBAR DO MAS AIO -->
            <Border Background="#181825" Grid.Column="0" BorderBrush="#313244" BorderThickness="0,0,1,0">
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <StackPanel Grid.Row="0" Margin="15,25,15,20">
                        <TextBlock Text="⚡ MAS SUITE" Foreground="#f5c2e7" FontSize="18" FontWeight="Bold" HorizontalAlignment="Center"/>
                        <TextBlock Text="Ativação &amp; Licenciamento" Foreground="#a6adc8" FontSize="11" HorizontalAlignment="Center" Margin="0,3,0,0"/>
                    </StackPanel>

                    <StackPanel Grid.Row="1" Margin="10,0,10,0">
                        <Button Name="TabAtivacao" Content="🪟 Windows / Office" Height="42" Background="#313244" Foreground="#cdd6f4" BorderThickness="0" Margin="0,0,0,8" FontSize="13" FontWeight="SemiBold" HorizontalContentAlignment="Left" Padding="15,0,0,0" Cursor="Hand"/>
                        <Button Name="TabKMS" Content="⚡ KMS38 &amp; Online KMS" Height="42" Background="#181825" Foreground="#a6adc8" BorderThickness="0" Margin="0,0,0,8" FontSize="13" FontWeight="SemiBold" HorizontalContentAlignment="Left" Padding="15,0,0,0" Cursor="Hand"/>
                        <Button Name="TabStatus" Content="📊 Status da Licença" Height="42" Background="#181825" Foreground="#a6adc8" BorderThickness="0" Margin="0,0,0,8" FontSize="13" FontWeight="SemiBold" HorizontalContentAlignment="Left" Padding="15,0,0,0" Cursor="Hand"/>
                        <Button Name="TabFerramentas" Content="🛠️ Reparo &amp; Soluções" Height="42" Background="#181825" Foreground="#a6adc8" BorderThickness="0" Margin="0,0,0,8" FontSize="13" FontWeight="SemiBold" HorizontalContentAlignment="Left" Padding="15,0,0,0" Cursor="Hand"/>
                    </StackPanel>

                    <StackPanel Grid.Row="2" Margin="10,10,10,20">
                        <Button Name="BtnMASCLI" Content="🌐 Abrir MAS (CLI)" Height="40" Background="#f5c2e7" Foreground="#11111b" BorderThickness="0" Margin="0,0,0,8" FontSize="13" FontWeight="Bold" Cursor="Hand"/>
                        <Button Name="BtnVoltarHomeMAS" Content="⬅️ Voltar ao Início" Height="38" Background="#45475a" Foreground="#cdd6f4" BorderThickness="0" FontSize="13" FontWeight="SemiBold" Cursor="Hand"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- PAINEL PRINCIPAL DO MAS -->
            <Grid Grid.Column="1" Margin="25">

                <!-- ABA 1: ATIVAÇÃO PRINCIPAL -->
                <ScrollViewer Name="PanelAtivacao" VerticalScrollBarVisibility="Auto" Visibility="Visible">
                    <StackPanel>
                        <TextBlock Text="Ativação do Sistema &amp; Office" Foreground="#cdd6f4" FontSize="22" FontWeight="SemiBold" Margin="0,0,0,5"/>
                        <TextBlock Text="Métodos permanentes e oficiais integrados ao Microsoft Activation Scripts (MAS)." Foreground="#a6adc8" FontSize="12" Margin="0,0,0,20"/>

                        <Border Background="#313244" CornerRadius="6" Padding="16" Margin="0,0,0,12" BorderBrush="#45475a" BorderThickness="1">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel Grid.Column="0" Margin="0,0,15,0">
                                    <TextBlock Text="🪟 Windows 10 / 11 (Licença Digital HWID)" Foreground="#89b4fa" FontSize="15" FontWeight="Bold"/>
                                    <TextBlock Text="Ativa o Windows permanentemente vinculando uma licença digital ao ID do hardware. Não expira e sobrevive a reinstalações." Foreground="#cdd6f4" FontSize="12" TextWrapping="Wrap" Margin="0,4,0,0"/>
                                </StackPanel>
                                <Button Name="BtnHWID" Grid.Column="1" Content="ATIVAR HWID" Width="120" Height="38" Background="#89b4fa" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" Cursor="Hand"/>
                            </Grid>
                        </Border>

                        <Border Background="#313244" CornerRadius="6" Padding="16" Margin="0,0,0,12" BorderBrush="#45475a" BorderThickness="1">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel Grid.Column="0" Margin="0,0,15,0">
                                    <TextBlock Text="📦 Microsoft Office (Método Ohook)" Foreground="#f5c2e7" FontSize="15" FontWeight="Bold"/>
                                    <TextBlock Text="Ativação permanente para Microsoft Office (2013-2024 / 365). Suporta atualizações e não altera arquivos originais." Foreground="#cdd6f4" FontSize="12" TextWrapping="Wrap" Margin="0,4,0,0"/>
                                </StackPanel>
                                <Button Name="BtnOhook" Grid.Column="1" Content="ATIVAR OHOOK" Width="120" Height="38" Background="#f5c2e7" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" Cursor="Hand"/>
                            </Grid>
                        </Border>

                        <Border Background="#313244" CornerRadius="6" Padding="16" Margin="0,0,0,12" BorderBrush="#45475a" BorderThickness="1">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel Grid.Column="0" Margin="0,0,15,0">
                                    <TextBlock Text="🔄 Alterar Edição do Windows" Foreground="#a6e3a1" FontSize="15" FontWeight="Bold"/>
                                    <TextBlock Text="Converte facilmente a edição do seu Windows (ex: Home para Pro, ou Pro para Enterprise) sem formatar." Foreground="#cdd6f4" FontSize="12" TextWrapping="Wrap" Margin="0,4,0,0"/>
                                </StackPanel>
                                <Button Name="BtnChangeEdition" Grid.Column="1" Content="ALTERAR" Width="120" Height="38" Background="#a6e3a1" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" Cursor="Hand"/>
                            </Grid>
                        </Border>
                    </StackPanel>
                </ScrollViewer>

                <!-- ABA 2: KMS38 & ONLINE KMS -->
                <ScrollViewer Name="PanelKMS" VerticalScrollBarVisibility="Auto" Visibility="Collapsed">
                    <StackPanel>
                        <TextBlock Text="Ativação KMS &amp; Servidores" Foreground="#cdd6f4" FontSize="22" FontWeight="SemiBold" Margin="0,0,0,5"/>
                        <TextBlock Text="Métodos alternativos para Windows Server, Enterprise ou licenças temporárias." Foreground="#a6adc8" FontSize="12" Margin="0,0,0,20"/>

                        <Border Background="#313244" CornerRadius="6" Padding="16" Margin="0,0,0,12" BorderBrush="#45475a" BorderThickness="1">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel Grid.Column="0" Margin="0,0,15,0">
                                    <TextBlock Text="⚡ Windows / Server KMS38 (Até o ano 2038)" Foreground="#cba6f7" FontSize="15" FontWeight="Bold"/>
                                    <TextBlock Text="Ideal para edições Windows Server e Enterprise LTSC/ESU. Ativa o sistema até 19 de Janeiro de 2038." Foreground="#cdd6f4" FontSize="12" TextWrapping="Wrap" Margin="0,4,0,0"/>
                                </StackPanel>
                                <Button Name="BtnKMS38" Grid.Column="1" Content="ATIVAR KMS38" Width="120" Height="38" Background="#cba6f7" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" Cursor="Hand"/>
                            </Grid>
                        </Border>

                        <Border Background="#313244" CornerRadius="6" Padding="16" Margin="0,0,0,12" BorderBrush="#45475a" BorderThickness="1">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel Grid.Column="0" Margin="0,0,15,0">
                                    <TextBlock Text="🌐 Online KMS (Windows &amp; Office)" Foreground="#89b4fa" FontSize="15" FontWeight="Bold"/>
                                    <TextBlock Text="Ativação por renovação automática (180 dias). Recomendado quando HWID ou Ohook não forem suportados." Foreground="#cdd6f4" FontSize="12" TextWrapping="Wrap" Margin="0,4,0,0"/>
                                </StackPanel>
                                <Button Name="BtnOnlineKMS" Grid.Column="1" Content="ATIVAR KMS" Width="120" Height="38" Background="#89b4fa" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" Cursor="Hand"/>
                            </Grid>
                        </Border>
                    </StackPanel>
                </ScrollViewer>

                <!-- ABA 3: STATUS DA LICENÇA -->
                <Grid Name="PanelStatus" Visibility="Collapsed">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                    </Grid.RowDefinitions>
                    <StackPanel Grid.Row="0" Margin="0,0,0,15">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="Auto"/>
                            </Grid.ColumnDefinitions>
                            <StackPanel Grid.Column="0">
                                <TextBlock Text="Status do Licenciamento" Foreground="#cdd6f4" FontSize="22" FontWeight="SemiBold"/>
                                <TextBlock Text="Verifique o estado atual de ativação do Windows e Microsoft Office." Foreground="#a6adc8" FontSize="12" Margin="0,2,0,0"/>
                            </StackPanel>
                            <Button Name="BtnVerificarStatus" Grid.Column="1" Content="🔍 VERIFICAR AGORA" Height="38" Padding="15,0,15,0" Background="#cba6f7" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" Cursor="Hand"/>
                        </Grid>
                    </StackPanel>

                    <Border Grid.Row="1" Background="#181825" BorderBrush="#45475a" BorderThickness="1" CornerRadius="6">
                        <TextBox Name="TxtStatusConsole" Background="#11111b" Foreground="#a6e3a1" FontFamily="Consolas" FontSize="12" Padding="12" IsReadOnly="True" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Auto" BorderThickness="0" Text="Clique no botão 'VERIFICAR AGORA' acima para consultar a licença do sistema..."/>
                    </Border>
                </Grid>

                <!-- ABA 4: SOLUÇÃO DE PROBLEMAS -->
                <ScrollViewer Name="PanelFerramentas" VerticalScrollBarVisibility="Auto" Visibility="Collapsed">
                    <StackPanel>
                        <TextBlock Text="Ferramentas &amp; Reparo de Licenciamento" Foreground="#cdd6f4" FontSize="22" FontWeight="SemiBold" Margin="0,0,0,5"/>
                        <TextBlock Text="Diagnóstico e correção de falhas do serviço de ativação do Windows (SPP/WMI)." Foreground="#a6adc8" FontSize="12" Margin="0,0,0,20"/>

                        <Border Background="#313244" CornerRadius="6" Padding="16" Margin="0,0,0,12" BorderBrush="#45475a" BorderThickness="1">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel Grid.Column="0" Margin="0,0,15,0">
                                    <TextBlock Text="🔧 Corrigir Serviços de Licenciamento (Fix Licensing)" Foreground="#f38ba8" FontSize="15" FontWeight="Bold"/>
                                    <TextBlock Text="Redefine tokens, limpa arquivos de licença corrompidos e reinicia o Software Protection Service (sppsvc)." Foreground="#cdd6f4" FontSize="12" TextWrapping="Wrap" Margin="0,4,0,0"/>
                                </StackPanel>
                                <Button Name="BtnFixLicensing" Grid.Column="1" Content="CORRIGIR" Width="120" Height="38" Background="#f38ba8" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" Cursor="Hand"/>
                            </Grid>
                        </Border>

                        <Border Background="#313244" CornerRadius="6" Padding="16" Margin="0,0,0,12" BorderBrush="#45475a" BorderThickness="1">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel Grid.Column="0" Margin="0,0,15,0">
                                    <TextBlock Text="🧹 Limpar Servidores e Chaves KMS Residuais" Foreground="#fab387" FontSize="15" FontWeight="Bold"/>
                                    <TextBlock Text="Remove IPs/URLs de servidores KMS antigos configurados no Registro e restabelece a chave KMS padrão." Foreground="#cdd6f4" FontSize="12" TextWrapping="Wrap" Margin="0,4,0,0"/>
                                </StackPanel>
                                <Button Name="BtnClearKMS" Grid.Column="1" Content="LIMPAR KMS" Width="120" Height="38" Background="#fab387" Foreground="#11111b" BorderThickness="0" FontWeight="Bold" Cursor="Hand"/>
                            </Grid>
                        </Border>
                    </StackPanel>
                </ScrollViewer>

            </Grid>
        </Grid>
    </Grid>
</Window>
"@

# ==============================================================================
# LÓGICA DO POWERSHELL PARA INTERFACE
# ==============================================================================
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$Form = [Windows.Markup.XamlReader]::Load($reader)

# --- CONTROLES DE NAVEGAÇÃO ---
$ViewHome             = $Form.FindName("ViewHome")
$ViewWinUtil          = $Form.FindName("ViewWinUtil")
$ViewMAS              = $Form.FindName("ViewMAS")

$BtnOpenWinUtilCard   = $Form.FindName("BtnOpenWinUtilCard")
$BtnOpenMASCard       = $Form.FindName("BtnOpenMASCard")
$BtnExit              = $Form.FindName("BtnExit")
$BtnVoltarHomeWinUtil = $Form.FindName("BtnVoltarHomeWinUtil")
$BtnVoltarHomeMAS     = $Form.FindName("BtnVoltarHomeMAS")

function Show-View ($ViewToShow) {
    if ($ViewToShow -eq "Home") {
        $ViewHome.Visibility    = "Visible"
        $ViewWinUtil.Visibility = "Collapsed"
        $ViewMAS.Visibility     = "Collapsed"
    } elseif ($ViewToShow -eq "WinUtil") {
        $ViewHome.Visibility    = "Collapsed"
        $ViewWinUtil.Visibility = "Visible"
        $ViewMAS.Visibility     = "Collapsed"
    } elseif ($ViewToShow -eq "MAS") {
        $ViewHome.Visibility    = "Collapsed"
        $ViewWinUtil.Visibility = "Collapsed"
        $ViewMAS.Visibility     = "Visible"
    }
}

$BtnOpenWinUtilCard.Add_Click({ Show-View "WinUtil" })
$BtnOpenMASCard.Add_Click({ Show-View "MAS" })
$BtnVoltarHomeWinUtil.Add_Click({ Show-View "Home" })
$BtnVoltarHomeMAS.Add_Click({ Show-View "Home" })
$BtnExit.Add_Click({ $Form.Close() })

# --- WINUTIL - AÇÕES (NORMAL & COM ARQUIVO JSON) ---
$BtnRunWinUtilFast    = $Form.FindName("BtnRunWinUtilFast")
$BtnLaunchWinUtilMain = $Form.FindName("BtnLaunchWinUtilMain")
$BtnChooseJson        = $Form.FindName("BtnChooseJson")
$BtnRunWinUtilJson    = $Form.FindName("BtnRunWinUtilJson")
$TxtJsonPath          = $Form.FindName("TxtJsonPath")

$ActionLaunchWinUtil = {
    Write-Host "Iniciando WinUtil em modo padrão otimizado..." -ForegroundColor Magenta
    Start-Process powershell -ArgumentList "-NoLogo -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command `"irm https://christitus.com/win | iex`""
}

$BtnRunWinUtilFast.Add_Click($ActionLaunchWinUtil)
$BtnLaunchWinUtilMain.Add_Click($ActionLaunchWinUtil)

# Escolher JSON manualmente pelo Explorador do Windows
$BtnChooseJson.Add_Click({
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.Filter = "Arquivo JSON (*.json)|*.json|Todos os arquivos (*.*)|*.*"
    $OpenFileDialog.Title  = "Selecione o arquivo de configuração (.json) do WinUtil"
    
    if ($OpenFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $TxtJsonPath.Text = $OpenFileDialog.FileName
    }
})

# Executar com parâmetro -Config apontando para o JSON selecionado
$BtnRunWinUtilJson.Add_Click({
    $JsonFile = $TxtJsonPath.Text
    if ([string]::IsNullOrWhiteSpace($JsonFile) -or $JsonFile -eq "Nenhum arquivo .json detectado automaticamente.") {
        [System.Windows.MessageBox]::Show("Nenhum arquivo de configuração (.json) selecionado. Por favor, escolha um arquivo manualmente.", "DanUtils", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Warning)
        return
    }

    if (-not (Test-Path $JsonFile)) {
        [System.Windows.MessageBox]::Show("O arquivo selecionado não foi encontrado no caminho especificado.", "DanUtils - Erro", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
        return
    }

    Write-Host "Iniciando WinUtil aplicando configuração JSON: $JsonFile" -ForegroundColor Green
    # Chamada do WinUtil com suporte a arquivo de configuração JSON remoto ou local via -Config
    Start-Process powershell -ArgumentList "-NoLogo -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command `"& { [ScriptBlock]::Create((irm https://christitus.com/win)).Invoke('-Config', '$JsonFile') }`""
})

# --- MAPEAMENTO E CONTROLES DO MAS AIO ---
$TabAtivacao        = $Form.FindName("TabAtivacao")
$TabKMS             = $Form.FindName("TabKMS")
$TabStatus          = $Form.FindName("TabStatus")
$TabFerramentas     = $Form.FindName("TabFerramentas")
$PanelAtivacao      = $Form.FindName("PanelAtivacao")
$PanelKMS           = $Form.FindName("PanelKMS")
$PanelStatus        = $Form.FindName("PanelStatus")
$PanelFerramentas   = $Form.FindName("PanelFerramentas")
$BtnMASCLI          = $Form.FindName("BtnMASCLI")
$BtnHWID            = $Form.FindName("BtnHWID")
$BtnOhook           = $Form.FindName("BtnOhook")
$BtnChangeEdition   = $Form.FindName("BtnChangeEdition")
$BtnKMS38           = $Form.FindName("BtnKMS38")
$BtnOnlineKMS       = $Form.FindName("BtnOnlineKMS")
$BtnVerificarStatus = $Form.FindName("BtnVerificarStatus")
$TxtStatusConsole   = $Form.FindName("TxtStatusConsole")
$BtnFixLicensing    = $Form.FindName("BtnFixLicensing")
$BtnClearKMS        = $Form.FindName("BtnClearKMS")

function Switch-MASTab ($ActivePanel, $ActiveButton) {
    $Panels = @($PanelAtivacao, $PanelKMS, $PanelStatus, $PanelFerramentas)
    $Buttons = @($TabAtivacao, $TabKMS, $TabStatus, $TabFerramentas)

    foreach ($p in $Panels) { $p.Visibility = "Collapsed" }
    foreach ($b in $Buttons) { 
        $b.Background = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#181825") 
        $b.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#a6adc8") 
    }

    $ActivePanel.Visibility = "Visible"
    $ActiveButton.Background = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#313244")
    $ActiveButton.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#cdd6f4")
}

$TabAtivacao.Add_Click({ Switch-MASTab $PanelAtivacao $TabAtivacao })
$TabKMS.Add_Click({ Switch-MASTab $PanelKMS $TabKMS })
$TabStatus.Add_Click({ Switch-MASTab $PanelStatus $TabStatus })
$TabFerramentas.Add_Click({ Switch-MASTab $PanelFerramentas $TabFerramentas })

$BtnMASCLI.Add_Click({ Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://get.activated.win | iex`"" })
$BtnHWID.Add_Click({ Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"& {[ScriptBlock]::Create((irm https://get.activated.win)).Invoke('/HWID')}`"" })
$BtnOhook.Add_Click({ Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"& {[ScriptBlock]::Create((irm https://get.activated.win)).Invoke('/Ohook')}`"" })
$BtnChangeEdition.Add_Click({ Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"& {[ScriptBlock]::Create((irm https://get.activated.win)).Invoke('/ChangeEdition')}`"" })
$BtnKMS38.Add_Click({ Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"& {[ScriptBlock]::Create((irm https://get.activated.win)).Invoke('/KMS38')}`"" })
$BtnOnlineKMS.Add_Click({ Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"& {[ScriptBlock]::Create((irm https://get.activated.win)).Invoke('/KMS-Windows')}`"" })

$BtnVerificarStatus.Add_Click({
    $TxtStatusConsole.Text = "Verificando status de ativação do sistema..."
    $job = {
        $winStatus = cscript //nologo C:\Windows\System32\slmgr.vbs /dli
        $winXpr = cscript //nologo C:\Windows\System32\slmgr.vbs /xpr
        return "=== STATUS DE ATIVAÇÃO DO WINDOWS ===" + [Environment]::NewLine + ($winStatus -join [Environment]::NewLine) + [Environment]::NewLine + [Environment]::NewLine + "=== EXPIRAÇÃO DA LICENÇA ===" + [Environment]::NewLine + ($winXpr -join [Environment]::NewLine)
    }
    $result = PowerShell -NoProfile -Command $job
    $TxtStatusConsole.Text = $result
})

$BtnFixLicensing.Add_Click({ Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"& {[ScriptBlock]::Create((irm https://get.activated.win)).Invoke('/Troubleshoot')}`"" })
$BtnClearKMS.Add_Click({ Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"cscript //nologo C:\Windows\System32\slmgr.vbs /ckms; Write-Host 'Configurações de servidor KMS limpas com sucesso!' -ForegroundColor Green; Start-Sleep -Seconds 3`"" })

# ==============================================================================
# EXIBIR A JANELA PRINCIPAL
# ==============================================================================
$Form.ShowDialog() | Out-Null