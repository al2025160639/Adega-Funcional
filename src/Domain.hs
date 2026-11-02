-- | Operações puras do domínio, implementadas com recursão explícita.
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
  Garrafeira (filtrarItensPorRegiao regiao itens)

filtrarItensPorRegiao :: Regiao -> [ItemGarrafeira] -> [ItemGarrafeira]
filtrarItensPorRegiao _ [] = []
filtrarItensPorRegiao regiao (item@(ItemGarrafeira vinho _ _) : restantes)
  | regiaoVinho vinho == regiao =
      item : filtrarItensPorRegiao regiao restantes
  | otherwise = filtrarItensPorRegiao regiao restantes

-- | Soma o preço unitário multiplicado pela quantidade de cada entrada.
calcularValorTotal :: Garrafeira -> Double
calcularValorTotal (Garrafeira itens) = calcularValorItens itens

calcularValorItens :: [ItemGarrafeira] -> Double
calcularValorItens [] = 0
calcularValorItens (ItemGarrafeira vinho quantidade _ : restantes) =
  precoVinho vinho * fromIntegral quantidade + calcularValorItens restantes

-- | Pesquisa por preço unitário, com limites inclusivos.
-- Se o limite mínimo exceder o máximo, o resultado é uma garrafeira vazia.
pesquisarPorGamaPreco :: Double -> Double -> Garrafeira -> Garrafeira
pesquisarPorGamaPreco minimo maximo (Garrafeira itens)
  | minimo > maximo = Garrafeira []
  | otherwise = Garrafeira (filtrarPorPreco minimo maximo itens)

filtrarPorPreco :: Double -> Double -> [ItemGarrafeira] -> [ItemGarrafeira]
filtrarPorPreco _ _ [] = []
filtrarPorPreco minimo maximo (item@(ItemGarrafeira vinho _ _) : restantes)
  | precoVinho vinho >= minimo && precoVinho vinho <= maximo =
      item : filtrarPorPreco minimo maximo restantes
  | otherwise = filtrarPorPreco minimo maximo restantes

-- | Sugere os vinhos compatíveis que têm pelo menos uma garrafa em stock.
-- Cada entrada é tratada separadamente, preservando a estrutura da adega.
sugerirHarmonizacao :: Prato -> Garrafeira -> [Vinho]
sugerirHarmonizacao prato garrafeira =
  converterItensEmVinhos (sugerirItensHarmonizacao prato garrafeira)

sugerirItensHarmonizacao :: Prato -> Garrafeira -> [ItemGarrafeira]
sugerirItensHarmonizacao prato (Garrafeira itens) =
  selecionarItens prato itens

selecionarItens :: Prato -> [ItemGarrafeira] -> [ItemGarrafeira]
selecionarItens _ [] = []
selecionarItens prato (item@(ItemGarrafeira vinho quantidade _) : restantes)
  | quantidade > 0 && harmoniza prato vinho =
      item : selecionarItens prato restantes
  | otherwise = selecionarItens prato restantes

converterItensEmVinhos :: [ItemGarrafeira] -> [Vinho]
converterItensEmVinhos [] = []
converterItensEmVinhos (ItemGarrafeira vinho _ _ : restantes) =
  vinho : converterItensEmVinhos restantes

-- | Regras iniciais, determinísticas, baseadas no ingrediente e no perfil.
harmoniza :: Prato -> Vinho -> Bool
harmoniza prato vinho
  | ingredientePrincipal prato == Sobremesa =
      temPerfil Doce vinho || ehFortificado vinho
  | ingredientePrincipal prato == CarneVermelha =
      tipoVinho vinho == Tinto
        && (temPerfil Encorpado vinho || temPerfil Tanico vinho)
  | ingredientePrincipal prato == Peixe
      || ingredientePrincipal prato == Marisco =
      adequadoParaPeixe prato vinho
  | pratoExigente prato =
      temPerfil Encorpado vinho || temPerfil Acido vinho
  | ingredientePrincipal prato == Queijo =
      temPerfil Encorpado vinho
        || temPerfil Acido vinho
        || temPerfil Doce vinho
        || ehFortificado vinho
  | otherwise =
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
pratoExigente prato
  | nivelGordura prato >= 4 = True
  | intensidadeSabor prato == Intensa = True
  | otherwise = False

temPerfil :: PerfilSabor -> Vinho -> Bool
temPerfil procurado vinho = procurarPerfil procurado (perfisSabor vinho)

procurarPerfil :: PerfilSabor -> [PerfilSabor] -> Bool
procurarPerfil _ [] = False
procurarPerfil procurado (atual : restantes)
  | procurado == atual = True
  | otherwise = procurarPerfil procurado restantes

ehFortificado :: Vinho -> Bool
ehFortificado vinho =
  case tipoVinho vinho of
    Fortificado _ -> True
    _ -> False
