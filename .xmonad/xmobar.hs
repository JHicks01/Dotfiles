Config { font = "xft:Iosevka:size=12:bold:antialias=true,FontAwesome:size=12"
         , overrideRedirect = False
         , border = BottomB
         , borderColor = "black"
         , bgColor = "#282c34"
         , fgColor = "#bbc2cf"
         , commands = [Run Memory ["-t","<usedratio>%"] 10
                      ,Run Cpu ["-t", "<total>%", "-L","3","-H","50"] 10
                      ,Run CoreTemp ["-t", "<core0>°C"] 50
                      ,Run Network "enp4s0" ["-t", "<fc=#c678dd></fc> <rx>KB/s | <fc=#dcaeea></fc> <tx>KB/s"] 20 
                      ,Run Com "zsh" [ "-c", "~/.scripts/date.sh"] "date" 10
                      ,Run Com "zsh" [ "-c", "~/.scripts/time.sh"] "time" 10
                      ,Run StdinReader
                      ]
         , sepChar = "%"
         , alignSep = "}{"
         , template = "%StdinReader% }{ <fc=#98be65>Mem:</fc> %memory% | <fc=#51afef>CPU:</fc> %cpu% | <fc=#a9a1e1>CPU Temp:</fc> %coretemp% | %enp4s0% | <fc=#98be65>%date%</fc> | <fc=#51afef>%time%</fc> "
         }
