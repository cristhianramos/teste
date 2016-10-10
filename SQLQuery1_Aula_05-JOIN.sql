
create database TESTE_JOIN

use teste_join


create table CARGO
(
   cod_cargo int,
   nome_cargo varchar(50),
   
   constraint pk_cargo primary key (cod_cargo),
   
   constraint uq_cargo_nome_cargo unique (nome_cargo)
)

insert into cargo values
(1,'Presidente'),
(2,'Gerente'),
(3,'Supervisor'),
(4,'Revisor'),
(5,'Redator'),
(6,'Secretária')

select*from cargo

create table FUNCIONARIO
(
  cod_func int,
  cod_cargo int,
  nome_func varchar(50),
  sal_func decimal(10,2) default 0,
  
  constraint pk_funcionario primary key (cod_func),
  
  constraint fk_funcionario_cargo 
  foreign key (cod_cargo) 
  references cargo (cod_cargo),
  
  constraint ch_funcionario_sal_func 
  check (sal_func >= 0)
   
)

insert into funcionario values
(1,5,'Luís Pereira',3000),
(2,5,'Antônio Almeida',3000),
(3,3,'Donizete Ribeiro',2800),
(4,3,'Grabriela Moura',4700),
(5,2,'Emílio Duate',5000),
(6,1,'Carolina Ferreira',9000)


select*from funcionario

create table  DEPENDENTE
(
  cod_dep int,
  cod_func int,
  nome_dep varchar (50),
  
  constraint pk_dependente primary key (cod_dep),
  constraint fk_dependente_funcionario 
  foreign key (cod_func)
  references funcionario (cod_func)
   
)

INSERT Dependente values 
(1 ,1 , 'Mariana Pereira'),
(2 ,1 , 'Camila Pereira' ),
(3 ,1 , 'Eduardo Pereira' ),
(4 ,2 , 'Clóvis Almeida'),
(5 ,2 , 'Durval Almeida'),
(6 ,5 , 'Fabiana Duarte' ),
(7 ,5 , 'Joana Duarte' )

select*from funcionario
select*from dependente

insert funcionario values
(07,null,'Luiz Henrique',5000)

-- juntar duas tabelas

select*from funcionario,cargo

Select nome_func, cod_cargo, nome_cargo 
from funcionario,cargo
/*ERRO
Nome da coluna 'cod_cargo' ambíguo.*/


/*select <nome da tabela>.<nome do campo>,funcionario.cod_cargo,
cargo.nome_cargo from <tabela>,<tabela>*/
select funcionario.nome_func,funcionario.cod_cargo,
cargo.nome_cargo from funcionario,cargo

--ou

select nome_func,f.cod_cargo,nome_cargo
from funcionario f, cargo c

Select nome_func, funcionario.cod_cargo, nome_cargo from funcionario,cargo

Select nome_func, f.cod_cargo, nome_cargo from funcionario f, cargo c

Select f.cod_func, f.nome_func, f.sal_func, c.cod_cargo, c.nome_cargo 
from funcionario f, cargo c

/*
Para associar as tabelas utilizaremos as cláusulas:

JOIN  ou  INNER JOIN
LEFT JOIN ou LEFT OUTER JOIN
RIGHT JOIN ou RIGHT OUTER JOIN
FULL JOIN ou FULL OUTER JOIN
CROSS JOIN

*/


-- JOIN  ou  INNER JOIN

/*
JOIN OU INNER JOIN

- Tem como característica retornar apenas as 
linhas em que o campo de relacionamento exista
 em ambas as tabelas. Se o conteúdo do campo chave de 
 relacionamento existe em uma tabela, mas não existe na
  outra, esta não será retornada pelo SELECT.

*/

Select f.cod_func, f.nome_func, f.sal_func, c.cod_cargo, c.nome_cargo 
from funcionario f, cargo c


select f.cod_func, f.nome_func,f.sal_func,c.cod_cargo,c.nome_cargo
from funcionario f inner join cargo c
on f.cod_cargo = c.cod_cargo

/*
1	Luís Pereira	3000.00	    5	Redator
2	Antônio Almeida	3000.00	    5	Redator
3	Donizete Ribeiro	2800.00	3	Supervisor
4	Grabriela Moura	4700.00	    3	Supervisor
5	Emílio Duate	5000.00	    2	Gerente
6	Carolina Ferreira	9000.00	1	Presidente
*/


-- 	1. Selecionar os funcionários e os respectivos dependentes;


select f.nome_func,d.nome_dep -- campos a serem exibidos
from funcionario f join dependente d -- relação de tabela
on f.cod_func = d.cod_func --aqui deverá estar a chave estrangeira

/*
Luís Pereira	Mariana Pereira
Luís Pereira	Camila Pereira
Luís Pereira	Eduardo Pereira
Antônio Almeida	Clóvis Almeida
Antônio Almeida	Durval Almeida
Emílio Duate	Fabiana Duarte
Emílio Duate	Joana Duarte
*/


-- 2 Selecionar o funcionario de codigo 1 com
-- os seu dependentes

select f.nome_func,d.nome_dep
from funcionario f inner join dependente d
on d.cod_func = f.cod_func
where f.cod_func = 1

/*
3. Selecionar os funcionários com nome do dependente 
que contenha a sílaba ‘du’;

*/

select f.nome_func,d.nome_dep
from funcionario f join dependente d
on f.cod_func = d.cod_func
where d.nome_dep like  '%du%'


--Usando cláusula WHERE no lugar do INNER JOIN

Select f.cod_func, f.nome_func, f.sal_func, c.cod_cargo, c.nome_cargo 
from funcionario f INNER JOIN cargo c on f.cod_cargo = c.cod_cargo

Select f.cod_func, f.nome_func, f.sal_func, c.cod_cargo, c.nome_cargo 
from funcionario f, cargo c 
WHERE  f.cod_cargo = c.cod_cargo

--RIGHT JOIN ou RIGHT OUTER JOIN

/*
RIGHT JOIN ou RIGHT OUTER JOIN
Permite obter não apenas os dados relacionados 
de duas tabelas, mas também os dados não-relacionados 
encontrados na tabela à direita da cláusula JOIN. 
Caso não existam dados associados entre as tabelas à esquerda
e à direita de JOIN , serão retornados valores nulos.

*/
select f.cod_func,f.nome_func,f.sal_func,
c.cod_cargo,c.nome_cargo from
funcionario f right join cargo c 
on f.cod_cargo=c.cod_cargo

/*LEFT JOIN ou LEFT OUTER JOIN

 Permite obter não apenas os dados relacionados 
 de duas tabelas, mas também os dados não-relacionados 
 encontrados na tabela à esquerda da cláusula JOIN. 
 Caso não existam dados associados entre as tabelas à esquerda 
 e à direita de JOIN , serão retornados valores nulos.
*/

select f.cod_func,f.nome_func,f.sal_func,
c.cod_cargo,c.nome_cargo from
funcionario f left join cargo c 
on f.cod_cargo=c.cod_cargo

/*
FULL JOIN ou FULL OUTER JOIN

Todas as linhas de dados da tabela à esquerda e
 JOIN e da tabela à direita serão retornados pela 
 cláusula FULL JOIN ou FULL OUTER JOIN.
Caso uma linha de dados não  esteja associada 
a qualquer linha da outra tabela , os valores das 
colunas da lista de seleção serão nulos.
*/


select f.cod_func,f.nome_func,f.sal_func,
c.cod_cargo,c.nome_cargo from
funcionario f full join cargo c 
on f.cod_cargo=c.cod_cargo

--4. Selecionar os cargos que NÃO TEM funcionários associados.

select c.nome_cargo
from funcionario f right join cargo c
on f.cod_cargo = c.cod_cargo
where f.cod_cargo is null

/*CROSS JOIN

Todos os dados da tabela à esquerda de JOIN
 são cruzados com os dados da tabela à direita de JOIN,
  também conhecido como produto cartesiano.
*/

select f.nome_func,c.nome_cargo
from cargo c cross join funcionario f
--ou
SELECT f.nome_func, c.nome_cargo 
FROM cargo c, funcionario f 

SELECT f.nome_func, c.nome_cargo, d.nome_dep 
FROM cargo c CROSS JOIN funcionario f CROSS JOIN dependente d


/*Associando múltiplas tabelas
 5. Selecionar nome do funcionário, nome do cargo, 
 nome do dependente usando INNER JOIN.
*/

select f.nome_func, c.nome_cargo,d.nome_dep
from funcionario f inner join cargo c 
on f.cod_cargo = c.cod_cargo
   
 inner join dependente  d
 on f.cod_func = d.cod_func
 
 --6. Selecionar nome do funcionário, nome do cargo, 
 --nome do dependente usando WHERE.

select f.nome_func, c.nome_cargo,d.nome_dep
from funcionario f,cargo c, dependente d
where f.cod_cargo = c.cod_cargo and f.cod_func = d.cod_func 

/*
Junção de produto cartesiano é uma junção entre duas
 tabelas que origina uma terceira tabela constituída 
 por todos os elementos da primeira combinadas com 
 todos os elementos da segunda.
 
Junção Interna todas linhas de uma tabela se relacionam 
com todas as linhas de outras tabelas se elas 
tiverem ao menos 1 campo em comum
 
Junção Externa é uma seleção que não requer que os 
registros de uma tabela possuam registros equivalentes em outras

 *Left Outer Join todos os registros da tabela esquerda 
 mesmo quando não exista registros correspondentes na tabela direita.
 
  *Right Outer Join todos os registros da tabela direita 
  mesmo quando não exista registros correspondentes na tabela esquerda.
  
  *Full Outer Join Esta operação apresenta todos os 
  dados das tabelas à esquerda e à direita, 
  mesmo que não possuam correspondência em outra tabela
*/


/*
Associando múltiplas tabelas
 7. Selecionar nome do funcionário, nome do cargo, nome do dependente 
 usando JOIN, incluindo os funcionários sem dependentes (LEFT).
*/


select f.nome_func, c.nome_cargo,d.nome_dep 
from funcionario f inner join cargo c
on f.cod_cargo = c.cod_cargo left join dependente d
on f.cod_func = d.cod_func

/*
Associando múltiplas tabelas
8. Selecionar nome do funcionário, nome do cargo, 
nome do dependente usando JOIN, incluindo os funcionários
 sem dependentes e também os cargos que não tem funcionários associados.

*/

select f.nome_func, c.nome_cargo,d.nome_dep 
from funcionario f left join dependente d -- FUNC s/ DEP
on f.cod_func = d.cod_func right join cargo c -- CARGO s/ FUNC
on c.cod_cargo = f.cod_cargo
