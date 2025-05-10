--Dados da tabela Alunos
INSERT INTO Alunos (nome_aluno, matricula, email, data_nascimento, telefone) VALUES
('Ana Silva', '20231010', 'ana.silva@email.com', '2000-05-15', '(99) 99999-1111'),
('Pedro Souza', '20222020', 'pedro.souza@email.com', '1999-08-22', '(99) 98888-2222'),
('Carla Oliveira', '20243030', 'carla.oliveira@email.com', '2001-03-10', '(99) 97777-3333'),
('Lucas Santos', '20234040', 'lucas.santos@email.com', '2002-11-01', '(99) 96666-4444'),
('Mariana Costa', '20225050', 'mariana.costa@email.com', '2000-07-28', '(99) 95555-5555'),
('Gabriel Pereira', '20246060', 'gabriel.pereira@email.com', '1998-12-05', '(99) 94444-6666'),
('Fernanda Rocha', '20237070', 'fernanda.rocha@email.com', '2001-09-18', '(99) 93333-7777'),
('Mateus Alves', '20228080', 'mateus.alves@email.com', '1999-04-25', '(99) 92222-8888'),
('Isabela Lima', '20249090', 'isabela.lima@email.com', '2003-01-30', '(99) 91111-9999'),
('Rafael Gomes', '20230000', 'rafael.gomes@email.com', '2000-06-12', '(99) 90000-0000');

--Dados da tabela Categorias
INSERT INTO Categorias (nome_categoria, descricao) VALUES
('Ficção', 'Obras de imaginação e narrativa.'),
('Técnico', 'Livros com conteúdo especializado e técnico.'),
('Literatura Brasileira', 'Obras de autores brasileiros.'),
('Literatura Estrangeira', 'Obras de autores de outros países.'),
('História', 'Registros e análises de eventos passados.'),
('Ciências Exatas', 'Livros sobre matemática, física, química'),
('Ciências Humanas', 'Livros sobre sociologia, filosofia, antropologia'),
('Informática', 'Livros sobre computação e tecnologia da informação.'),
('Autoajuda', 'Livros com foco no desenvolvimento pessoal.'),
('Biografia', 'Relatos da vida de pessoas reais.');

--Dados da tabela Livros
INSERT INTO Livros (titulo, autor, id_categoria, quantidade_total, quantidade_disponivel) VALUES
('Dom Casmurro', 'Machado de Assis', 3, 5, 5),
('O Senhor dos Anéis', 'J.R.R. Tolkien', 1, 3, 3),
('Estrutura de Dados e Algoritmos em C', 'Tanenbaum', 8, 2, 2),
('Sapiens: Uma Breve História da Humanidade', 'Yuval Noah Harari', 5, 4, 4),
('A Metamorfose', 'Franz Kafka', 4, 6, 6),
('Cálculo Volume 1', 'James Stewart', 6, 3, 3),
('O Cortiço', 'Aluísio Azevedo', 3, 7, 7),
('Neuromancer', 'William Gibson', 1, 2, 2),
('Introdução à Ciência da Computação', 'Brookshear', 8, 5, 5),
('1984', 'George Orwell', 4, 4, 4);

--Dados da tabela Empréstimo
INSERT INTO Emprestimos (id_aluno, id_livro, data_devolucao_prevista) VALUES
(1, 1, '2025-05-07'),
(2, 3, '2025-05-10'),
(3, 5, '2025-05-15'),
(4, 7, '2025-05-05'),
(5, 9, '2025-05-12'),
(6, 2, '2025-05-09'),
(7, 4, '2025-05-18'),
(8, 6, '2025-05-03'),
(9, 8, '2025-05-11'),
(10, 10, '2025-05-16');

--Dados da tabela Devoluções
INSERT INTO Devolucoes (id_emprestimo) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

-- Inserindo dados na tabela Multas
INSERT INTO Multas (id_emprestimo, valor_multa, data_vencimento) VALUES
(1, 3.50, '2025-05-20'),
(2, 4.00, '2025-05-15'),
(3, 2.50, '2025-05-22'),
(4, 2.00, '2025-05-18'),
(5, 1.50, '2025-05-25'),
(6, 5.50, '2025-05-17'),
(7, 5.00, '2025-05-12'),
(8, 3.00, '2025-05-21'),
(9, 2.50, '2025-05-19'),
(10, 1.00, '2025-05-23');


-- script_atualizar_dados.sql
--Atualizando a tabela Empréstimos com a data de devolução
UPDATE Emprestimos SET data_devolucao_real = (SELECT data_devolucao FROM Devolucoes WHERE Devolucoes.id_emprestimo = Emprestimos.id_emprestimo);


-- script_consultar_dados.sql
--CONSULTAS COM WHERE:
--Listar todos os livros da categoria 'Ficção'.
SELECT titulo, autor
FROM Livros
WHERE id_categoria = (SELECT id_categoria FROM Categorias WHERE nome_categoria = 'Ficção');

--Listar todos os alunos com data de nascimento posterior a 01/01/2000.
SELECT nome_aluno, data_nascimento
FROM Alunos
WHERE data_nascimento > '2000-01-01';

--CONSULTA COM LIKE:
--Listar todos os livros que os títulos começam com 'A'.
SELECT titulo
FROM Livros
WHERE titulo LIKE 'A%';

--CONSULTA COM IN:
--Listar todos os livros das categorias 'Literatura Brasileira' ou 'Literatura Estrangeira'.
SELECT titulo, autor, id_categoria
FROM Livros
WHERE id_categoria IN (SELECT id_categoria FROM Categorias WHERE nome_categoria IN ('Literatura Brasileira', 'Literatura Estrangeira'));

--CONSULTAS COM JOIN:
--Listar o nome do aluno e o título dos livros que eles têm emprestados.
SELECT a.nome_aluno, l.titulo
FROM Emprestimos e
JOIN Alunos a ON e.id_aluno = a.id_aluno
JOIN Livros l ON e.id_livro = l.id_livro;

-- Listar o título dos livros e a categoria a qual pertencem.
SELECT l.titulo, c.nome_categoria
FROM Livros l
JOIN Categorias c ON l.id_categoria = c.id_categoria;

--CONSULTAS COM GROUP BY E HAVING:
--Listar as categorias que têm mais de um livro disponível:
SELECT c.nome_categoria, COUNT(l.id_livro) AS numero_de_livros, SUM(l.quantidade_total) AS total_exemplares
FROM Livros l
JOIN Categorias c ON l.id_categoria = c.id_categoria
GROUP BY c.nome_categoria
HAVING COUNT(l.id_livro) >= 1 AND SUM(l.quantidade_total) > 3;

--Listar as categorias que têm uma quantidade total de exemplares maior que 5.
SELECT c.nome_categoria, SUM(l.quantidade_total) AS total_exemplares
FROM Livros l
JOIN Categorias c ON l.id_categoria = c.id_categoria
GROUP BY c.nome_categoria
HAVING SUM(l.quantidade_total) > 5;

--CONSULTA COM ORDER BY:
--Listar todos os livros ordenados por título em ordem alfabética.
SELECT titulo, autor
FROM Livros
ORDER BY titulo ASC;

--Consulta com COUNT:
--Contar o número total de alunos cadastrados.
SELECT COUNT(*) AS total_alunos
FROM Alunos;