CREATE DATABASE escola;
USE escola;

CREATE TABLE alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    status_matricula ENUM('Ativo', 'Concluído', 'Trancado') NOT NULL,
    data_matricula DATE NOT NULL
);
INSERT INTO alunos (nome, data_nascimento, status_matricula, data_matricula)
VALUES 
('João Silva', '2005-04-15', 'Ativo', '2024-02-01'),
('Maria Oliveira', '2004-06-20', 'Concluído', '2023-08-15'),
('Pedro Santos', '2003-09-10', 'Trancado', '2022-10-10');


-- 1
SELECT *
FROM alunos
ORDER BY nome ASC, data_nascimento DESC; 

CREATE TABLE professores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    especialidade VARCHAR(255)
);
INSERT INTO professores (nome, especialidade)
VALUES 
('Carlos Pereira', 'Matemática'),
('Fernanda Costa', 'Física'),
('Joana Lima', 'Química');


-- 2
SELECT nome, especialidade
FROM professores
ORDER BY nome DESC;

CREATE TABLE disciplinas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    carga_horaria INT NOT NULL,
    curso_id INT NOT NULL,
    professor_id INT NOT NULL,
    FOREIGN KEY (curso_id) REFERENCES cursos(id),
    FOREIGN KEY (professor_id) REFERENCES professores(id)
);
INSERT INTO disciplinas (nome, carga_horaria, curso_id, professor_id)
VALUES 
('Cálculo I', 80, 1, 1),  -- Cálculo I, 80h, curso Engenharia Computacional, professor Carlos Pereira
('Física I', 60, 1, 2),   -- Física I, 60h, curso Engenharia Computacional, professora Fernanda Costa
('Química Geral', 70, 2, 3);  -- Química Geral, 70h, curso Medicina, professora Joana Lima


-- 3
SELECT *
FROM disciplinas
ORDER BY carga_horaria DESC; 

-- 4
SELECT status_matricula, COUNT(*) AS numero_alunos
FROM alunos
GROUP BY status_matricula; 

CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);
INSERT INTO cursos (nome)
VALUES 
('Engenharia Computacional'),
('Medicina'),
('Arquitetura');


-- 5
SELECT cursos.nome, SUM(disciplinas.carga_horaria) AS carga_horaria_total
FROM cursos
JOIN disciplinas ON cursos.id = disciplinas.curso_id
GROUP BY cursos.nome;

CREATE TABLE turmas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    horario VARCHAR(255) NOT NULL,
    disciplina_id INT NOT NULL,
    professor_id INT NOT NULL,
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id),
    FOREIGN KEY (professor_id) REFERENCES professores(id)
);
INSERT INTO turmas (horario, disciplina_id, professor_id)
VALUES 
('Segunda-feira 08:00', 1, 1),
('Terça-feira 10:00', 2, 2),
('Quarta-feira 14:00', 3, 3);


-- 6
SELECT professores.nome
FROM professores
JOIN turmas ON professores.id = turmas.professor_id
GROUP BY professores.nome
HAVING COUNT(turmas.id) > 3;


CREATE TABLE matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT NOT NULL,
    disciplina_id INT NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id)
);
INSERT INTO matriculas (aluno_id, disciplina_id)
VALUES 
(1, 1),  -- João Silva se matricula em Cálculo I
(2, 2),  -- Maria Oliveira se matricula em Física I
(3, 3);  -- Pedro Santos se matricula em Química Geral



-- 7
SELECT alunos.nome, COUNT(disciplinas.id) AS total_disciplinas
FROM alunos
JOIN matriculas ON alunos.id = matriculas.aluno_id
JOIN disciplinas ON matriculas.disciplina_id = disciplinas.id
GROUP BY alunos.nome
HAVING COUNT(disciplinas.id) > 1
ORDER BY total_disciplinas DESC;

-- 8
SELECT professores.nome, COUNT(turmas.id) AS total_turmas
FROM professores
JOIN turmas ON professores.id = turmas.professor_id
GROUP BY professores.nome
ORDER BY total_turmas DESC;

-- 9
SELECT professores.nome, COUNT(turmas.id) AS total_turmas
FROM professores
JOIN turmas ON professores.id = turmas.professor_id
GROUP BY professores.nome
ORDER BY total_turmas DESC;

-- 10
SELECT cursos.nome, AVG(disciplinas.carga_horaria) AS media_carga_horaria
FROM cursos
JOIN disciplinas ON cursos.id = disciplinas.curso_id
GROUP BY cursos.nome;

-- 11
SELECT nome, status_matricula, data_matricula
FROM alunos
ORDER BY status_matricula, data_matricula DESC;

-- 12
SELECT nome, FLOOR(DATEDIFF(CURDATE(), data_nascimento) / 365) AS idade
FROM alunos
ORDER BY idade DESC;

-- 13
SELECT disciplinas.nome, COUNT(matriculas.aluno_id) AS numero_alunos
FROM disciplinas
JOIN matriculas ON disciplinas.id = matriculas.disciplina_id
GROUP BY disciplinas.nome
ORDER BY numero_alunos DESC;

-- 14
SELECT professores.nome AS professor, disciplinas.nome AS disciplina, turmas.horario
FROM turmas
JOIN professores ON turmas.professor_id = professores.id
JOIN disciplinas ON turmas.disciplina_id = disciplinas.id
ORDER BY turmas.horario;

-- 15
SELECT COUNT(*) AS total_disciplinas
FROM disciplinas
WHERE carga_horaria > 80;


-- 16
SELECT cursos.nome, COUNT(disciplinas.id) AS total_disciplinas
FROM cursos
JOIN disciplinas ON cursos.id = disciplinas.curso_id
GROUP BY cursos.nome;

-- 17
SELECT professores.nome
FROM professores
JOIN disciplinas ON professores.id = disciplinas.professor_id
WHERE disciplinas.carga_horaria > 100
GROUP BY professores.nome
HAVING COUNT(disciplinas.id) > 2;


-- 18
SELECT disciplinas.nome
FROM disciplinas
JOIN matriculas ON disciplinas.id = matriculas.disciplina_id
GROUP BY disciplinas.nome
HAVING COUNT(matriculas.aluno_id) >= 5;

-- 19
SELECT status_matricula, COUNT(*) AS numero_alunos
FROM alunos
GROUP BY status_matricula
ORDER BY numero_alunos DESC;

-- 20
SELECT professores.nome, SUM(disciplinas.carga_horaria) AS carga_horaria_total
FROM professores
JOIN disciplinas ON professores.id = disciplinas.professor_id
GROUP BY professores.nome
ORDER BY carga_horaria_total DESC;
 
