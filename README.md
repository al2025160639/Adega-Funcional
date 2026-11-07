# Simulador de adega e harmonização de vinhos

Este projeto demonstra uma adega com alguns vinhos e sugere quais podem
combinar com diferentes pratos. É um projeto didático: os dados são exemplos
fixos e as sugestões seguem regras simples, não substituindo a opinião de um
especialista.

## O que o programa faz

Ao ser executado, o programa mostra:

- o valor total dos vinhos da adega;
- sugestões de vinhos para alguns pratos;
- os vinhos de uma região escolhida;
- os vinhos dentro de uma faixa de preço;
- o resultado de adicionar uma nova garrafa.

As sugestões consideram o tipo de prato, o perfil do vinho e se há garrafas em
stock.

## O que precisa de instalar

É necessário ter o **GHC** e o **Cabal**, ferramentas para compilar e executar
programas escritos em Haskell. Se o comando `cabal` não for reconhecido no
terminal, instale o GHC e o Cabal e abra um terminal novo.

## Como executar no Windows

1. Abra a pasta do projeto no VS Code.
2. Abra o terminal integrado pelo menu **Terminal > Novo Terminal**.
3. Execute estes comandos no PowerShell:

```powershell
chcp 65001
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
cabal run
```

Os dois primeiros comandos configuram a exibição de acentos no terminal. O
comando `cabal run` compila e executa o programa. Se estiver noutra pasta,
entre primeiro na pasta do projeto:

```powershell
cd "C:\Users\emman\Downloads\PF\Adega-Funcional"
```

Use o terminal integrado em vez do botão genérico **Run Code**, que pode usar
uma codificação diferente.

## Como executar no Linux ou macOS

Abra um terminal na pasta do projeto e execute:

```sh
cabal run
```

## Usar o GHCi (opcional)

O GHCi permite carregar o programa e experimentar as funções manualmente. Na
pasta do projeto, execute:

```text
ghci -isrc app/Main2.hs
```

Quando aparecer o prompt `ghci>`, pode iniciar a demonstração com:

```haskell
main
```

Também pode experimentar funções do projeto:

```haskell
:module + Model Domain Data
calcularValorTotal garrafeiraExemplo
filtrarPorRegiao Douro garrafeiraExemplo
pesquisarPorGamaPreco 10 100 garrafeiraExemplo
sugerirHarmonizacao picanhaGrelhada garrafeiraExemplo
```

Para sair do GHCi, escreva `:quit`.

## Como o projeto está organizado

```text
app/
  Main.hs       outro ponto de entrada, não usado pelo Cabal
  Main2.hs      programa de demonstração executado pelo Cabal
src/
  Model.hs      tipos de dados, como vinho, prato e adega
  Data.hs       vinhos, pratos e adega de exemplo
  Domain.hs     operações e regras de harmonização
```

O ficheiro `adega-funcional.cabal` configura o executável. O ponto de entrada
usado pelo comando `cabal run` é `app/Main2.hs`.

### Alguns termos

- **Casta**: variedade de uva, como Alvarinho ou Baga.
- **Tipo de vinho**: estilo, como tinto, branco, rosé ou espumante.
- **Perfil de sabor**: característica do vinho, como leve, ácido ou frutado.
- **Stock**: quantidade de garrafas disponível na adega.

## Sobre as regras e os dados

As regras são simples e determinísticas. Por exemplo, carnes vermelhas podem
ser combinadas com tintos encorpados ou tânicos; peixe e marisco podem ser
combinados com brancos, espumantes ou vinhos leves. As sugestões variam também
conforme a gordura e a intensidade do prato. Só são recomendados vinhos com
quantidade em stock superior a zero.

Os dados incluem exemplos inspirados em vinhos e regiões portuguesas. São
valores fixos para demonstração, não uma lista comercial nem dados atualizados
de preços.
