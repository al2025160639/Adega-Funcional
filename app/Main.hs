-- | Demonstração formatada do núcleo funcional da Fase 1.
module Main (main) where

import Data
  ( garrafeiraExemplo
  , picanhaGrelhada
  , robaloGrelhado
  , tarteDeAmendoa
  )
import Domain (calcularValorTotal, sugerirItensHarmonizacao)
import Model
  ( ItemGarrafeira (..)
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
  putStrLn ("Valor patrimonial da garrafeira: " ++ formatarMoeda (calcularValorTotal garrafeiraExemplo))
  putStrLn ""
  imprimirHarmonizacao picanhaGrelhada (sugerirItensHarmonizacao picanhaGrelhada garrafeiraExemplo)
  imprimirHarmonizacao robaloGrelhado (sugerirItensHarmonizacao robaloGrelhado garrafeiraExemplo)
  imprimirHarmonizacao tarteDeAmendoa (sugerirItensHarmonizacao tarteDeAmendoa garrafeiraExemplo)

imprimirHarmonizacao :: Prato -> [ItemGarrafeira] -> IO ()
imprimirHarmonizacao prato itens = do
  putStrLn ("Sugestões para " ++ nomePrato prato ++ ":")
  imprimirItens itens
  putStrLn ""

imprimirItens :: [ItemGarrafeira] -> IO ()
imprimirItens [] = putStrLn "  Não foram encontrados vinhos compatíveis."
imprimirItens itens = imprimirItensComStock itens

imprimirItensComStock :: [ItemGarrafeira] -> IO ()
imprimirItensComStock [] = return ()
imprimirItensComStock (ItemGarrafeira vinho quantidade localizacao : restantes) = do
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

descreverRegiao :: Regiao -> String
descreverRegiao Douro = "Douro"
descreverRegiao VinhoVerde = "Vinho Verde"
descreverRegiao Dao = "Dão"
descreverRegiao Alentejo = "Alentejo"
descreverRegiao Bairrada = "Bairrada"
descreverRegiao Lisboa = "Lisboa"
descreverRegiao PeninsulaDeSetubal = "Península de Setúbal"
descreverRegiao Algarve = "Algarve"

descreverTipo :: TipoVinho -> String
descreverTipo Tinto = "Tinto"
descreverTipo Branco = "Branco"
descreverTipo Rose = "Rosé"
descreverTipo Espumante = "Espumante"
descreverTipo (Fortificado Porto) = "Vinho do Porto"
descreverTipo (Fortificado Moscatel) = "Moscatel fortificado"
descreverTipo (Fortificado (OutroFortificado nome)) = nome ++ " fortificado"

formatarQuantidade :: Int -> String
formatarQuantidade 1 = "1 garrafa"
formatarQuantidade quantidade = show quantidade ++ " garrafas"

juntarCastas :: [String] -> String
juntarCastas [] = "Não indicadas"
juntarCastas [casta] = casta
juntarCastas (casta : restantes) = casta ++ ", " ++ juntarCastas restantes

formatarMoeda :: Double -> String
formatarMoeda valor = substituirPontoPorVirgula (printf "%.2f" valor) ++ " €"

formatarTeor :: Double -> String
formatarTeor valor = substituirPontoPorVirgula (printf "%.1f" valor)

substituirPontoPorVirgula :: String -> String
substituirPontoPorVirgula [] = []
substituirPontoPorVirgula ('.' : restantes) = ',' : substituirPontoPorVirgula restantes
substituirPontoPorVirgula (caractere : restantes) =
  caractere : substituirPontoPorVirgula restantes
