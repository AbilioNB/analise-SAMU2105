install.packages('tidyr')
library('tidyr')

#Bases  1 e 2 
#Remoções
remocoes <- read.csv('Dados SAMU/remocoes2015.csv',sep = ';', na.strings = '') 
# 1
head(remocoes)
cat('Linhas presentes:',length(remocoes$solicitacao_numero))
cat('Valores ausentes :',sum(is.na(remocoes)))
#Conseguimos observar que 4 colunas estao com valores ausentes , com isso vamos retiralas
names(remocoes)
remocoes$chegada_datahora<- NULL
remocoes$saida_datahora<- NULL
remocoes$naoaceitacao_codigo<- NULL
remocoes$naoaceitacao_descricao<- NULL
cat('Linhas presentes:',length(remocoes$solicitacao_numero))
cat('Valores ausentes :',sum(is.na(remocoes)))
names(remocoes)
View(remocoes)










#-------------------------------------------------------------
#Atendimentos
atendimentos <- read.csv('Dados SAMU/solicitacoes2015.csv',sep = ';', na.strings = c(""))
cat('Linhas presentes:',length(atendimentos$solicitacao_numero))
cat('Valores ausentes :',sum(is.na(atendimentos)))
cat('Numero de linhas completas:',length(atendimentos[complete.cases(atendimentos),]))
str(atendimentos)
#1-Eliminar a coluna idademeses
atendimentos$paciente_idademeses <- NULL
cat('Valores ausentes :',sum(is.na(atendimentos)))
#2-
length(which(is.na(atendimentos$sistemasaude_codigo)))
length(which(is.na(atendimentos$motivodescarte_codigo)))
length(which(is.na(atendimentos$tipoocorrencia_codigo)))


length(which(is.na(atendimentos$motivodescarte_descricao)))



total <- length(which(is.na(atendimentos$sistemasaude_codigo)))+length(which(is.na(atendimentos$motivodescarte_codigo)))+length(which(is.na(atendimentos$tipoocorrencia_codigo)))
126463-total


#Para remover da coluna tipoocorrencia_codigo
atendimentos[which(is.na(atendimentos$tipoocorrencia_codigo)), 'tipoocorrencia_codigo'] <- -1
atendimentos$tipoocorrencia_codigo <- as.factor(atendimentos$tipoocorrencia_codigo)

#Para remover da coluna motivodescarte_codigo
atendimentos[which(is.na(atendimentos$motivodescarte_codigo)), 'motivodescarte_codigo'] <- -1
atendimentos$motivodescarte_codigo <- as.factor(atendimentos$motivodescarte_codigo)

#Para remover da coluna sistemasaude_codigo
atendimentos[which(is.na(atendimentos$sistemasaude_codigo)), 'sistemasaude_codigo'] <- -1
atendimentos$sistemasaude_codigo <- as.factor(atendimentos$sistemasaude_codigo)

#Trocando ausentes por nao informado


#Para remover da coluna sistemasaude_descricao
atendimentos[which(is.na(atendimentos$sistemasaude_descricao)), 'sistemasaude_descricao'] <- 'nao_informado'
atendimentos$sistemasaude_descricao <- as.factor(atendimentos$sistemasaude_descricao)

#Para remover da coluna motivodescarte_descricao
atendimentos[which(is.na(atendimentos$motivodescarte_descricao)), 'motivodescarte_descricao'] <- 'nao_informado'
atendimentos$motivodescarte_descricao <- as.factor(atendimentos$motivodescarte_descricao)

#Para remover da coluna data_acionamento
atendimentos[which(is.na(atendimentos$data_acionamento)), 'data_acionamento'] <- 'nao_informado'
atendimentos$data_acionamento <- as.factor(atendimentos$data_acionamento)

#Para remover da coluna data_chegada
atendimentos[which(is.na(atendimentos$data_chegada)), 'data_chegada'] <- 'nao_informado'
atendimentos$data_chegada <- as.factor(atendimentos$data_chegada)

#Para remover da coluna data_remocao
atendimentos[which(is.na(atendimentos$data_remocao)), 'data_remocao'] <- 'nao_informado'
atendimentos$data_remocao <- as.factor(atendimentos$data_remocao)

#Para remover da coluna tipoocorrencia_descricao
atendimentos[which(is.na(atendimentos$tipoocorrencia_descricao)), 'tipoocorrencia_descricao'] <- 'nao_informado'
atendimentos$tipoocorrencia_descricao <- as.factor(atendimentos$tipoocorrencia_descricao)

cat('\nValores ausentes :',sum(is.na(atendimentos)))

#3etapa

#Para remover da coluna datahora_conclusao
atendimentos[which(is.na(atendimentos$datahora_conclusao)), 'datahora_conclusao'] <- 'nao_informado'
atendimentos$datahora_conclusao <- as.factor(atendimentos$datahora_conclusao)




length(which(is.na(atendimentos$data_conclusao)))




