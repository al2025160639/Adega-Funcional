-- | Módulo que define os tipos de dados do domínio do simulador de adega.
module Model -- Declara o nome do módulo que contém estes modelos.
  ( Regiao (..) -- Exporta o tipo Regiao e todos os seus construtores.
  , TipoFortificado (..) -- Exporta o tipo dos estilos de vinho fortificado.
  , TipoVinho (..) -- Exporta as categorias de vinho.
  , PerfilSabor (..) -- Exporta as características sensoriais possíveis.
  , Ingrediente (..) -- Exporta os ingredientes principais dos pratos.
  , Intensidade (..) -- Exporta os níveis de intensidade dos pratos.
  , Vinho (..) -- Exporta o modelo de dados de um vinho.
  , Prato (..) -- Exporta o modelo de dados de um prato.
  , ItemGarrafeira (..) -- Exporta uma entrada individual do inventário.
  , Garrafeira (..) -- Exporta o modelo que representa a garrafeira completa.
  ) where -- Termina a lista de exportações e inicia o conteúdo do módulo.

-- | Regiões vitivinícolas consideradas nesta versão inicial do simulador.
data Regiao -- Define um tipo enumerado para indicar a região de origem.
  = Douro -- Representa a região vitivinícola do Douro.
  | VinhoVerde -- Representa a região dos Vinhos Verdes.
  | Dao -- Representa a região vitivinícola do Dão.
  | Alentejo -- Representa a região vitivinícola do Alentejo.
  | Bairrada -- Representa a região vitivinícola da Bairrada.
  | Lisboa -- Representa a região vitivinícola de Lisboa.
  | PeninsulaDeSetubal -- Representa a região da Península de Setúbal.
  | Algarve -- Representa a região vitivinícola do Algarve.
  deriving (Eq, Show) -- Gera comparação de igualdade (Eq) e conversão para texto (Show).

-- | Subtipo usado para distinguir estilos diferentes de vinho fortificado.
data TipoFortificado -- Define os estilos de vinho fortificado conhecidos pelo modelo.
  = Porto -- Identifica um vinho do estilo do Porto.
  | Moscatel -- Identifica um vinho do estilo Moscatel.
  | OutroFortificado String -- Permite guardar o nome de qualquer outro estilo como texto.
  deriving (Eq, Show) -- Gera comparação de igualdade e representação textual automaticamente.

-- | Categoria principal que classifica um vinho.
data TipoVinho -- Define as categorias gerais disponíveis para classificar os vinhos.
  = Tinto -- Identifica um vinho tinto.
  | Branco -- Identifica um vinho branco.
  | Rose -- Identifica um vinho rosé.
  | Espumante -- Identifica um vinho espumante.
  | Fortificado TipoFortificado -- Identifica um vinho fortificado e guarda o respetivo subtipo.
  deriving (Eq, Show) -- Gera comparação de igualdade e representação textual automaticamente.

-- | Características sensoriais que podem coexistir no perfil de um vinho.
data PerfilSabor -- Define os atributos sensoriais que podem ser associados a um vinho.
  = Leve -- Indica um perfil leve.
  | Encorpado -- Indica um perfil encorpado.
  | Acido -- Indica acidez; o nome do construtor não inclui acento por convenção do código.
  | Tanico -- Indica presença de taninos; o nome não inclui acento por convenção do código.
  | Doce -- Indica um perfil doce.
  | Frutado -- Indica um perfil frutado.
  deriving (Eq, Show) -- Gera comparação de igualdade e representação textual automaticamente.

-- | Ingrediente principal usado pelas regras iniciais de harmonização.
data Ingrediente -- Define os grupos de ingredientes que as regras de harmonização reconhecem.
  = CarneVermelha -- Identifica carne vermelha como ingrediente principal.
  | Peixe -- Identifica peixe como ingrediente principal.
  | Marisco -- Identifica marisco como ingrediente principal.
  | Massa -- Identifica massa como ingrediente principal.
  | Queijo -- Identifica queijo como ingrediente principal.
  | Sobremesa -- Identifica sobremesa como ingrediente principal.
  deriving (Eq, Show) -- Gera comparação de igualdade e representação textual automaticamente.

-- | Intensidade global do prato, usada nas regras de harmonização.
data Intensidade -- Define os níveis de intensidade que podem ser atribuídos a um prato.
  = Suave -- Classifica o prato como suave.
  | Moderada -- Classifica o prato como tendo intensidade moderada.
  | Intensa -- Classifica o prato como intenso.
  deriving (Eq, Show) -- Gera comparação de igualdade e representação textual automaticamente.

-- | Dados descritivos e comerciais associados a uma garrafa de vinho.
data Vinho = Vinho -- Declara o modelo Vinho, com construtor e campos com nome.
  { nomeVinho :: String -- Guarda o nome do vinho; String é uma sequência de caracteres.
  , produtorVinho :: String -- Guarda o nome do produtor.
  , anoColheita :: Int -- Guarda o ano da colheita como número inteiro.
  , regiaoVinho :: Regiao -- Guarda a região de origem usando o modelo Regiao.
  , tipoVinho :: TipoVinho -- Guarda a categoria usando o modelo TipoVinho.
  , teorAlcoolico :: Double -- Guarda o teor alcoólico como número decimal.
  , precoVinho :: Double -- Guarda o preço como número decimal.
  , castasVinho :: [String] -- Guarda uma lista com os nomes das castas usadas no vinho.
  , perfisSabor :: [PerfilSabor] -- Guarda uma lista de características sensoriais do vinho.
  } -- Fecha a lista de campos do modelo Vinho.
  deriving (Eq, Show) -- Permite comparar vinhos e apresentá-los em formato textual.

-- | Prato resumido aos atributos usados pela primeira versão das regras.
data Prato = Prato -- Declara o modelo Prato, com construtor e campos com nome.
  { nomePrato :: String -- Guarda o nome do prato.
  , ingredientePrincipal :: Ingrediente -- Guarda o ingrediente principal usando o modelo Ingrediente.
  , nivelGordura :: Int -- Guarda o nível de gordura como número inteiro.
  , intensidadeSabor :: Intensidade -- Guarda a intensidade usando o modelo Intensidade.
  } -- Fecha a lista de campos do modelo Prato.
  deriving (Eq, Show) -- Permite comparar pratos e apresentá-los em formato textual.

-- | Entrada da garrafeira com o vinho, a quantidade e a localização física.
data ItemGarrafeira = ItemGarrafeira -- Declara uma entrada individual do inventário.
  { vinhoItem :: Vinho -- Guarda os dados do vinho nesta entrada usando o modelo Vinho.
  , quantidadeItem :: Int -- Guarda o número de garrafas desta entrada como inteiro.
  , localizacaoItem :: String -- Guarda a localização física das garrafas como texto.
  } -- Fecha a lista de campos do modelo ItemGarrafeira.
  deriving (Eq, Show) -- Permite comparar entradas e apresentá-las em formato textual.

-- | A garrafeira é representada por uma lista de entradas de inventário.
data Garrafeira = Garrafeira -- Declara o modelo que agrupa o inventário da adega.
  { itensGarrafeira :: [ItemGarrafeira] -- Guarda uma lista de entradas, cada uma no modelo ItemGarrafeira.
  } -- Fecha a lista de campos do modelo Garrafeira.
  deriving (Eq, Show) -- Permite comparar garrafeiras e apresentá-las em formato textual.
