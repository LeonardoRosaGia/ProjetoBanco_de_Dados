DROP DATABASE banco_de_dados_trefila;
CREATE DATABASE IF NOT EXISTS banco_de_dados_trefila;
USE banco_de_dados_trefila;

CREATE TABLE ordens_producao (
    id_op INT PRIMARY KEY,
    data DATE NOT NULL,
    produto VARCHAR(255) NOT NULL,
    diametro_fio DECIMAL(10, 2) NOT NULL,
    formacao VARCHAR(255) NOT NULL,
    quantidade_bobinas INT NOT NULL,
    quantidade_m_bob DECIMAL(10, 2) NOT NULL
);

CREATE TABLE materia_prima (
    id_materia_prima INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    lote VARCHAR(50) NOT NULL,
    fornecedor VARCHAR(255) NOT NULL,
    id_op INT,
    FOREIGN KEY (id_op) REFERENCES ordens_producao(id_op)
);

CREATE TABLE registros_producao (
    id_registro INT PRIMARY KEY,
    data DATE NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_final TIME NOT NULL,
    metragem DECIMAL(10, 2) NOT NULL,
    operador VARCHAR(255) NOT NULL,
    id_op INT,
    FOREIGN KEY (id_op) REFERENCES ordens_producao(id_op)
);

CREATE TABLE diario_producao_trefila (
    id_diario INT PRIMARY KEY,
    turno VARCHAR(50) NOT NULL,
    operador VARCHAR(255) NOT NULL,
    ordem_producao INT NOT NULL,
    produto VARCHAR(255) NOT NULL,
    bitola VARCHAR(50) NOT NULL,
    diametro_fio DECIMAL(10, 2) NOT NULL,
    numero_fios INT NOT NULL,
    metragem_produzida DECIMAL(10, 2) NOT NULL,
    lote_cobre INT NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (ordem_producao) REFERENCES ordens_producao(id_op),
    FOREIGN KEY (lote_cobre) REFERENCES materia_prima(id_materia_prima)
);

CREATE TABLE motivos_parada (
    id_codigo VARCHAR(50) PRIMARY KEY,
    motivo_descricao VARCHAR(255) NOT NULL
);

CREATE TABLE paradas_motivos (
    id_parada INT PRIMARY KEY,
    horario_inicio TIME NOT NULL,
    horario_final TIME NOT NULL,
    id_codigo VARCHAR(50),
    data DATE NOT NULL,
    turno VARCHAR(50) NOT NULL,
    operador VARCHAR(100) NOT NULL,
    id_diario INT,
    FOREIGN KEY (id_codigo) REFERENCES motivos_parada(id_codigo),
    FOREIGN KEY (id_diario) REFERENCES diario_producao_trefila(id_diario)
);

INSERT INTO ordens_producao( id_op, data, produto, diametro_fio, formacao, quantidade_bobinas, quantidade_m_bob) VALUES
(614, '2024-08-20', 'PP', 0.254, 'formação A', 0, 0);

INSERT INTO materia_prima(id_materia_prima, nome, descricao, lote, fornecedor, id_op) VALUES
(1, 'PP', 'Fio de cobre mole 1,83mm','130824-01', 'Ibrame', 614);

INSERT INTO registros_producao(id_registro, data, horario_inicio, horario_final, metragem, operador, id_op) VALUES
(1, '2024-08-20', '07:10:00', '07:40:00', '20.000', 'Mauro', 614);

INSERT INTO diario_producao_trefila(id_diario, turno, operador, ordem_producao, produto, bitola, diametro_fio, numero_fios, metragem_produzida, lote_cobre, observacoes) VALUES
(1, '1 turno', 'Mauro', 614, 'PP', '2,5', 0.254, 6, 20.000, 1, NULL);

INSERT INTO motivos_parada(id_codigo, motivo_descricao) VALUES
(01, 'outros'),
(02,'Rompimento'),
(03,'Troca Bobina'),
(04, 'Troca Alimentacao'),
(05, 'Troca Bitola'),
(06, 'Manutencao Preventiva'),
(07, 'Manutençao Corretiva'),
(08,'Falta de Bobina Vazia'),
(09,'Falta de Operador'),
(10, 'Falta de Alimentacao'),
(11, 'Sem Programacao'),
(12, 'Limpeza Maquina'),
(13, 'Limpeza do Setor'),
(14, 'Falta Energia'),
(15, 'Horario de Pico'),
(16, 'Refeicao'),
(17, 'Treinamento'),
(18, 'Reuniao'),
(21, 'Falha Bobina');

INSERT INTO paradas_motivos(id_parada, horario_inicio, horario_final, id_codigo, data, turno, operador, id_diario) VALUES
(1, '07:40:00', '08:10:00', 03 , '2024-08-20', '1 turno', 'Mauro', 1 );

SELECT * FROM ordens_producao;
SELECT * FROM materia_prima;
SELECT * FROM diario_producao_trefila;
SELECT * FROM motivos_parada;
SELECT * FROM paradas_motivos;
SELECT * FROM registros_producao;
