
create database TESTE_JOIN

use teste_join


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
(6,'Secret�ria')

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
(1,5,'Lu�s Pereira',3000),
(2,5,'Ant�nio Almeida',3000),
(3,3,'Donizete Ribeiro',2800),
(4,3,'Grabriela Moura',4700),
(5,2,'Em�lio Duate',5000),
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
(4 ,2 , 'Cl�vis Almeida'),
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
Nome da coluna 'cod_cargo' amb�guo.*/


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
Para associar as tabelas utilizaremos as cl�usulas:

JOIN  ou  INNER JOIN
LEFT JOIN ou LEFT OUTER JOIN
RIGHT JOIN ou RIGHT OUTER JOIN
FULL JOIN ou FULL OUTER JOIN
CROSS JOIN

*/


-- JOIN  ou  INNER JOIN

/*
JOIN OU INNER JOIN

- Tem como caracter�stica retornar apenas as 
linhas em que o campo de relacionamento exista
 em ambas as tabelas. Se o conte�do do campo chave de 
 relacionamento existe em uma tabela, mas n�o existe na
  outra, esta n�o ser� retornada pelo SELECT.

*/

Select f.cod_func, f.nome_func, f.sal_func, c.cod_cargo, c.nome_cargo 
from funcionario f, cargo c


select f.cod_func, f.nome_func,f.sal_func,c.cod_cargo,c.nome_cargo
from funcionario f inner join cargo c
on f.cod_cargo = c.cod_cargo

/*
1	Lu�s Pereira	3000.00	    5	Redator
2	Ant�nio Almeida	3000.00	    5	Redator
3	Donizete Ribeiro	2800.00	3	Supervisor
4	Grabriela Moura	4700.00	    3	Supervisor
5	Em�lio Duate	5000.00	    2	Gerente
6	Carolina Ferreira	9000.00	1	Presidente
*/


-- 	1. Selecionar os funcion�rios e os respectivos dependentes;


select f.nome_func,d.nome_dep -- campos a serem exibidos
from funcionario f join dependente d -- rela��o de tabela
on f.cod_func = d.cod_func --aqui dever� estar a chave estrangeira

/*
Lu�s Pereira	Mariana Pereira
Lu�s Pereira	Camila Pereira
Lu�s Pereira	Eduardo Pereira
Ant�nio Almeida	Cl�vis Almeida
Ant�nio Almeida	Durval Almeida
Em�lio Duate	Fabiana Duarte
Em�lio Duate	Joana Duarte
*/


-- 2 Selecionar o funcionario de codigo 1 com
-- os seu dependentes

select f.nome_func,d.nome_dep
from funcionario f inner join dependente d
on d.cod_func = f.cod_func
where f.cod_func = 1

/*
3. Selecionar os funcion�rios com nome do dependente 
que contenha a s�laba �du�;

*/

select f.nome_func,d.nome_dep
from funcionario f join dependente d
on f.cod_func = d.cod_func
where d.nome_dep like  '%du%'


--Usando cl�usula WHERE no lugar do INNER JOIN

Select f.cod_func, f.nome_func, f.sal_func, c.cod_cargo, c.nome_cargo 
from funcionario f INNER JOIN cargo c on f.cod_cargo = c.cod_cargo

Select f.cod_func, f.nome_func, f.sal_func, c.cod_cargo, c.nome_cargo 
from funcionario f, cargo c 
WHERE  f.cod_cargo = c.cod_cargo

--RIGHT JOIN ou RIGHT OUTER JOIN

/*
RIGHT JOIN ou RIGHT OUTER JOIN
Permite obter n�o apenas os dados relacionados 
de duas tabelas, mas tamb�m os dados n�o-relacionados 
encontrados na tabela � direita da cl�usula JOIN. 
Caso n�o existam dados associados entre as tabelas � esquerda
e � direita de JOIN , ser�o retornados valores nulos.

*/
select f.cod_func,f.nome_func,f.sal_func,
c.cod_cargo,c.nome_cargo from
funcionario f right join cargo c 
on f.cod_cargo=c.cod_cargo

/*LEFT JOIN ou LEFT OUTER JOIN

 Permite obter n�o apenas os dados relacionados 
 de duas tabelas, mas tamb�m os dados n�o-relacionados 
 encontrados na tabela � esquerda da cl�usula JOIN. 
 Caso n�o existam dados associados entre as tabelas � esquerda 
 e � direita de JOIN , ser�o retornados valores nulos.
*/

select f.cod_func,f.nome_func,f.sal_func,
c.cod_cargo,c.nome_cargo from
funcionario f left join cargo c 
on f.cod_cargo=c.cod_cargo

/*
FULL JOIN ou FULL OUTER JOIN

Todas as linhas de dados da tabela � esquerda e
 JOIN e da tabela � direita ser�o retornados pela 
 cl�usula FULL JOIN ou FULL OUTER JOIN.
Caso uma linha de dados n�o  esteja associada 
a qualquer linha da outra tabela , os valores das 
colunas da lista de sele��o ser�o nulos.
*/


select f.cod_func,f.nome_func,f.sal_func,
c.cod_cargo,c.nome_cargo from
funcionario f full join cargo c 
on f.cod_cargo=c.cod_cargo

--4. Selecionar os cargos que N�O TEM funcion�rios associados.

select c.nome_cargo
from funcionario f right join cargo c
on f.cod_cargo = c.cod_cargo
where f.cod_cargo is null

/*CROSS JOIN

Todos os dados da tabela � esquerda de JOIN
 s�o cruzados com os dados da tabela � direita de JOIN,
  tamb�m conhecido como produto cartesiano.
*/

select f.nome_func,c.nome_cargo
from cargo c cross join funcionario f
--ou
SELECT f.nome_func, c.nome_cargo 
FROM cargo c, funcionario f 

SELECT f.nome_func, c.nome_cargo, d.nome_dep 
FROM cargo c CROSS JOIN funcionario f CROSS JOIN dependente d


/*Associando m�ltiplas tabelas
 5. Selecionar nome do funcion�rio, nome do cargo, 
 nome do dependente usando INNER JOIN.
*/

select f.nome_func, c.nome_cargo,d.nome_dep
from funcionario f inner join cargo c 
on f.cod_cargo = c.cod_cargo
   
 inner join dependente  d
 on f.cod_func = d.cod_func
 
 --6. Selecionar nome do funcion�rio, nome do cargo, 
 --nome do dependente usando WHERE.

select f.nome_func, c.nome_cargo,d.nome_dep
from funcionario f,cargo c, dependente d
where f.cod_cargo = c.cod_cargo and f.cod_func = d.cod_func 

/*
Jun��o de produto cartesiano � uma jun��o entre duas
 tabelas que origina uma terceira tabela constitu�da 
 por todos os elementos da primeira combinadas com 
 todos os elementos da segunda.
 
Jun��o Interna todas linhas de uma tabela se relacionam 
com todas as linhas de outras tabelas se elas 
tiverem ao menos 1 campo em comum
 
Jun��o Externa � uma sele��o que n�o requer que os 
registros de uma tabela possuam registros equivalentes em outras

 *Left Outer Join todos os registros da tabela esquerda 
 mesmo quando n�o exista registros correspondentes na tabela direita.
 
  *Right Outer Join todos os registros da tabela direita 
  mesmo quando n�o exista registros correspondentes na tabela esquerda.
  
  *Full Outer Join Esta opera��o apresenta todos os 
  dados das tabelas � esquerda e � direita, 
  mesmo que n�o possuam correspond�ncia em outra tabela
*/


/*
Associando m�ltiplas tabelas
 7. Selecionar nome do funcion�rio, nome do cargo, nome do dependente 
 usando JOIN, incluindo os funcion�rios sem dependentes (LEFT).
*/


select f.nome_func, c.nome_cargo,d.nome_dep 
from funcionario f inner join cargo c
on f.cod_cargo = c.cod_cargo left join dependente d
on f.cod_func = d.cod_func

/*
Associando m�ltiplas tabelas
8. Selecionar nome do funcion�rio, nome do cargo, 
nome do dependente usando JOIN, incluindo os funcion�rios
 sem dependentes e tamb�m os cargos que n�o tem funcion�rios associados.

*/

select f.nome_func, c.nome_cargo,d.nome_dep 
from funcionario f left join dependente d -- FUNC s/ DEP
on f.cod_func = d.cod_func right join cargo c -- CARGO s/ FUNC
on c.cod_cargo = f.cod_cargo
