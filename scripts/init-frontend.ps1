init# Ejecutar en una carpeta VACIA destinada al frontend, desde Windows con Flutter instalado.
fvm flutter create --project-name=mi_ipred_phone --platforms=android,windows,ios --org ar.com.ipred .
if ($LASTEXITCODE -ne 0) { throw 'flutter create failed' }
git init
git branch -M main
git add .
git commit -m 'chore: initialize Flutter app'
git remote add origin https://github.com/e-scavo/mi-ipred-phone.git
git push -u origin main
