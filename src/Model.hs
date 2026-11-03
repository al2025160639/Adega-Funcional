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

-- | Regiões vitivinícolas consideradas pelo simulador.
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

-- | Estilos de vinho fortificado reconhecidos pelo modelo.
data TipoFortificado
  = Porto
  | Moscatel
  | OutroFortificado String
  deriving (Eq, Show)

-- | Categoria principal de um vinho, incluindo o subtipo fortificado.
data TipoVinho
  = Tinto
  | Branco
  | Rose
  | Espumante
  | Fortificado TipoFortificado
  deriving (Eq, Show)

-- | Características sensoriais que podem compor o perfil de um vinho.
data PerfilSabor
  = Leve
  | Encorpado
  | Acido
  | Tanico
  | Doce
  | Frutado
  deriving (Eq, Show)

-- | Ingredientes principais usados pelas regras de harmonização.
data Ingrediente
  = CarneVermelha
  | Peixe
  | Marisco
  | Massa
  | Queijo
  | Sobremesa
  deriving (Eq, Show)

-- | Nível de intensidade global de um prato.
data Intensidade
  = Suave
  | Moderada
  | Intensa
  deriving (Eq, Show)

-- | Informações descritivas e comerciais de um vinho.
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

-- | Dados do prato usados para determinar harmonizações.
data Prato = Prato
  { nomePrato :: String
  , ingredientePrincipal :: Ingrediente
  , nivelGordura :: Int
  , intensidadeSabor :: Intensidade
  }
  deriving (Eq, Show)

-- | Vinho, quantidade de garrafas e localização dentro da garrafeira.
data ItemGarrafeira = ItemGarrafeira
  { vinhoItem :: Vinho
  , quantidadeItem :: Int
  , localizacaoItem :: String
  }
  deriving (Eq, Show)

-- | Inventário da adega, composto por uma lista de itens.
data Garrafeira = Garrafeira
  { itensGarrafeira :: [ItemGarrafeira]
  }
  deriving (Eq, Show)
