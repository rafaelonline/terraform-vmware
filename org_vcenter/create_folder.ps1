#Importe a lista de pastas a serem criadas, descritas no arquivo ambiente.csv
$Folders = Import-Csv "c:\org_vcenter\ambiente.csv" # Substitua pelo seu local 
 
Foreach($Folder in $Folders){
    $namefolder     = $Folder.NomeDaPasta
    $path = "c:\org_vcenter\org\>" #substitua pelo seu local
    $pathfolder = "$path\$namefolder"
    $pathfile = "$path\$namefolder\$namefolder.tf"
    $valuefolder = "module `"folder`" {`nsource = `"../../modules/folder`" `n`parent_folder = `"$namefolder`"`n}"
    $valuenamefolder = "module `"$namefolder`" {`nsource = `"./$namefolder`"`n}"
    
    # Criando as pastas dos ambientes
    New-Item -Path $pathfolder -ItemType Directory
    #
    # Criando o arquivo para chamar o modulo folder e informar o nome do ambiente na variavel
    Add-Content -Path $pathfile -Value $valuefolder -Encoding String
    #
    # Criando o arquivo main para chamar para chamar a criação de todos os ambientes
    Add-Content -Path $path\main.tf -Value $valuenamefolder
    #
}