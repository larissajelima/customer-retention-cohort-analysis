-- Tabela de clientes

CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY,
    data_cadastro DATE,
    cidade VARCHAR(100),
    estado VARCHAR(50)
);

-- Tabela de pedidos

CREATE TABLE pedidos (
    pedido_id INT PRIMARY KEY,
    cliente_id INT,
    data_pedido DATE,
    valor_total NUMERIC(10,2),
    FOREIGN KEY (cliente_id) 
    REFERENCES clientes(cliente_id)
);