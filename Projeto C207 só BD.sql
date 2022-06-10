-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bdxadrez
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bdxadrez
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdxadrez` DEFAULT CHARACTER SET utf8 ;
USE `bdxadrez` ;

-- -----------------------------------------------------
-- Table `bdxadrez`.`Organizador`
-- -----------------------------------------------------
SET SQL_SAFE_UPDATES = 0;
CREATE TABLE IF NOT EXISTS `bdxadrez`.`Organizador` (
  `idOrganizador` INT NOT NULL,
  PRIMARY KEY (`idOrganizador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdxadrez`.`Participante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdxadrez`.`Participante` (
  `Nome` VARCHAR(45) NOT NULL,
  `Cpf` VARCHAR(45) NOT NULL,
  `Idade` VARCHAR(45) NOT NULL,
  `Sexo` VARCHAR(45) NOT NULL,
  `Cidade` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `País` VARCHAR(45) NOT NULL,
  `Organizador_idOrganizador` INT NOT NULL,
  PRIMARY KEY (`Cpf`),
  INDEX `fk_Participante_Organizador1_idx` (`Organizador_idOrganizador` ASC) VISIBLE,
  CONSTRAINT `fk_Participante_Organizador1`
    FOREIGN KEY (`Organizador_idOrganizador`)
    REFERENCES `bdxadrez`.`Organizador` (`idOrganizador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdxadrez`.`Partida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdxadrez`.`Partida` (
  `idPartida` INT NOT NULL,
  `Mesa_idMesa` INT NOT NULL,
  `Modalidade_idModalidade` INT NOT NULL,
  PRIMARY KEY (`idPartida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdxadrez`.`Premiação`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdxadrez`.`Premiação` (
  `idPremiação` INT NOT NULL,
  `Resultado` VARCHAR(45) NOT NULL,
  `Modalidade_idModalidade` VARCHAR(45) NOT NULL,
  `Organizador_idOrganizador` INT NOT NULL,
  PRIMARY KEY (`idPremiação`),
  INDEX `fk_Premiação_Organizador1_idx` (`Organizador_idOrganizador` ASC) VISIBLE,
  CONSTRAINT `fk_Premiação_Organizador1`
    FOREIGN KEY (`Organizador_idOrganizador`)
    REFERENCES `bdxadrez`.`Organizador` (`idOrganizador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdxadrez`.`Participante_has_Partida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdxadrez`.`Participante_has_Partida` (
  `Participante_Cpf` VARCHAR(45) NOT NULL,
  `Partida_idPartida` INT NOT NULL,
  PRIMARY KEY (`Participante_Cpf`, `Partida_idPartida`),
  INDEX `fk_Participante_has_Partida_Partida1_idx` (`Partida_idPartida` ASC) VISIBLE,
  INDEX `fk_Participante_has_Partida_Participante1_idx` (`Participante_Cpf` ASC) VISIBLE,
  CONSTRAINT `fk_Participante_has_Partida_Participante1`
    FOREIGN KEY (`Participante_Cpf`)
    REFERENCES `bdxadrez`.`Participante` (`Cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Participante_has_Partida_Partida1`
    FOREIGN KEY (`Partida_idPartida`)
    REFERENCES `bdxadrez`.`Partida` (`idPartida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


ALTER TABLE bdxadrez.participante add colocacao varchar(10);
alter table bdxadrez.participante drop column país;
alter table bdxadrez.premiação drop column Modalidade_idModalidade;
#criando o organizador para o torneio masculino
insert into bdxadrez.organizador values('1');
insert into  bdxadrez.participante values('Pedro','123','20','M','Rio Bonito','RJ','1','1');
insert into  bdxadrez.participante values('Gabriel','122','20','M','Rio Bonito','RJ','1','2');
insert into bdxadrez.participante values('Carlos','145','22','M','itajubá','RJ','1','3');
insert into bdxadrez.participante values('Guilherme','135','21','M','Pouso Alegre','MG','1','4');
update bdxadrez.participante set Cidade = 'Pouso Alegre' where Cpf = 122;
update bdxadrez.participante set Estado ='MG' where cpf = 122;
#tabela do torneio masculino
select nome,colocacao as 'Torneio Masculino' from participante as p ,organizador as o where o.idOrganizador=p.Organizador_idOrganizador and idOrganizador = '1';

#primeira partida masculino
insert into bdxadrez.partida values('1','1','1'); 
select nome as'vencedor da primeira partida' from participante  as p, organizador as o where o.idOrganizador=p.Organizador_idOrganizador and  colocacao = '1' and idOrganizador= '1';                                                       

#segunda partida masculino
insert into bdxadrez.partida values('2','2','1');
select nome as'vencedor da segunda partida' from participante  as p, organizador as o where o.idOrganizador=p.Organizador_idOrganizador and  colocacao = '2' and idOrganizador= '1';                                                       

#partida para decidir o terceiro/quarto colocado masculino 
insert into bdxadrez.partida values('3','3','1'); 
select nome as'terceiro colocado' from participante  as p, organizador as o where o.idOrganizador=p.Organizador_idOrganizador and  colocacao = '3' and idOrganizador= '1';                                                       
select nome as'quarto colocado' from participante  as p, organizador as o where o.idOrganizador=p.Organizador_idOrganizador and  colocacao = '4' and idOrganizador= '1';                                                       

#parida para decidir o campão masculino
insert into bdxadrez.partida values('4','4','1'); 
select p.nome as 'campeão masculino' from participante as p, organizador as o where o.idOrganizador = p.Organizador_idOrganizador and idOrganizador = '1' and p.colocacao = '1';



#inserindo o segubndo organizador para o torneio feminino
insert into bdxadrez.organizador values('2');

insert into bdxadrez.participante values('Fernanda','258','22','F','Santa Rita do Sapucí','MG','2','3');
insert into bdxadrez.participante values('Joana','230','20','F','Niterói','RJ','2','4');
INSERT INTO bdxadrez.participante values('Maria','280','21','F','Pouso Alegre','MG','2','1');
insert INTO bdxadrez.participante values('Lia','250','22','F','São Paulo','SP','2','2');
update bdxadrez.participante set Cidade = 'Pouso Alegre' where Cpf = 230;
update bdxadrez.participante set Estado='MG' where cpf = 230;
#mostrando a tabela do torneio feminino
select p.nome,colocacao as 'Torneio Feminino' from participante as p ,organizador as o where o.idOrganizador=p.Organizador_idOrganizador and idOrganizador = '2';

#primeira partida do torneio feminino
insert into bdxadrez.partida values('5','5','2');
select p.nome,colocacao as 'Vencedora da primeira partida' from participante as p ,organizador as o where o.idOrganizador=p.Organizador_idOrganizador and idOrganizador = '2' and colocacao = '1';

#segunda partida do torneio feminino
insert into bdxadrez.partida values('6','6','2');
select p.nome,colocacao as 'Vencedora da segunda partida' from participante as p ,organizador as o where o.idOrganizador=p.Organizador_idOrganizador and idOrganizador = '2' and colocacao = '2';

#patida para definir o terceiro/quarto colocado feminino
insert into bdxadrez.partida values('7','7','2');
select p.nome,colocacao as 'Terceira colocada' from participante as p ,organizador as o where o.idOrganizador=p.Organizador_idOrganizador and idOrganizador = '2' and colocacao = '3';
select p.nome,colocacao as 'Torneio Feminino' from participante as p ,organizador as o where o.idOrganizador=p.Organizador_idOrganizador and idOrganizador = '2' and colocacao = '4';

#criando tabelas do campeonato
#criando partida para cameã feminina
insert into bdxadrez.partida values('8','8','2');
select nome as 'campeã feminina' from participante as p, organizador as o where o.idOrganizador = p.Organizador_idOrganizador and idOrganizador = '2' and p.colocacao = '1';




