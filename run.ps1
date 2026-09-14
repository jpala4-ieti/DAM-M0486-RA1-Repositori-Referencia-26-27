# run.ps1 — executa una classe amb main del projecte.
# Ús: .\run.ps1 com.project.Classe [arguments del programa...]
#   .\run.ps1 com.project.PR110ReadFile
#   .\run.ps1 com.project.PR112cat data/GestioTasques.java
#   .\run.ps1 com.project.PR115cp data/origen.txt data/desti.txt

Set-Location $PSScriptRoot

$env:MAVEN_OPTS="--add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.nio=ALL-UNNAMED --add-opens java.base/java.util=ALL-UNNAMED"

if ($args.Count -lt 1) {
    Write-Host "Ús: .\run.ps1 <classe.principal> [arguments...]"
    exit 1
}

$mainClass = $args[0]
$execArgs = if ($args.Count -gt 1) { ($args[1..($args.Count - 1)]) -join " " } else { "" }

Write-Host "Main Class: $mainClass"
Write-Host "Arguments:  $execArgs"

mvn clean test-compile exec:java -PrunMain "-Dexec.mainClass=$mainClass" "-Dexec.args=$execArgs"
