-- | Demonstração formatada do núcleo funcional da Fase 1.
module Main (main) where

import Data
  ( garrafeiraExemplo
  , vinhoAlvarinho
  , picanhaGrelhada
  , robaloGrelhado
  , tarteDeAmendoa
  )

import Domain
  ( adicionarVinho
  , filtrarPorRegiao
  , calcularValorTotal
  , pesquisarPorGamaPreco
  , sugerirItensHarmonizacao
  )

import Model
  ( Garrafeira (..)
  , ItemGarrafeira (..)
  , Prato (..)
  , Regiao (..)
  , TipoFortificado (..)
  , TipoVinho (..)
  , Vinho (..)
  )

import System.IO (hSetEncoding, stdout, utf8)
import Text.Printf (printf)


main :: IO ()
main = do
  hSetEncoding stdout utf8

  putStrLn "Simulador de Adega e Curadoria de Vinhos"
  putStrLn "Demonstração da Fase 1"
  putStrLn "========================================"

  -- Calcular o valor total da garrafeira
  putStrLn
    ("Valor patrimonial da garrafeira: "
      ++ formatarMoeda (calcularValorTotal garrafeiraExemplo))

  putStrLn ""

  -- Sugestões de harmonização
  imprimirHarmonizacao
    picanhaGrelhada
    (sugerirItensHarmonizacao picanhaGrelhada garrafeiraExemplo)

  imprimirHarmonizacao
    robaloGrelhado
    (sugerirItensHarmonizacao robaloGrelhado garrafeiraExemplo)

  imprimirHarmonizacao
    tarteDeAmendoa
    (sugerirItensHarmonizacao tarteDeAmendoa garrafeiraExemplo)

  -- DEMONSTRAÇÃO DAS RESTANTES FUNÇÕES DO DOMÍNIO

  putStrLn "========================================"
  putStrLn "DEMONSTRAÇÃO DAS FUNÇÕES DO DOMÍNIO"
  putStrLn "========================================"


  -- 1. Filtrar vinhos por região
  putStrLn ""
  putStrLn "1. VINHOS DA REGIÃO DO DOURO"
  putStrLn "----------------------------------------"

  let vinhosDouro =
        filtrarPorRegiao Douro garrafeiraExemplo

  imprimirItens (itensGarrafeira vinhosDouro)

  putStrLn ""


  -- 2. Pesquisar vinhos por intervalo de preços
  putStrLn "2. VINHOS ENTRE 10 E 30 EUROS"
  putStrLn "----------------------------------------"

  let vinhosPreco =
        pesquisarPorGamaPreco 10 30 garrafeiraExemplo

  imprimirItens (itensGarrafeira vinhosPreco)

  putStrLn ""


  -- 3. Adicionar vinho à garrafeira
  putStrLn "3. ADICIONAR VINHO À GARRAFEIRA"
  putStrLn "----------------------------------------"

  let novoItem =
        ItemGarrafeira vinhoAlvarinho 2 "Prateleira D1"

  let novaGarrafeira =
        adicionarVinho novoItem garrafeiraExemplo

  putStrLn "Nova entrada adicionada:"
  putStrLn ""

  imprimirItens [novoItem]

  putStrLn
    ("Valor anterior da garrafeira: "
      ++ formatarMoeda (calcularValorTotal garrafeiraExemplo))

  putStrLn
    ("Valor atualizado da garrafeira: "
      ++ formatarMoeda (calcularValorTotal novaGarrafeira))

  putStrLn ""


  -- CASOS LIMITE
  

  putStrLn "========================================"
  putStrLn "DEMONSTRAÇÃO DE CASOS LIMITE"
  putStrLn "========================================"


  -- Caso 1: Garrafeira vazia
  putStrLn ""
  putStrLn "1. GARRAFEIRA VAZIA"
  putStrLn "----------------------------------------"

  let garrafeiraVazia = Garrafeira []

  putStrLn
    ("Valor total: "
      ++ formatarMoeda (calcularValorTotal garrafeiraVazia))

  putStrLn ""


  -- Caso 2: Pesquisa sem resultados
  putStrLn "2. PESQUISA SEM RESULTADOS"
  putStrLn "----------------------------------------"

  let semResultados =
        filtrarPorRegiao Algarve garrafeiraExemplo

  imprimirItens (itensGarrafeira semResultados)

  putStrLn ""


  -- Caso 3: Intervalo de preços inválido
  putStrLn "3. INTERVALO DE PREÇOS INVÁLIDO"
  putStrLn "----------------------------------------"

  let intervaloInvalido =
        pesquisarPorGamaPreco 100 10 garrafeiraExemplo

  imprimirItens (itensGarrafeira intervaloInvalido)

  putStrLn ""

  putStrLn "========================================"
  putStrLn "FIM DA DEMONSTRAÇÃO DA FASE 1"
  putStrLn "========================================"


-- FUNÇÕES DE APRESENTAÇÃO

imprimirHarmonizacao :: Prato -> [ItemGarrafeira] -> IO ()
imprimirHarmonizacao prato itens = do
  putStrLn ("Sugestões para " ++ nomePrato prato ++ ":")
  imprimirItens itens
  putStrLn ""


imprimirItens :: [ItemGarrafeira] -> IO ()
imprimirItens [] =
  putStrLn "  Não foram encontrados vinhos compatíveis."

imprimirItens itens =
  imprimirItensComStock itens


imprimirItensComStock :: [ItemGarrafeira] -> IO ()
imprimirItensComStock [] = return ()

imprimirItensComStock
  (ItemGarrafeira vinho quantidade localizacao : restantes) = do

  putStrLn ("  - " ++ nomeVinho vinho)

  putStrLn ("    Produtor: " ++ produtorVinho vinho)

  putStrLn
    ( "    Colheita: " ++ show (anoColheita vinho)
        ++ " | Região: " ++ descreverRegiao (regiaoVinho vinho)
    )

  putStrLn
    ( "    Tipo: " ++ descreverTipo (tipoVinho vinho)
        ++ " | Teor alcoólico: " ++ formatarTeor (teorAlcoolico vinho) ++ "%"
        ++ " | Preço: " ++ formatarMoeda (precoVinho vinho) ++ "/garrafa"
    )

  putStrLn
    ( "    Em stock: " ++ formatarQuantidade quantidade
        ++ " | Localização: " ++ localizacao
    )

  putStrLn ("    Castas: " ++ juntarCastas (castasVinho vinho))

  putStrLn ""

  imprimirItensComStock restantes


-- DESCRIÇÃO DAS REGIÕES

descreverRegiao :: Regiao -> String
descreverRegiao Douro = "Douro"
descreverRegiao VinhoVerde = "Vinho Verde"
descreverRegiao Dao = "Dão"
descreverRegiao Alentejo = "Alentejo"
descreverRegiao Bairrada = "Bairrada"
descreverRegiao Lisboa = "Lisboa"
descreverRegiao PeninsulaDeSetubal = "Península de Setúbal"
descreverRegiao Algarve = "Algarve"


-- DESCRIÇÃO DOS TIPOS DE VINHO

descreverTipo :: TipoVinho -> String
descreverTipo Tinto = "Tinto"
descreverTipo Branco = "Branco"
descreverTipo Rose = "Rosé"
descreverTipo Espumante = "Espumante"
descreverTipo (Fortificado Porto) = "Vinho do Porto"
descreverTipo (Fortificado Moscatel) = "Moscatel fortificado"
descreverTipo (Fortificado (OutroFortificado nome)) =
  nome ++ " fortificado"


-- FORMATAÇÃO DOS DADOS

formatarQuantidade :: Int -> String
formatarQuantidade 1 = "1 garrafa"
formatarQuantidade quantidade =
  show quantidade ++ " garrafas"


juntarCastas :: [String] -> String
juntarCastas [] = "Não indicadas"
juntarCastas [casta] = casta
juntarCastas (casta : restantes) =
  casta ++ ", " ++ juntarCastas restantes


formatarMoeda :: Double -> String
formatarMoeda valor =
  substituirPontoPorVirgula (printf "%.2f" valor) ++ " €"


formatarTeor :: Double -> String
formatarTeor valor =
  substituirPontoPorVirgula (printf "%.1f" valor)


substituirPontoPorVirgula :: String -> String
substituirPontoPorVirgula [] = []

substituirPontoPorVirgula ('.' : restantes) =
  ',' : substituirPontoPorVirgula restantes

substituirPontoPorVirgula (caractere : restantes) =
  caractere : substituirPontoPorVirgula restantes