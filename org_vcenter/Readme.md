Criando pastas no vCenter com Terraform

Recentemente nosso time recebeu uma tarefa, organizar logicamente a estrutura de nossas máquinas virtuais existente no vCenter. Após discutirmos um pouco, foi decidido que iríamos seguir conforme já estávamos fazendo com os novos ambientes, que é:

1 - Criar uma pasta com o nome do projeto/serviço;
2 - Dentro da pasta projeto, é criado outras três subpastas nomeadas de produção, desenvolvimento e homologação;
3 - Ficou convencionado que utilizaríamos letras minúsculas e sem acentos.

Com o objetivo definido hora de começarmos a executar. 

Logo de inicio encontramos a primeira dificuldade, só no levantamento inicial tivemos mais de vinte ambientes identificados. Se cada ambiente tem quatro pastas (1 pai e 3 filhos) teríamos que criar mais de oitenta pastas, não seria na produtivo e inteligente criarmos na mão.

Já utilizamos o Terraform para criar este mesmo tipo de estrutura, quando subimos um novo ambiente, então por que não continuar usando essa abordagem?

Exemplo do código utilizado durante a criação dos ambientes atuais.

resource "vsphere_folder" "parent" {
  path          = "${var.parent_folder}"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_folder" "child" {
  path          = "${vsphere_folder.parent.path}/${var.child_folder}"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"

}

Resolvido um problema mas criamos outro, como montar a estrutura do Terraform? 

1 - O primeiro passo foi utilizar um module para reutilizar o código. 
2 - Segundo passo foi o problema, precisamos chamar esse module o que seria algo assim:

module "folder" {
  source        = "../../modules/folder"
  parent_folder = "ambiente1"
}    

Mas temos mais de vinte ambientes para criar, voltamos ao problema inicial. 

Utilizamos como alternativa o bom e velho Shell (no caso PowerShell ;) ) para criar a estrutura de arquivos e pastas que precisávamos, através de uma lista e um loop.

New-Item -Path $pathfolder -ItemType Directory

Add-Content -Path $pathfile -Value $valuefolder -Encoding String

Add-Content -Path $path\main.tf -Value $valuenamefolder


Basicamente com ele criamos as pastas de cada ambiente, o conteúdo de cada chamada do module e um arquivo main para chamar todos eles. Ficando algo do tipo:

Com essa estrutura criada basta iniciar o Terraform e aplicar as configurações, em poucos segundos a estrutura de pastas foi criada no vCenter.

Talvez existe um jeito mais fácil ou mais elegante de fazer, mas espero que ajude de algum jeito ou de outro.
