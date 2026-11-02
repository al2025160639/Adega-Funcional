-- | Tipos que descrevem o domínio do simulador de adega.
module Model
  ( Regiao (..)
  , TipoFortificado (..)
  , TipoVinho (..)
  , PerfilSabor (..)
  , Ingrediente (..)
  , Intensidade (..)
  , Vinho (..)
  , Prato (..)
  , ItemGarrafeira (..)
  , Garrafeira (..)
  ) where

-- | Regiões vitivinícolas consideradas nesta versão inicial.
data Regiao
  = Douro
  | VinhoVerde
  | Dao
  | Alentejo
  | Bairrada
  | Lisboa
  | PeninsulaDeSetubal
  | Algarve
  deriving (Eq, Show)

-- | Subtipo usado para distinguir estilos de vinho fortificado.
data TipoFortificado
  = Porto
  | Moscatel
  | OutroFortificado String
  deriving (Eq, Show)

-- | Categoria principal de um vinho.
data TipoVinho
  = Tinto
  | Branco
  | Rose
  | Espumante
  | Fortificado TipoFortificado
  deriving (Eq, Show)

-- | Características sensoriais que podem coexistir no perfil de um vinho.
data PerfilSabor
  = Leve
  | Encorpado
  | Acido
  | Tanico
  | Doce
  | Frutado
  deriving (Eq, Show)

-- | Ingrediente principal usado pelas regras iniciais de harmonização.
data Ingrediente
  = CarneVermelha
  | Peixe
  | Marisco
  | Massa
  | Queijo
  | Sobremesa
  deriving (Eq, Show)

-- | Intensidade global do prato.
data Intensidade
  = Suave
  | Moderada
  | Intensa
  deriving (Eq, Show)

-- | Dados descritivos e comerciais de uma garrafa.
data Vinho = Vinho
  { nomeVinho :: String
  , produtorVinho :: String
  , anoColheita :: Int
  , regiaoVinho :: Regiao
  , tipoVinho :: TipoVinho
  , teorAlcoolico :: Double
  , precoVinho :: Double
  , castasVinho :: [String]
  , perfisSabor :: [PerfilSabor]
  }
  deriving (Eq, Show)

-- | Prato resumido aos atributos usados pela primeira versão das regras.
data Prato = Prato
  { nomePrato :: String
  , ingredientePrincipal :: Ingrediente
  , nivelGordura :: Int
  , intensidadeSabor :: Intensidade
  }
  deriving (Eq, Show)

-- | Entrada da garrafeira: vinho, número de garrafas e localização física.
data ItemGarrafeira = ItemGarrafeira
  { vinhoItem :: Vinho
  , quantidadeItem :: Int
  , localizacaoItem :: String
  }
  deriving (Eq, Show)

-- | A garrafeira é representada por uma lista de entradas de inventário.
data Garrafeira = Garrafeira
  { itensGarrafeira :: [ItemGarrafeira]
  }
  deriving (Eq, Show)
