#!/usr/bin/env bash
set -euo pipefail
# Ejecutar desde la carpeta local del repositorio backend ya clonado o creada vacía.
git init
git branch -M main
go mod init github.com/e-scavo/mi-ipred-phone-backend
printf '# mi-ipred-phone-backend\n' > README.md
git add .
git commit -m 'chore: initialize Go backend repository'
git remote add origin https://github.com/e-scavo/mi-ipred-phone-backend.git
git push -u origin main
