-- | Operações puras do domínio sobre os tipos do modelo.
module Domain
  ( adicionarVinho
  , filtrarPorRegiao
  , calcularValorTotal
  , pesquisarPorGamaPreco
  , sugerirHarmonizacao
  , sugerirItensHarmonizacao
  ) where

import Model

-- | Insere uma nova entrada no início da lista da garrafeira.
-- Entradas repetidas são permitidas, por exemplo, para separar localizações.
adicionarVinho :: ItemGarrafeira -> Garrafeira -> Garrafeira
adicionarVinho novo (Garrafeira itens) = Garrafeira (novo : itens)

-- | Mantém apenas as entradas cujo vinho pertence à região indicada.
filtrarPorRegiao :: Regiao -> Garrafeira -> Garrafeira
filtrarPorRegiao regiao (Garrafeira itens) =
  Garrafeira (filter ((== regiao) . regiaoVinho . vinhoItem) itens)

-- | Soma o preço unitário multiplicado pela quantidade de cada entrada.
calcularValorTotal :: Garrafeira -> Double
calcularValorTotal (Garrafeira itens) = foldr valorItem 0 itens

valorItem :: ItemGarrafeira -> Double -> Double
valorItem (ItemGarrafeira vinho quantidade _) total =
  precoVinho vinho * fromIntegral quantidade + total

-- | Pesquisa por preço unitário, com limites inclusivos.
-- Se o limite mínimo exceder o máximo, o resultado é uma garrafeira vazia.
pesquisarPorGamaPreco :: Double -> Double -> Garrafeira -> Garrafeira
pesquisarPorGamaPreco minimo maximo (Garrafeira itens)
  | minimo > maximo = Garrafeira []
  | otherwise =
      Garrafeira (filter (precoNaGama minimo maximo) itens)

precoNaGama :: Double -> Double -> ItemGarrafeira -> Bool
precoNaGama minimo maximo item =
  let preco = precoVinho (vinhoItem item)
   in preco >= minimo && preco <= maximo

-- | Sugere os vinhos compatíveis que têm pelo menos uma garrafa em stock.
-- Cada entrada é tratada separadamente, preservando a estrutura da adega.
sugerirHarmonizacao :: Prato -> Garrafeira -> [Vinho]
sugerirHarmonizacao prato garrafeira =
  converterItensEmVinhos (sugerirItensHarmonizacao prato garrafeira)

sugerirItensHarmonizacao :: Prato -> Garrafeira -> [ItemGarrafeira]
sugerirItensHarmonizacao prato (Garrafeira itens) =
  filter
    (\item -> quantidadeItem item > 0 && harmoniza prato (vinhoItem item))
    itens

converterItensEmVinhos :: [ItemGarrafeira] -> [Vinho]
converterItensEmVinhos = map vinhoItem

-- | Regras iniciais, determinísticas, baseadas no ingrediente e no perfil.
harmoniza :: Prato -> Vinho -> Bool
harmoniza prato vinho =
  case ingredientePrincipal prato of
    Sobremesa ->
      temPerfil Doce vinho || ehFortificado vinho
    CarneVermelha ->
      tipoVinho vinho == Tinto
        && (temPerfil Encorpado vinho || temPerfil Tanico vinho)
    Peixe ->
      adequadoParaPeixe prato vinho
    Marisco ->
      adequadoParaPeixe prato vinho
    Queijo
      | pratoExigente prato ->
          temPerfil Encorpado vinho || temPerfil Acido vinho
      | otherwise ->
          temPerfil Encorpado vinho
            || temPerfil Acido vinho
            || temPerfil Doce vinho
            || ehFortificado vinho
    _
      | pratoExigente prato ->
          temPerfil Encorpado vinho || temPerfil Acido vinho
      | otherwise ->
          temPerfil Leve vinho || temPerfil Frutado vinho || temPerfil Acido vinho

-- Peixe e marisco pedem um vinho branco/espumante ou um perfil leve.
-- Quando o prato é gorduroso ou intenso, acrescenta-se a exigência de acidez.
adequadoParaPeixe :: Prato -> Vinho -> Bool
adequadoParaPeixe prato vinho
  | tipoVinho vinho == Branco
      || tipoVinho vinho == Espumante
      || temPerfil Leve vinho =
      not (pratoExigente prato) || temPerfil Acido vinho
  | otherwise = False

pratoExigente :: Prato -> Bool
pratoExigente prato =
  nivelGordura prato >= 4 || intensidadeSabor prato == Intensa

temPerfil :: PerfilSabor -> Vinho -> Bool
temPerfil procurado vinho = procurado `elem` perfisSabor vinho

ehFortificado :: Vinho -> Bool
ehFortificado vinho =
  case tipoVinho vinho of
    Fortificado _ -> True
    _ -> False
