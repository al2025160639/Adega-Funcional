-- | Dados pequenos e fixos para demonstrar o modelo e as funções do domínio.
module Data where

import Model

vinhoBarcaVelha :: Vinho
vinhoBarcaVelha =
  Vinho
    { nomeVinho = "Barca Velha"
    , produtorVinho = "Casa Ferreirinha"
    , anoColheita = 2011
    , regiaoVinho = Douro
    , tipoVinho = Tinto
    , teorAlcoolico = 14.0
    , precoVinho = 850.0
    , castasVinho = ["Touriga Nacional", "Touriga Franca", "Tinta Roriz"]
    , perfisSabor = [Encorpado, Tanico, Frutado]
    }

vinhoAlvarinho :: Vinho
vinhoAlvarinho =
  Vinho
    { nomeVinho = "Alvarinho"
    , produtorVinho = "Quinta de Soalheiro"
    , anoColheita = 2023
    , regiaoVinho = VinhoVerde
    , tipoVinho = Branco
    , teorAlcoolico = 12.5
    , precoVinho = 18.5
    , castasVinho = ["Alvarinho"]
    , perfisSabor = [Leve, Acido, Frutado]
    }

vinhoPortoVintage :: Vinho
vinhoPortoVintage =
  Vinho
    { nomeVinho = "Porto Vintage"
    , produtorVinho = "Quinta do Noval"
    , anoColheita = 2017
    , regiaoVinho = Douro
    , tipoVinho = Fortificado Porto
    , teorAlcoolico = 19.5
    , precoVinho = 120.0
    , castasVinho = ["Touriga Nacional", "Touriga Franca", "Sousao"]
    , perfisSabor = [Encorpado, Tanico, Doce, Frutado]
    }

vinhoEspumanteBairrada :: Vinho
vinhoEspumanteBairrada =
  Vinho
    { nomeVinho = "Espumante Bairrada Reserva"
    , produtorVinho = "Adega de Cantanhede"
    , anoColheita = 2019
    , regiaoVinho = Bairrada
    , tipoVinho = Espumante
    , teorAlcoolico = 12.0
    , precoVinho = 22.0
    , castasVinho = ["Baga", "Bical"]
    , perfisSabor = [Leve, Acido, Frutado]
    }

vinhoEsporao :: Vinho
vinhoEsporao =
  Vinho
    { nomeVinho = "Esporão Reserva"
    , produtorVinho = "Herdade do Esporão"
    , anoColheita = 2021
    , regiaoVinho = Alentejo
    , tipoVinho = Tinto
    , teorAlcoolico = 14.5
    , precoVinho = 29.0
    , castasVinho = ["Alicante Bouschet", "Aragonez", "Trincadeira"]
    , perfisSabor = [Encorpado, Tanico, Frutado]
    }

vinhoRoseDao :: Vinho
vinhoRoseDao =
  Vinho
    { nomeVinho = "Rosé do Dão"
    , produtorVinho = "Quinta de Saes"
    , anoColheita = 2024
    , regiaoVinho = Dao
    , tipoVinho = Rose
    , teorAlcoolico = 12.0
    , precoVinho = 13.5
    , castasVinho = ["Touriga Nacional"]
    , perfisSabor = [Leve, Frutado]
    }

vinhosExemplo :: [Vinho]
vinhosExemplo =
  [ vinhoBarcaVelha
  , vinhoAlvarinho
  , vinhoPortoVintage
  , vinhoEspumanteBairrada
  , vinhoEsporao
  , vinhoRoseDao
  ]

picanhaGrelhada :: Prato
picanhaGrelhada =
  Prato
    { nomePrato = "Picanha grelhada"
    , ingredientePrincipal = CarneVermelha
    , nivelGordura = 5
    , intensidadeSabor = Intensa
    }

robaloGrelhado :: Prato
robaloGrelhado =
  Prato
    { nomePrato = "Robalo grelhado"
    , ingredientePrincipal = Peixe
    , nivelGordura = 2
    , intensidadeSabor = Moderada
    }

tarteDeAmendoa :: Prato
tarteDeAmendoa =
  Prato
    { nomePrato = "Tarte de amêndoa"
    , ingredientePrincipal = Sobremesa
    , nivelGordura = 3
    , intensidadeSabor = Moderada
    }

garrafeiraExemplo :: Garrafeira
garrafeiraExemplo =
  Garrafeira
    [ ItemGarrafeira vinhoBarcaVelha 2 "Prateleira A2"
    , ItemGarrafeira vinhoAlvarinho 6 "Prateleira B1"
    , ItemGarrafeira vinhoPortoVintage 3 "Cave C1"
    , ItemGarrafeira vinhoEspumanteBairrada 4 "Prateleira B2"
    , ItemGarrafeira vinhoEsporao 5 "Prateleira A3"
    , ItemGarrafeira vinhoRoseDao 3 "Prateleira B3"
    ]
