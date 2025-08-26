-- Ativa foreign keys no inicio do script
PRAGMA foreign_kets = NO;

-- Tabela usuario
CREATE TABLE usuario(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT NOT NULL,
    senha TEXT NOT NULL
);

-- Tabela cliente
CREATE TABLE cliente(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    telefone TEXT,
    usuario_id INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE CASCADE 
);

--Tabela produto
CREATE TABLE produto(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    preco REAL NOT NULL CHECK (preco >=0)
);

CREATE TABLE venda(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data TEXT NOT NULL, 
    usuario_id INTEGER NOT NULL,
    cliente_id  INTEGER NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE CASCADE,
    FOREIGN KEY (cliente_id) REFERENCES cliente (id) ON DELETE CASCADE
);

--Tabela venda_produto tabela associativa para N:M produto <-> venda
CREATE TABLE venda_produto(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    venda_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario REAL NOT NULL CHECK (preco_unitario >=0),
    --PRIMARY KEY (venda_id, produto_id), -- chave primaria composta
    FOREIGN KEY (venda_id) REFERENCES venda (id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produto (id) ON DELETE CASCADE
);