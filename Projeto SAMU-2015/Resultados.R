chamados_samu_2015 <- merge(x=remocoes,y=atendimentos)
atendimentos
library("dplyr")
install.packages("lubridate")
library("lubridate")

library("dplyr")
library("stringr")
library("tm")
library("wordcloud")
library("RColorBrewer")
library("lubridate")
#--------------------------------------------------------
#1- Tipos de Ocorrencia
tipos_ocorrencia_set = select(atendimentos, tipoocorrencia_descricao)
tipos <-unique(tipos_ocorrencia_set$tipoocorrencia_descricao) 
tipos <- tipos[-2]
quantidade_ocorrencia <-mapply(FUN = quantidade <- function(tipo) {
  return(sum(tipos_ocorrencia_set$tipoocorrencia_descricao==tipo))
},tipos)

quantidade_ocorrencia <- data_frame(tipo_ocorrencia = tipos,quantidade = quantidade_ocorrencia)  
quantidade_ocorrencia
colors = rainbow(length(quantidade_ocorrencia$tipo_ocorrencia))
data.matrix(quantidade_ocorrencia)[4]

barplot(data.matrix(quantidade_ocorrencia)[4:6],main = 'Ocorrencias registradas',col=colors,xlab = 'Tipo de Ocorrencia',ylab='Quantidade da Ocorrencia')
legend('topright',pch=10,legend = quantidade_ocorrencia$tipo_ocorrencia,col= colors)


#---------------------------------------------------------------------
#2-Sistema de saude descricao
tipos_doenca_set = select(atendimentos, sistemasaude_descricao)
doencas <- unique(tipos_doenca_set$sistemasaude_descricao)
doencas <- doencas[-2]
doencas_ocorrencia <-mapply(FUN = quantidade <- function(tipo) {
  return(sum(tipos_doenca_set$sistemasaude_descricao==tipo))
},doencas)
doencas_registradas <- data_frame(doenca =doencas,quantidade = doencas_ocorrencia)

doencas_registradas

corpus_doenca <- Corpus(VectorSource(doencas_registradas$doenca))
corpus_doenca <- tm_map(corpus_doenca, tolower)
matriz_doenca <- as.matrix(TermDocumentMatrix(corpus_doenca))
wordcloud(corpus_doenca,min.freq = 200,max.words = 25, random.order = FALSE, rot.per = 0.35, colors =c("red",'purple'))


#---------------------------------------------------------------------
#3-Origem do chamado
origem_set <- select(atendimentos,origemchamado_descricao)
origens <- unique(origem_set$origemchamado_descricao)
origem_ocorrencia <-mapply(FUN = quantidade <- function(tipo) {
  return(sum(origem_set$origemchamado_descricao==tipo))
},origens)
origens_registradas <- data_frame(origem = origens,quantidade = origem_ocorrencia)
origens_registradas$quantidade

pcem <-round(origens_registradas$quantidade/sum(origens_registradas$quantidade)*100)
label_pcem <- paste(origens_registradas$origem, pcem)
label_pcem <- paste(label_pcem,"%",sep="")
pie(main = "Origens dos chamados realizados",origens_registradas$quantidade,labels = label_pcem,col=rainbow(length(origens_registradas$quantidade)))
legend("topright",legend= origens_registradas$origem,cex = 0.6, fill = rainbow(length(origens_registradas$quantidade)))



#--------------------------------------------
#4- Tentando trabalhar com datas
#Vamos criar um dataset sobre localidade e tempo.

tempo_localidade_set <- select(atendimentos,solicitacao_data,bairrosaude_codigo,data_acionamento,data_conclusao,tipoocorrencia_descricao,situacaosolicitacao_descricao)
#Removendo as linhas com nao informado e que nao tiveram atendimento concluido
tempo_localidade_set <- subset(tempo_localidade_set,tempo_localidade_set$data_conclusao!='nao_informado'&tempo_localidade_set$situacaosolicitacao_descricao=='CONCLUIDA')
#Chamando o dataset para indentificar a localidade
tempo_localidade_set <- merge(x=tempo_localidade_set,y=base_localidade)
#Buscando o tempo medio dos municipios
municipio_chamado <- unique(tempo_localidade_set$municipio_descricao)
tempo_m <- function(municipio){
  tempo_mun <- 0 
  mun_base <- subset(tempo_localidade_set,tempo_localidade_set$municipio_descricao==municipio)
  tempo_mun <- as.numeric(difftime(mun_base$data_conclusao,mun_base$solicitacao_data,units = 'mins'))
  med <- format(round(mean(tempo_mun),2), nsmall = 2)
  ifelse(length(tempo_mun)>100,return(med),return(-1))
}

municipio_tempo_medio <- tempo_atendimento<- sapply(FUN = tempo_m ,municipio_chamado)
municipio_tempo_medio_atendimento <- data_frame(municipio = municipio_chamado,quantidade = municipio_tempo_medio)
#Removendo aqueles que não tiveram 100 atendimentos
municipio_tempo_medio_atendimento <- subset(municipio_tempo_medio_atendimento,municipio_tempo_medio_atendimento$quantidade>0)
municipio_tempo_medio_atendimento

#----------------------------------------
#5- 

sum(atendimentos$acompanhamento_medico=='S'&atendimentos$tipoocorrencia_descricao=='Remoção')


#6- Cidades com + 

