;; PATH Settings
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq exec-path
      (append exec-path
              '(
                "/usr/local/bin"
                "/usr/bin"
                "C:\\Program Files\\nodejs"
                "D:\\prog\\Git\\bin"
                "C:\\Users\\basu\\AppData\\Roaming\\npm\\"
                ))
      )
