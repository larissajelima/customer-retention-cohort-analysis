INSERT INTO clientes (cliente_id, data_cadastro, cidade, estado) VALUES
(1,'2024-01-03','São Paulo','SP'),
(2,'2024-01-10','Campinas','SP'),
(3,'2024-02-01','Rio de Janeiro','RJ'),
(4,'2024-02-15','Belo Horizonte','MG'),
(5,'2024-03-05','Curitiba','PR');

INSERT INTO pedidos (pedido_id, cliente_id, data_pedido, valor_total) VALUES
(1,1,'2024-01-05',120.00),
(2,1,'2024-02-10',80.00),
(3,1,'2024-04-02',150.00),
(4,2,'2024-01-12',200.00),
(5,2,'2024-02-18',90.00),
(6,3,'2024-02-05',50.00),
(7,3,'2024-03-10',70.00),
(8,4,'2024-02-20',130.00),
(9,5,'2024-03-07',60.00),
(10,5,'2024-04-10',100.00);