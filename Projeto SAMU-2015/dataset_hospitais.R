install.packages("tm")
install.packages("wordcloud")
install.packages("RColorBrewer")
### Carregando os pacotes
library("tm")
library("wordcloud")
library("RColorBrewer")
#Base 4
#Perfil de especialidades medicas
#Carregando perfil de especialidades medicas
perfil_espec_medicas <- read.csv('Dados SAMU/especialidademedica2015.csv',sep = ';',strip.white = T,na.strings = " ")


lista_de_especialidades <- unique(perfil_espec_medicas$especialidade_descricao)

length(unique(perfil_espec_medicas$hospital_codigo))



#Base 3 
#Perfil Hospitais
perfil_hospitais <- read.csv('Dados SAMU/hospital2015.csv',sep = ';',strip.white = T,na.strings = " ")



#Merge das bases sendo guiado por hospital_codigo
base_hospitais <- merge(x=perfil_espec_medicas,y=perfil_hospitais)

#Carregando a base dos bairros
dataset_bairro <- read.csv('Dados SAMU/bairro2015.csv',sep = ';',strip.white = T,na.strings = " ")

#Base hospital com bairros
base_hospital_bairro <- merge(x=base_hospitais,y=dataset_bairro)
View(base_hospital_bairro)

#Base de dados de distritos
dataset_distritos <- read.csv('Dados SAMU/distrito2015.csv',sep = ';',strip.white = T,na.strings = " ")

#Base hospitais e distritos
base_medica_localidade <- merge(x=base_hospital_bairro,y=dataset_distritos)


names(base_medica_localidade)
#Removendo algumas colunas desse dataset 
base_medica_localidade$bairrosaude_codigo<- NULL
base_medica_localidade$municipio_codigo<- NULL

#Gerar contador de especialidades

View(base_medica_localidade)

#Vamos visualizar dado uma cidade visualizar sua especialidade 
#Vamos tomar jaboatao como cidade 
unique(base_hospitais$especialidade_descricao)









gerar_wolrdcloud_espcialidade_municipio = function(nome_municipio){
  especialidades <- subset(base_medica_localidade,base_medica_localidade$municipio_descricao==nome_municipio)
  corpus_especialidade <- Corpus(VectorSource(especialidades$especialidade_descricao))
  corpus_especialidadeo <- tm_map(corpus_especialidade, tolower)
  corpus_especialidade <-tm_map(corpus_especialidade, removePunctuation)
  corpus_especialidade <-tm_map(corpus_especialidade, stripWhitespace)
  matriz_especialidades <- as.matrix(TermDocumentMatrix(corpus_especialidade))
  wordcloud(corpus_especialidade,min.freq = 1,max.words = 50, random.order = FALSE, rot.per = 0.35, colors =rainbow(8))
}
gerar_wolrdcloud_espcialidade_municipio('Recife')



