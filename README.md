# Simulador de Adega e Curadoria de Vinhos

## Objetivo

O projeto modela a garrafeira de um colecionador ou de uma adega e sugere
harmonizações entre vinhos disponíveis e pratos. Esta entrega implementa a
**Fase 1 — Modelação e núcleo funcional**: os tipos fundamentais, dados de
demonstração e primeiras operações puras sobre o domínio.

## Modelo de dados

O módulo `Model` define as regiões, categorias e perfis de sabor dos vinhos,
ingredientes e intensidades dos pratos. Um `Vinho` guarda produtor, colheita,
região, tipo, álcool, preço por garrafa, castas e uma lista de perfis sensoriais.
A lista permite representar, por exemplo, um vinho simultaneamente leve, ácido
e frutado. `Fortificado` contém um subtipo (`Porto`, `Moscatel` ou outro estilo).

Um `Prato` regista o ingrediente principal, gordura numa escala de 1 a 5 e
intensidade. Cada `ItemGarrafeira` associa um vinho à quantidade e localização;
`Garrafeira` agrega esses itens numa lista.

As **castas** são as variedades de uva usadas para produzir o vinho, como
Touriga Nacional, Alvarinho ou Baga. Não são o mesmo que o tipo de vinho:
`Tinto`, `Branco`, `Rosé` e `Espumante` descrevem o estilo do vinho. A aplicação
mostra as castas com o rótulo “Castas (variedades de uva)”.

## Núcleo funcional

O módulo `Domain` mantém as operações puras e usa pattern matching, guards e
recursão explícita nas travessias das listas:

- `adicionarVinho` insere uma entrada no início da garrafeira. Entradas repetidas
  são permitidas para representar lotes em localizações diferentes.
- `filtrarPorRegiao` seleciona entradas pela região do vinho.
- `calcularValorTotal` soma preço por garrafa vezes quantidade.
- `pesquisarPorGamaPreco` filtra pelo preço unitário, com limites inclusivos; se
  o mínimo for maior do que o máximo, devolve uma garrafeira vazia.
- `sugerirHarmonizacao` aplica regras iniciais: carne vermelha favorece tintos
  encorpados ou tânicos; peixe e marisco favorecem brancos, espumantes ou vinhos
  leves; pratos gordurosos/intensos pedem acidez ou corpo; sobremesas favorecem
  vinhos doces ou fortificados. Só são sugeridas entradas com quantidade
  positiva.
- `sugerirItensHarmonizacao` devolve os próprios itens da garrafeira, para que a
  demonstração também possa mostrar a quantidade em stock e a localização de
  cada vinho sugerido.

As regras são uma primeira aproximação didática e determinística, não uma
avaliação enológica completa. A validação de intervalos e quantidades, o
tratamento de erros com `Maybe`/`Either`, os pipelines com funções de ordem
superior e a interação alargada por IO podem ser desenvolvidos nas fases
seguintes, conforme a progressão prevista no framework da unidade curricular.

## Estrutura

```text
adega-funcional/
├── adega-funcional.code-workspace
├── adega-funcional.cabal
├── cabal.project
├── README.md
├── app/
│   ├── Main.hs
│   └── Main2.hs
└── src/
    ├── Data.hs
    ├── Domain.hs
    └── Model.hs
```

`Model` descreve os tipos; `Domain` contém as regras puras; `Data` fornece seis
vinhos, três pratos e uma garrafeira de exemplo; `app/Main2.hs` apresenta a
demonstração completa no terminal. O Cabal usa esse ficheiro como ponto de
entrada. `app/Main.hs` permanece no projeto, mas não é usado pelo executável.
O ficheiro `.code-workspace` abre a pasta inteira no VS Code, e o manifesto
Cabal identifica os módulos e o executável.

## Compilar e executar

É necessário ter o compilador GHC instalado. A partir da pasta
`adega-funcional`, pode abrir a demonstração no GHCi:

```text
ghci -isrc app/Main2.hs
```

No prompt do GHCi:

```haskell
main
:module + Model Domain Data
calcularValorTotal garrafeiraExemplo
filtrarPorRegiao Douro garrafeiraExemplo
pesquisarPorGamaPreco 10 100 garrafeiraExemplo
sugerirHarmonizacao picanhaGrelhada garrafeiraExemplo
sugerirItensHarmonizacao picanhaGrelhada garrafeiraExemplo
```

No terminal integrado do VS Code, execute os comandos seguintes na mesma sessão
do PowerShell para apresentar corretamente os acentos. Não use o botão genérico
"Run Code", pois ele pode executar o programa num painel com outra codificação.

No PowerShell do Windows, gere e execute o programa assim:

```text
chcp 65001
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
cabal run
```

Em Linux ou macOS, basta executar `cabal run`.

Também é possível compilar diretamente com GHC:

```text
ghc -isrc app/Main2.hs -o adega
```

No PowerShell, execute `.\adega.exe`; em Linux ou macOS, execute `./adega`.

## Dados de demonstração

O módulo `Data` inclui exemplos inspirados em estilos e regiões portuguesas,
incluindo Barca Velha (Douro), Alvarinho (Vinho Verde), Porto Vintage,
espumante da Bairrada, tinto do Alentejo e rosé do Dão. São dados didáticos
fixos, não uma lista comercial.

O framework da unidade curricular prevê o uso de Git desde o início do projeto;
o grupo deve manter o histórico de desenvolvimento no repositório que utilizar
para a entrega.
